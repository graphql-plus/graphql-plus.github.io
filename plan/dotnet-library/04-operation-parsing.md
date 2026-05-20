# Stage 4 — Operation Parsing

**Package:** `GraphQLPlus.Parsing`
**Depends on:** Stage 1 (Core)

## Goal

Parse a GraphQL+ operation string (`.gql+` file content or inline HTTP body) into a
`GqlpOperation`. This parser is schema-independent — it produces the AST without
resolving types. Schema-aware validation of the operation against the schema occurs
in Stage 5.

## Interface

```csharp
public interface IOperationParser
{
    OperationParseResult Parse(string source, string? sourceName = null);
}

public sealed record OperationParseResult(
    GqlpOperation? Operation,   // null when there are errors
    IReadOnlyList<GqlpDiagnostic> Errors
);
```

## Grammar

From `graphql-plus/Operation.md` and `graphql-plus/Definition.md`:

```peg
Operation  = (category name?)? Variables? Directive* Fragment* Result Frag_End*
Variables  = '(' Variable+ ')'
Variable   = '$' variable (':' Var_Type)? Modifiers? Default? Directive*
Directive  = '@' name Argument?
Fragment   = '&' name ':' type Frag_Body
Frag_End   = ('fragment' | '&') name TypeCondition Frag_Body
Frag_Body  = Directive* Object
TypeCond   = ('on' | ':') type
Result     = (':' Domain Argument? | Object) Modifiers?
Object     = '{' (Selection | Field)+ '}'
Field      = (alias ':')? field Argument? Modifiers? Directive* Object?
Selection  = ('...' | '|') (Inline | Spread)
Inline     = TypeCond? Directive* Object
Spread     = name Directive*
Argument   = '(' VALUE ')'
```

### Disambiguation rules

- **Category vs field name**: The first bare identifier before any `(`, `@`, `&`, or `{`
  is treated as the category. If no such identifier is present, the default category
  `query` is assumed (GraphQL compatibility).
- **Operation name**: An optional second identifier immediately following the category.
- **Fragment short syntax** (`&name : type { ... }`): parsed before Result.
- **Frag_End** (`fragment name on type { ... }` or `& name on type { ... }`):
  parsed after Result; placed at end of source for GraphQL `fragment` keyword compatibility.
- **Inline fragment** (`... TypeCond? { ... }` or `| TypeCond? { ... }`):
  either `...` or `|` syntax is accepted.
- **Spread** (`...name` or `|name`): name immediately follows the spread operator.

### Variable defaults and optionality

Per the spec:
- A variable with an `Optional` (`?`) modifier has an implied default of `null`.
- A variable with a default of `null` has an implied `Optional` modifier.

Both these equivalences are normalised during parsing so downstream stages see
a consistent model.

### The `Var_Type` hint

The `:TypeHint` on a variable is accepted and stored for user tooling but is **ignored**
for execution. The runtime parameter type is inferred from the validated schema.

## Semantic checks performed during parsing

These are checked immediately after the AST is built, before returning:

| Check | Rule |
|-------|------|
| Fragment name uniqueness | Two fragments with the same name within one operation are errors |
| Spread resolution | Every `...name` / `&name` spread must reference a defined fragment or Frag_End |
| Fragment cycle detection | DFS over spread graph; cycles are errors |
| Alias collision | Two fields in the same `Object` with the same effective name (alias or field name) are errors |

## Tests

- Parse all files under `samples/Operation/*.gql+` without errors
- Parse each file under `samples/Operation/Invalid/*.gql+` and verify collected errors
  match the corresponding `*.verify-errors` file
- Parse operation examples embedded in `gqlp-samples/Operation/` documentation
- Unit test fragment cycle detection with 2-node and 3-node cycles
- Unit test alias collision detection
- Unit test default/optional normalisation for variables
- Unit test both `...` and `|` spread syntaxes produce identical ASTs
- Unit test category omission defaults to `query`
