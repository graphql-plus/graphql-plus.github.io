# Stage 1 — Core Type Model

**Package:** `GraphQLPlus.Core`
**Depends on:** nothing

## Goal

Define all C# types that represent the GraphQL+ type system and the simple value model.
No parsing, no execution logic — pure data structures and interfaces.

## Simple Value Model

```csharp
// Union-style discriminated type for all simple values (used in encoding/decoding)
IGqlpValue
  GqlpScalar(string/number/bool value, string? tag)
  GqlpNull(string tag = "Null")
  GqlpUnit(string tag = "Unit")
  GqlpVoid(string tag = "Void")
  GqlpList(IReadOnlyList<IGqlpValue> items)
  GqlpMap(IReadOnlyDictionary<string, IGqlpValue> entries, string? tag)
```

## Type System Model

### Shared base

```
GqlpTypeRef              // Reference to a type by name + type arguments + modifiers
GqlpModifier             // Optional | List | Dict(keyType, keyOptional)
GqlpDescription          // List of STRING values preceding a declaration
GqlpAlias                // Alternate name string
```

### Schema-level declarations

```
GqlpSchema
  Categories:  IReadOnlyList<GqlpCategory>
  Directives:  IReadOnlyList<GqlpDirective>
  Options:     IReadOnlyList<GqlpOption>
  Types:       IReadOnlyList<IGqlpType>

GqlpCategory
  Name, Aliases, Description
  OutputType: string
  Resolution: GqlpResolution (Parallel | Sequential | Single)
  Modifiers: GqlpModifier[]

GqlpDirective
  Name, Aliases, Description
  Parameter: GqlpTypeRef?
  IsRepeatable: bool
  Locations: GqlpDirectiveLocation (flags enum)

GqlpOption / GqlpSetting
  Name, Key, Value (string)
```

### Types

```
IGqlpType
  Name, Aliases, Description, Parent: string?

GqlpBuiltInType : IGqlpType
  Kind: GqlpBuiltInKind (Void | Null | Unit | Boolean | Number | String)

GqlpEnumType : IGqlpType
  Labels: IReadOnlyList<GqlpEnumLabel>
    GqlpEnumLabel.Name, GqlpEnumLabel.Aliases

GqlpDomainType : IGqlpType
  Kind: GqlpDomainKind (Boolean | Enum | Number | String)
  Items: IReadOnlyList<IGqlpDomainItem>
    GqlpDomainTrueFalse(value, excluded)
    GqlpDomainLabel(label, excluded)
    GqlpDomainRange(lower?, upper?, excluded)
    GqlpDomainRegex(pattern, excluded)

GqlpUnionType : IGqlpType
  Members: IReadOnlyList<string>   // ordered; order is significant

GqlpObjectType : IGqlpType         // base for Input, Output, Dual
  TypeParams: IReadOnlyList<GqlpTypeParam>
    GqlpTypeParam.Name, GqlpTypeParam.Constraint: string?
  Fields: IReadOnlyList<GqlpField>
  Alternates: IReadOnlyList<GqlpAlternate>

GqlpField
  Name, Aliases
  TypeRef: GqlpTypeRef
  Modifiers: GqlpModifier[]
  Default: IGqlpValue?              // Input + Dual fields only
  InputParams: IReadOnlyList<GqlpField>  // Output fields only
  EnumValue: string?                // Output fields only

GqlpAlternate
  TypeRef: GqlpTypeRef
  Modifiers: GqlpModifier[]

GqlpInputType  : GqlpObjectType
GqlpOutputType : GqlpObjectType
GqlpDualType   : GqlpObjectType
```

### Request / operation model

```
GqlpRequest
  Category: string?
  Operation: string?
  Definition: string
  Parameters: IReadOnlyList<IGqlpValue>

GqlpOperation
  Category: string?
  OperationName: string?
  Variables: IReadOnlyList<GqlpVariable>
  Directives: IReadOnlyList<GqlpDirectiveUse>
  Fragments: IReadOnlyList<GqlpFragment>
  Result: GqlpResult

GqlpVariable
  Name, TypeHint: string?, Modifiers, Default: IGqlpValue?, Directives

GqlpFragment
  Name, TypeCondition: string, Directives, Body: GqlpObject

GqlpResult
  DomainRef: GqlpTypeRef?    // domain-style result (`:` Domain syntax)
  Argument: IGqlpValue?
  Object: GqlpObject?
  Modifiers: GqlpModifier[]

GqlpObject
  Selections: IReadOnlyList<IGqlpSelection>

IGqlpSelection
  GqlpFieldSelection(alias?, name, argument?, modifiers, directives, nestedObject?)
  GqlpInlineFragment(typeCondition?, directives, body)
  GqlpSpread(fragmentName, directives)
```

## Errors and warnings

```csharp
public sealed record GqlpDiagnostic(
    GqlpSeverity Severity,   // Error | Warning
    string Message,
    GqlpLocation? Location   // nullable; line/column/source name
);
```

## Modifier ordering note

Modifiers are stored left-to-right as they appear in source. The leftmost modifier is the
outermost collection. For example, `String[][Number][Unit?]?` stores modifiers:
`[List, Dict(Number), Dict(Unit, optional), Optional]`
and resolves to `Opt< Dict<Opt<Unit>, Dict<Number, List<String>>> >`.

Utility method `GqlpModifier.WrapType(IGqlpType inner) → IGqlpType` applies this ordering.

## Tests

- Unit tests for modifier nesting/ordering (left-to-right = outside-to-inside)
- Null / Unit / Void special type behaviour (each is a distinct kind)
- Equality and hash implementations for use as dictionary keys
- `GqlpTypeRef` with zero, one, and multiple type arguments
