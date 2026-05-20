# Stage 3 — Schema Validation

**Package:** `GraphQLPlus.Parsing`
**Depends on:** Stage 2

## Goal

Take raw declarations from one or more parsed schema files and produce a fully validated,
resolved `GqlpSchema` with all merges applied, parent chains resolved, and every type
reference verified. This is the single source of truth consumed by all later stages.

## Interface

```csharp
public interface ISchemaValidator
{
    SchemaValidateResult Validate(IEnumerable<IGqlpDeclaration> declarations);
}

public sealed record SchemaValidateResult(
    GqlpSchema? Schema,   // null when there are any errors
    IReadOnlyList<GqlpDiagnostic> Diagnostics
);
```

## Pre-validation: inject system declarations

Before processing user declarations, inject the built-in type declarations:

| Name | Kind |
|------|------|
| `Void` | Built-in (Enum-like) |
| `Null` | Built-in (Enum-like) |
| `Unit` | Built-in (Enum-like) |
| `Boolean` | Built-in (Enum: `false`, `true`) |
| `Number` | Built-in (Domain: any number) |
| `String` | Built-in (Domain: any string) |

User declarations with any of these names are errors.

The introspection declarations (`_Schema`, `_Filter`, etc.) are also injected here
(see Stage 9 for the full list). User declarations with names starting `_` followed
by an uppercase letter are errors.

## Validation rules

### Merging

Declarations sharing a name are merged according to these rules:

| Kind | Merge rule |
|------|-----------|
| `enum` | Labels from all declarations combined. Duplicate labels are errors. |
| `domain` | Items from all declarations combined. Kind must match across all. |
| `input`, `output`, `dual` | Fields and alternates merged. Type params must be identical across all. |
| `union` | Members merged; order of first declaration is preserved; subsequent unique members appended. |
| `category`, `directive`, `option` | Duplicate names are errors. |

Declarations with the same name but different kinds are always errors.

### Parent chain resolution

1. Resolve `Parent` string reference to an `IGqlpType` in the validated set.
2. Parent must be the same kind as the child (e.g. enum parent of enum, output parent of output).
3. Detect and report circular parent chains (A → B → A).
4. Inherited labels / fields are accessible via the parent chain; they are not copied
   into the child's own member list.

### Type reference resolution

For every `GqlpTypeRef` appearing in field types, alternate types, union members,
category output types, and directive parameter types:

1. Resolve the name to a known `IGqlpType` or built-in.
2. Verify type-argument count matches the type's `TypeParams` count.
3. For each type argument, verify it satisfies the corresponding `TypeParam.Constraint`
   (i.e. the argument type is assignable to the constraint type).
4. For `$param` references inside an object type, verify the param name is declared
   on that type (or an ancestor type).

### Domain-specific validation

- **Enum domain**: referenced labels must exist in the named enum (traversing parent chains).
- **Number domain**: range bounds must be valid numbers; overlapping ranges are warnings.
- **String domain**: regex items must compile as POSIX ERE.
- **Boolean domain**: at most one `true` item and one `false` item.

### Modifier compatibility

- Dictionary key type must satisfy the `_Key` constraint:
  `Boolean`, `Unit`, any `enum` type, or any `domain` of kind Boolean/Enum/Number/String.
- `Optional` (`?`) must be the final modifier in any chain.
- `Void` may not be used as a field type or collection element type.
- `Null?` is equivalent to `Void?` (both are always optional).

### Category checks

- The `OutputType` string must resolve to a known `output` or `dual` type.
- `Resolution` must be one of `Parallel`, `Sequential`, `Single` (case-sensitive).

### Directive checks

- Each declared `Location` value must be a valid `GqlpDirectiveLocation` member.
- `Parameter` type ref, if present, must resolve to a known `input` or `dual` type.

## Output

`GqlpSchema` (Stage 1 model) where all name-string references have been resolved
and the merged, parent-chained type list is complete. The validator does not mutate
the raw declarations; it produces a new validated object graph.

## Tests

- Validate all files under `samples/Schema/` without errors
- Validate `samples/Schema/errors.graphql+`; match expected diagnostics in
  `samples/Schema/errors.verify-errors`
- Validate `samples/Schema/Globals/`, `samples/Schema/Objects/`, etc. sub-directories
- Validate `samples/Specification/` schema files
- Unit test each merge rule with minimal two-declaration fragments
- Unit test circular parent chain detection
- Unit test type-argument constraint checking with mismatched constraint
- Unit test reserved name rejection (`Boolean`, `_Schema`, etc.)
