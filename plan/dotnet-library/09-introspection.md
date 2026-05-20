# Stage 9 — Introspection

**Package:** `GraphQLPlus.Execution`
**Depends on:** Stages 1, 3, 6

## Goal

Implement the built-in `_Schema` output type and all associated introspection types so
that any GraphQL+ endpoint automatically answers introspection queries without any
user configuration.

## System declaration injection

Before processing user declarations in Stage 3 (`ISchemaValidator.Validate`), the
following declarations are injected from the specification in `graphql-plus/Introspection.md`.
They are treated as sealed — any user declaration using a reserved name is an error.

### Injected types (summary)

| Name | Kind | Purpose |
|------|------|---------|
| `_Schema` | output | Root introspection query type |
| `_Named` | dual | Base type providing `name` and `aliases` fields |
| `_Described` | dual | Extends `_Named` with `description` |
| `_Category` | output | Single category descriptor |
| `_Directive` | output | Single directive descriptor |
| `_Setting` | output | Single option setting |
| `_Filter` | input | General name-based filter |
| `_CategoryFilter` | input | Filter with resolution and output type constraints |
| `_TypeFilter` | input | Filter with type-kind constraints |
| `_NameFilter` | domain | String domain for `.`/`*` pattern matching |
| `_Resolution` | enum | `Parallel`, `Sequential`, `Single` |
| `_TypeKind` | enum | `Basic`, `Internal`, `Domain`, `Enum`, `Union`, `Input`, `Output`, `Dual` |
| `_DomainKind` | enum | `Boolean`, `Enum`, `Number`, `String` |
| `_Type` | union | Union of all `_Type*` alternates |
| `_TypeBasic` | output | Represents built-in types |
| `_TypeInternal` | output | Represents Null/Unit/Void |
| `_TypeDomain*` | output | One per domain kind |
| `_TypeEnum` | output | Enum type descriptor |
| `_TypeUnion` | output | Union type descriptor |
| `_TypeInput` | output | Input object type descriptor |
| `_TypeOutput` | output | Output object type descriptor |
| `_TypeDual` | output | Dual object type descriptor |

The `_Schema` category is also injected:

```graphql+
category { _Schema }
```

## Introspection provider

```csharp
public interface IGqlpIntrospectionProvider
{
    // Resolve the _Schema root value for a given validated schema
    IGqlpValue GetSchemaValue(
        GqlpSchema schema,
        GqlpIntrospectionQuery query);
}
```

`GqlpIntrospectionQuery` carries the decoded filter arguments from the operation's
field arguments (categories filter, directives filter, types filter, settings filter).

The provider is registered as a singleton in DI and registered as a resolver for all
`_Schema` fields in `GqlpResolverRegistry` during `AddGraphQLPlus`.

## Filter implementation

`GqlpSchemaFilter` converts a decoded `_Filter` input value into a predicate:

1. Compile each `_NameFilter` pattern into a `Regex`:
   - `.` → match exactly one character
   - `*` → match zero or more characters
   - All other characters are literal
2. If `matchAliases` is true, apply patterns to aliases as well as names.
3. If `returnByAlias` is true, re-key the result map by the matched alias.
4. If `returnReferencedTypes` is true, transitively include all types referenced
   by the returned types (field types, alternate types, union members, parent types).
   Cycle detection (via a visited set) prevents infinite recursion.

## Type serialisation

Each `IGqlpType` subtype maps to a `_Type*` output alternate. The introspection resolver
performs this mapping when building the response value:

| C# type | `_Type` alternate |
|---------|------------------|
| `GqlpBuiltInType` (Void/Null/Unit) | `_TypeInternal` |
| `GqlpBuiltInType` (Boolean/Number/String) | `_TypeBasic` |
| `GqlpDomainType` (Boolean kind) | `_TypeDomainBoolean` |
| `GqlpDomainType` (Enum kind) | `_TypeDomainEnum` |
| `GqlpDomainType` (Number kind) | `_TypeDomainNumber` |
| `GqlpDomainType` (String kind) | `_TypeDomainString` |
| `GqlpEnumType` | `_TypeEnum` |
| `GqlpUnionType` | `_TypeUnion` |
| `GqlpInputType` | `_TypeInput` |
| `GqlpOutputType` | `_TypeOutput` |
| `GqlpDualType` | `_TypeDual` |

Field-level details provided per type:

- **Enum**: `labels` → `_Label[_Name]` dictionary (name → label with aliases)
- **Domain**: `items` → list of domain-kind-specific item objects (ranges, regexes, labels, booleans)
- **Object types**: `typeParams`, `fields` → `_Field[_Name]` dict, `alternates` → `_Alternate[]`
- **All types**: `description`, `aliases`, `parent` (name string)

## `_Schema` category behaviour

The injected `_Schema` category uses the default `Parallel` resolution. The execution
engine routes any operation with category `_Schema` to the introspection provider
rather than user-registered resolvers.

To query introspection:

```graphql+
_Schema { categories { name } }
_Schema { types(_TypeFilter: { names: ["User*"] }) { name typeKind } }
_Schema { directives { name parameter { ... } } }
```

## Reserved name enforcement

During schema validation (Stage 3), any user-declared type or category whose name
matches one of the injected names above produces an error. Names starting with `_`
followed by an uppercase letter are reserved for the system.

## Tests

- Parse and execute all files under `samples/Specification/` against their schemas;
  compare output to `gqlp-samples/Specification/` expected results
- Unit test `GqlpSchemaFilter` pattern matching:
  - `.` matches exactly one character
  - `*` matches zero or more characters
  - Exact name match
  - Alias match when `matchAliases = true`
- Unit test `returnReferencedTypes` terminates on schemas with circular type references
- Unit test `returnByAlias` re-keys the result map correctly
- Unit test each `IGqlpType` → `_Type*` mapping for all type kinds
- Integration test: introspect the StarWars sample schema and verify category/type listings
- Test that reserved names (`_Schema`, `_Filter`, `_TypeKind`, etc.) cannot be declared
  by user schema
