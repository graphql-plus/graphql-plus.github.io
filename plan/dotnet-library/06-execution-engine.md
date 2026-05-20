# Stage 6 — Execution Engine

**Package:** `GraphQLPlus.Execution`
**Depends on:** Stages 1, 3, 4, 5

## Goal

Walk a validated `GqlpOperation` against a `GqlpSchema`, invoke user-registered field
resolvers for each selected field, and produce an `IGqlpValue` tree that the response
encoder (Stage 7) can serialise. The engine must handle generics, alternates,
fragment spreading, and directives.

## Resolver registration

Users register field resolvers via `IGqlpSchemaBuilder` (exposed through the ASP.NET
Core DI extension in Stage 8):

```csharp
public interface IGqlpSchemaBuilder
{
    // Register an async resolver for a specific output-type field.
    // TContext is resolved from DI at execution time.
    IGqlpSchemaBuilder Field<TContext>(
        string typeName,
        string fieldName,
        Func<TContext, IGqlpValue?, CancellationToken, ValueTask<IGqlpValue?>> resolver);
}
```

Resolvers are stored in a `GqlpResolverRegistry` keyed by `(typeName, fieldName)`.
The registry is built once at startup and is thread-safe for concurrent reads.

## Execution context

```csharp
public sealed class GqlpExecutionContext<TContext>
{
    public TContext ApplicationContext { get; }
    public GqlpOperation Operation { get; }
    public GqlpSchema Schema { get; }
    public IReadOnlyList<GqlpDiagnostic> Diagnostics { get; }  // accumulated during execution
    public CancellationToken CancellationToken { get; }
    public int CurrentDepth { get; }
}
```

## Executor interface

```csharp
public interface ISchemaExecutor
{
    ValueTask<ExecutionResult> ExecuteAsync(
        GqlpOperation operation,
        IReadOnlyList<IGqlpValue> decodedParameters,
        GqlpSchema schema,
        IServiceProvider services,
        CancellationToken cancellationToken = default);
}

public sealed record ExecutionResult(
    IGqlpValue? Value,
    IReadOnlyList<GqlpDiagnostic> Diagnostics
);
```

## Execution algorithm

```
ExecuteAsync(operation, params, schema, services, ct):
  1. Bind decoded parameters to operation variables → variableMap
  2. Resolve category → GqlpCategory in schema
  3. Resolve root output type from category.OutputType
  4. result = await ExecuteObjectAsync(operation.Result.Object, rootType, null, ctx)
  5. Return ExecutionResult(result, ctx.Diagnostics)

ExecuteObjectAsync(object, outputType, parentValue, ctx):
  resultEntries = {}
  for each selection in object.Selections (in order):
    case GqlpFieldSelection:
      fieldDef  = FindField(outputType, selection.Name)  // traverses parent chain
      resolver  = registry[(outputType.Name, fieldDef.Name)]
      argument  = EvaluateArgument(selection.Argument, variableMap)
      rawValue  = await resolver(appContext, argument, ct)
      coerced   = CoerceValue(rawValue, fieldDef.TypeRef, fieldDef.Modifiers, ctx)
      key       = selection.Alias ?? selection.Name
      if selection.NestedObject is not null:
        nestedType = ResolveOutputType(fieldDef.TypeRef, schema)
        coerced   = await ExecuteObjectAsync(selection.NestedObject, nestedType, coerced, ctx)
      resultEntries[key] = coerced
    case GqlpInlineFragment:
      if TypeConditionMatches(selection.TypeCondition, outputType, schema):
        fragmentResult = await ExecuteObjectAsync(selection.Body, conditionType, parentValue, ctx)
        merge fragmentResult into resultEntries
    case GqlpSpread:
      fragment = operation.Fragments[selection.FragmentName]
      if TypeConditionMatches(fragment.TypeCondition, outputType, schema):
        spreadResult = await ExecuteObjectAsync(fragment.Body, conditionType, parentValue, ctx)
        merge spreadResult into resultEntries
  return GqlpMap(resultEntries, outputType.Name)
```

## Alternate handling

When a resolver returns an `IGqlpValue` whose tag names one of the output type's
alternates, switch to that alternate's type for any nested selection:

1. Identify the alternate type by the returned value's tag.
2. Recursively execute `ExecuteObjectAsync` on the nested object using the alternate type.
3. Return the result tagged with the alternate type name.

## Generic type instantiation

For generic output types (e.g. `output Page<$T: _Any>`), substitute the resolved type
arguments from the field's `GqlpTypeRef` for each `$T` parameter throughout the field
type references before resolving or executing. A `GenericTypeInstantiator` utility
performs this substitution, producing a concrete `GqlpOutputType` at execution time.

## Modifier coercion

After a resolver returns `rawValue`, apply modifiers (outermost to innermost):

| Modifier | Rule |
|----------|------|
| `Optional` | `null` raw → `GqlpNull`; non-null passes through |
| `List` | wrap in `GqlpList`; coerce each element |
| `Dict(K)` | wrap in `GqlpMap`; coerce each key and value |

If a non-optional field receives `null`, record an error and substitute `GqlpNull`
to allow execution to continue and collect further errors.

## Depth limit

`ctx.CurrentDepth` is incremented on each `ExecuteObjectAsync` call. If it exceeds
`GqlpOptions.MaxExecutionDepth` (default 32), record an error and return `GqlpNull`
without invoking further resolvers.

## Error handling

- Resolver throws a non-cancellation exception → record error, return `GqlpNull` for
  that field. Execution continues for sibling fields.
- `OperationCanceledException` propagates immediately.

## Tests

- Execute `samples/StarWars/` queries against a hand-coded StarWars field resolver set
  and compare results to the expected YAML in `samples/StarWars/*.yaml`
- Execute `samples/Operation/*.gql+` against a minimal test schema with stub resolvers
- Unit test generic type instantiation with `_Opt<T>`, `_List<T>`, `_Dict<K, T>`
- Unit test fragment spreading and inline fragments with and without type conditions
- Unit test depth limit enforcement
- Unit test null-for-non-optional field records an error but continues execution
- Unit test resolver exception records an error and continues execution
