# Stage 5 — Request Decoding

**Package:** `GraphQLPlus.Execution`
**Depends on:** Stages 1, 3, 4

## Goal

Convert an inbound HTTP request into a fully decoded, validated `GqlpDecodedRequest`
containing a parsed `GqlpOperation`, all parameters decoded to their schema-expected
GraphQL+ types, and a collected list of errors and warnings.

## Interfaces

```csharp
public interface IRequestDecoder
{
    // Step 1: raw HTTP body → structural GqlpRequest
    RequestBodyResult DecodeBody(
        ReadOnlySpan<byte> body,
        string? contentType,
        string? sidechannelCategory,
        string? sidechannelOperation,
        string? sidechannelDefinition,
        IReadOnlyList<IGqlpValue>? sidechannelParams);

    // Step 2: GqlpRequest + parsed operation + validated schema → decoded parameters
    RequestDecodeResult DecodeParameters(
        GqlpRequest request,
        GqlpOperation operation,
        GqlpSchema schema);
}

public sealed record RequestBodyResult(
    GqlpRequest? Request,
    IReadOnlyList<GqlpDiagnostic> Errors
);

public sealed record RequestDecodeResult(
    IReadOnlyList<IGqlpValue> DecodedParameters,
    IReadOnlyList<GqlpDiagnostic> Diagnostics   // errors + warnings
);
```

## Body decoding rules (from `graphql-plus/Coding.md`)

The raw body bytes are first deserialised to `IGqlpValue` via a pluggable
`IGqlpValueDeserializer` (default: JSON; YAML via an optional add-on package).

| Condition | Interpretation |
|-----------|----------------|
| `sidechannelDefinition` is set | body = parameters (bypass definition extraction) |
| body is empty, boolean, or number | error |
| body is a string | definition = body string |
| body is a list | first string item = definition; remaining items = parameters |
| body is a map with key `definition` | definition from that key; optional `category`, `operation`, `parameters` keys |
| body is a map without `definition` key | error |

The resulting `GqlpRequest` carries raw `IGqlpValue` parameters; typed decoding occurs in
`DecodeParameters` once the operation is parsed and the schema is known.

## Parameter decoding (from `graphql-plus/Coding.md`)

Walk each `GqlpVariable` in the parsed operation. Pair it with the corresponding
positional parameter from `GqlpRequest.Parameters` (or use the variable's default
when no parameter was supplied).

### Plain vs Tagged values

- **Tagged** (value has a tag matching a known type): if the tag matches the expected
  type (or a child of it), decode as Plain for that type. If the tag does not match
  the expected type, record an error.
- **Unrecognised tag**: treat as Plain and raise a warning.
- **Plain**: apply type-based rules below.

### Scalar decoding table

| Expected type | String value | Number value | Boolean value |
|---------------|-------------|-------------|---------------|
| `String` | used as-is | convert to string + warning | convert to string + warning |
| `Number` | parse number or error | used as-is | `true`→1, `false`→0, else warning |
| `Boolean` | `"true"`/`"false"` or error | `1`→`true`, `0`→`false`, else warning | used as-is |
| `Enum` | parse label or alias or error | n → nth label or error | error |
| `Domain` | decode for base kind, check constraint or error | same | same |

For warnings (the mapping cases), if the conversion succeeds a warning is raised;
if it is not possible, an error is raised instead.

### List decoding

| Input | Expected type | Result |
|-------|--------------|--------|
| list | `T[]` | each item decoded to `T` |
| non-list | `T[]` | wrap as single-element list |
| list (0 or 2+ items) | `T` (no modifier) | error |
| list (1 item) | `T` (no modifier) | unwrap and decode |
| empty list | `T?` | `null` + warning |
| list | `T[K]` (dict) | error |
| list with duplicates | `_Set<T>` | deduplicate + warning |

### Map decoding

| Input | Expected type | Result |
|-------|--------------|--------|
| map | `T[K]` | each k→K, v→T; error on failed pair |
| empty map | `T?` | `null` + warning |
| map | object type | all keys must match fields; missing fields need defaults or modifiers |
| map | anything else | error |

### Union and Alternate decoding

When the expected type is a `union` or an `object` with alternates:

1. Try to decode the value to each member / alternate in definition order.
2. Use the first successful decoding.
3. Accumulate warnings from **all** attempts (not just the successful one).
4. If all attempts fail, record an error.

### Schema-aware operation validation

After parameter decoding, validate the operation's field selections against the schema:

- Selected fields must exist on the output type for the resolved category.
- For each nested `Object`, the field's return type must be a known `output` or `dual`.
- Fragment type conditions must be compatible with the parent selection type.
- Directive usages must name directives declared in the schema.
- Directives must be used at a valid `GqlpDirectiveLocation`.
- Non-repeatable directives may not appear more than once at the same location.

## Tests

- Decode all files under `samples/Request/` and compare the result to the
  corresponding `*.resp` expected response file
- Unit test each scalar coercion mapping (all cells in the table above)
- Unit test union/alternate ordering (first match wins; warnings accumulate)
- Unit test side-channel override combinations (definition in header, body = params)
- Unit test each invalid body kind (boolean, number, empty) produces an error
- Unit test tagged value matching and mismatch error
- Unit test missing parameter falls back to variable default
