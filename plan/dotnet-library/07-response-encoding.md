# Stage 7 — Response Encoding

**Package:** `GraphQLPlus.Execution`
**Depends on:** Stage 1

## Goal

Convert the `IGqlpValue` tree produced by the execution engine (or an error list) into
an HTTP response body following the encoding rules in `graphql-plus/Coding.md`. Support
both Simple and Complex response modes, and be extensible for JSON and YAML output formats.

## Interface

```csharp
public interface IResponseEncoder
{
    // Encode a successful execution result
    EncodedResponse EncodeSuccess(
        IGqlpValue value,
        string? category,
        string? operation,
        string? requestDefinition,
        IReadOnlyList<string> warnings,
        GqlpResponseMode mode);

    // Encode a failed response (errors prevent execution)
    EncodedResponse EncodeErrors(
        IReadOnlyList<GqlpDiagnostic> errors,
        string? category,
        string? operation,
        GqlpResponseMode mode);
}

public enum GqlpResponseMode { Simple, Complex }

public sealed record EncodedResponse(
    ReadOnlyMemory<byte> Body,
    string ContentType,
    // Side-channel headers populated in Simple mode
    IReadOnlyDictionary<string, string> Headers
);
```

## Value encoding rules (from `graphql-plus/Coding.md`)

### Built-in values

| GraphQL+ value | Encoded representation |
|----------------|----------------------|
| `String` | plain string (no tag) |
| `Number` | plain number (no tag) |
| `Boolean` | plain boolean (no tag) |
| `Null` | `null` literal with `!Null` tag |
| `Unit` | `_` literal with `!Unit` tag |
| `Void` | `~` literal with `!Void` tag |
| List (`T[]`) | plain array (no tag) |
| Dict (`T[K]`) | map object with tag `!Map(KeyType)` |

### Typed values

| GraphQL+ value | Encoded representation |
|----------------|----------------------|
| Enum label | label string with `!EnumTypeName` tag |
| Domain value | base-type encoding with `!DomainTypeName` tag |
| Union value | encoded as the specific member type with that type's tag |
| Object | map of field-name → encoded value with `!TypeName` tag |

**Type aliases must never appear in tags.** Only the canonical type name is used.

### Tag serialisation strategy

Tags are an abstract concept; each serialiser implements them differently:

| Format | Tag representation |
|--------|--------------------|
| YAML | `!TagName value` (native YAML tag syntax) |
| JSON | `{ "$type": "TagName", "$value": <value> }` wrapper object |

The JSON wrapper format is configurable via `GqlpOptions.JsonTagFormat` for interoperability
with different consumer conventions.

## Response modes

### Simple mode

Category, operation name, and warnings are returned in HTTP response headers
(names configured in `GqlpOptions`; see Stage 8). The response body contains either:
- The encoded `IGqlpValue` (success), or
- A JSON/YAML list of error strings (failure).

### Complex mode

The response body is a JSON/YAML map with the following keys:

```yaml
category: Query           # string; from request
operation: All            # string; from request
request: "All { ... }"   # string; only if GqlpOptions.IncludeRequestInComplexResponse
warnings:
  - "Warning text"
errors: []
response:
  <encoded value>
```

On failure, `response` is absent and `errors` contains one or more error strings or
error-detail objects (`{ message, location }`).

## Pluggable serialisers

```csharp
public interface IGqlpValueSerializer
{
    string ContentType { get; }
    ReadOnlyMemory<byte> Serialize(IGqlpValue value);
    ReadOnlyMemory<byte> SerializeComplexResponse(GqlpComplexResponse response);
}
```

Two built-in implementations:

| Class | Package | Notes |
|-------|---------|-------|
| `SystemTextJsonGqlpSerializer` | `GraphQLPlus.Execution` | Default; no extra deps |
| `YamlDotNetGqlpSerializer` | `GraphQLPlus.Yaml` (optional) | Requires `YamlDotNet` |

Both respect the same tag encoding contract.

## Tests

- Encode all expected responses under `samples/Request/*.resp` and diff against expected
- Unit test each `IGqlpValue` subtype's encoded form (all rows in the tables above)
- Test Simple mode: category/operation/warnings land in headers, not body
- Test Complex mode: full map structure including optional `request` key
- Test error-only response (no `response` key in Complex, list-of-strings in Simple)
- Test alias exclusion: type aliases must not appear in any encoded tag
- Test `GqlpNull`, `GqlpUnit`, `GqlpVoid` produce the correct tag + literal combinations
- Test JSON tag format with `$type`/`$value` wrapper
