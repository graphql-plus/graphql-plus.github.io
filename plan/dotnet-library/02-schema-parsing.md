# Stage 2 — Schema Parsing

**Package:** `GraphQLPlus.Parsing`
**Depends on:** Stage 1 (Core)

## Goal

Parse `.graphql+` schema text into a raw (pre-validation) collection of declarations,
closely following the PEG grammar in `graphql-plus/Schema.md` and `graphql-plus/Definition.md`.
No type resolution or cross-declaration validation occurs at this stage.

## Interface

```csharp
public interface ISchemaParser
{
    SchemaParseResult Parse(string source, string? sourceName = null);
}

public sealed record SchemaParseResult(
    IReadOnlyList<IGqlpDeclaration> Declarations,   // raw, unmerged
    IReadOnlyList<GqlpDiagnostic> Errors
);
```

## Grammar

The top-level grammar from the spec:

```peg
Schema      = Declaration+
Declaration = Description? (Category | Directive | Option | Type)
Type        = Dual | Enum | Input | Output | Domain | Union
```

## Implementation approach

Use a hand-written recursive-descent PEG parser operating on a `ReadOnlySpan<char>`
with a mutable position cursor wrapped in a `ParseContext` struct.
No external parser-generator dependency.

```csharp
ref struct ParseContext
{
    public ReadOnlySpan<char> Source;
    public int Position;
    public string? SourceName;
    public List<GqlpDiagnostic> Diagnostics;
}
```

Each grammar rule is a method returning `bool` (matched or not). On a failed optional
match the cursor is restored; on a failed required match an error is recorded.

### Terminal parsers

| Method | Matches |
|--------|---------|
| `TryParseNumber` | `[-+]?[0-9_]+(\.[0-9_]+)?` |
| `TryParseString` | single- or double-quoted, backslash escapes, multiline |
| `TryParseRegex` | `/` … `/` POSIX ERE, any characters including newlines |
| `TryParseIdentifier` | `[A-Za-z][A-Za-z0-9_.]*` |
| `SkipWhitespaceAndCommas` | spaces, tabs, CR, LF, `,` (commas are whitespace outside Constants) |
| `TryParseLiteral(string)` | exact string match after whitespace skip |
| `TryParseKeyword(string)` | literal followed by non-identifier character |

### Non-terminal parsers (one method per grammar rule)

Top-down, each appends to a builder or writes to an `out` parameter:

- `ParseDescription` → zero or more STRING values
- `ParseAliases` → `'[' identifier+ ']'`
- `ParseModifiers` → `Collections? '?'?`
- `ParseCollections` → `'[]' Collections? | '[' Collection_Key '?'? ']' Collections?`
- `ParseTypeRef` → name `('<' TypeArg (',' TypeArg)* '>')? Modifiers`
- `ParseValue` → Scalar | List | Map (for DEFAULT values and Argument constants)
- `ParseCategory` → `category name Aliases? '{' Output Resolution? '}'`
- `ParseDirective` → `directive name Aliases? '{' Param? Repeatable? Locations '}'`
- `ParseOption` → `option name '{' Setting+ '}'`
- `ParseEnumType` → `enum name Aliases? Parent? '{' Label+ '}'`
- `ParseDomainType` → `domain name Aliases? Parent? '{' DomainKind Items '}'`
- `ParseUnionType` → `union name Aliases? Parent? '{' Member+ '}'`
- `ParseInputType`, `ParseOutputType`, `ParseDualType` → object type parsers
- `ParseField` → shared across Input/Output/Dual with a flags parameter for which extras are valid
- `ParseTypeParam` → `'<' '$' name (':' constraint)? '>'`

### Error recovery

On a parse error within a top-level declaration, record a diagnostic and skip forward
to the next `}` at depth 0 or end of input. This allows a single pass to collect all
parse errors before returning.

## Multiple source files

`ISchemaParser.Parse` processes one source string at a time and returns its raw
declarations. The caller accumulates declaration lists from multiple files and passes
them all to `ISchemaValidator` (Stage 3).

## Tests

- Parse each example under `samples/Schema/` and `samples/Specification/` without errors
- Parse `samples/Schema/errors.graphql+` and verify the collected parse errors match
  the expected content of `samples/Schema/errors.parse-errors`
- Round-trip test: parse → re-serialise (via a `GqlpSchemaWriter`) → diff against source
- Fuzz tests: random character mutations of valid schema text must produce diagnostics,
  never unhandled exceptions
- Boundary tests: empty source, source with only whitespace/comments
