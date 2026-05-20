# Stage 8 — ASP.NET Core Integration

**Package:** `GraphQLPlus.AspNetCore`
**Depends on:** Stages 5, 6, 7

## Goal

Provide idiomatic ASP.NET Core extension methods so that an existing application can
expose a GraphQL+ endpoint with minimal setup code. Everything else — parsing, decoding,
execution, introspection, encoding — is wired automatically.

## Minimal usage

```csharp
// Program.cs
builder.Services.AddGraphQLPlus(gqlp =>
{
    gqlp.AddSchemaFile("schema.graphql+");
    gqlp.Field<MyDbContext>("Query", "users", async (db, _, ct) =>
        GqlpList(await db.Users.Select(u => GqlpString(u.Name)).ToListAsync(ct)));
});

app.MapGraphQLPlus("/graphql+");
```

## DI registration — `AddGraphQLPlus`

```csharp
public static IServiceCollection AddGraphQLPlus(
    this IServiceCollection services,
    Action<IGqlpSchemaBuilder> configure);
```

Registers the following services (all singletons unless noted):

| Service | Implementation | Notes |
|---------|---------------|-------|
| `ISchemaParser` | `GqlpSchemaParser` | Parsing package |
| `ISchemaValidator` | `GqlpSchemaValidator` | Parsing package |
| `IOperationParser` | `GqlpOperationParser` | Parsing package |
| `IRequestDecoder` | `GqlpRequestDecoder` | Execution package |
| `ISchemaExecutor` | `GqlpSchemaExecutor` | Execution package |
| `IResponseEncoder` | `GqlpResponseEncoder` | Execution package |
| `IGqlpIntrospectionProvider` | `GqlpIntrospectionProvider` | Stage 9; Execution package |
| `GqlpSchema` | resolved at startup | Built from registered sources |
| `GqlpResolverRegistry` | populated by `Field<T>()` calls | |
| `GqlpOptions` | from configuration / builder | |

Schema validation runs at startup (`IHostedService` or `IStartupFilter`). If validation
errors exist and `GqlpOptions.SchemaValidationOnStartup` is `true` (default), startup fails
with a descriptive exception listing all errors.

## Options — `GqlpOptions`

```csharp
public sealed class GqlpOptions
{
    // Response format when the caller does not specify Accept header preference
    public GqlpResponseMode DefaultResponseMode { get; set; } = GqlpResponseMode.Simple;

    // Fail at startup if schema has validation errors
    public bool SchemaValidationOnStartup { get; set; } = true;

    // Include the operation definition string in Complex responses
    public bool IncludeRequestInComplexResponse { get; set; } = false;

    // Maximum field-selection nesting depth
    public int MaxExecutionDepth { get; set; } = 32;

    // Allow GET requests with definition as query-string parameter (disabled by default)
    public bool AllowGetRequests { get; set; } = false;

    // Query-string flag name that triggers body-as-parameters mode (empty string = disabled)
    // When a request's query string contains this flag (e.g. ?body=parameters) the entire
    // body is treated as the raw parameters value, decoded according to the body's Content-Type.
    public string BodyAsParametersFlag { get; set; } = "body";

    // Side-channel header names
    public string CategoryHeader    { get; set; } = "X-GraphQLPlus-Category";
    public string OperationHeader   { get; set; } = "X-GraphQLPlus-Operation";
    public string DefinitionHeader  { get; set; } = "X-GraphQLPlus-Definition";
    public string WarningsHeader    { get; set; } = "X-GraphQLPlus-Warnings";
}
```

## Endpoint routing — `MapGraphQLPlus`

```csharp
public static IEndpointConventionBuilder MapGraphQLPlus(
    this IEndpointRouteBuilder endpoints,
    string pattern,
    Action<GqlpOptions>? overrideOptions = null);
```

Maps a POST (and optionally GET) endpoint. Per-endpoint option overrides allow
multiple endpoints sharing a single schema but with different response modes or
side-channel conventions.

### Request-handling pipeline

```
POST /graphql+
  │
  ├─ 1. Read side-channel values from:
  │       Headers: X-GraphQLPlus-Category, X-GraphQLPlus-Operation, X-GraphQLPlus-Definition
  │       Route values: {category}, {operation} segments if present in pattern
  │       Query string: ?category=...&operation=...&definition=... (when AllowGetRequests)
  │
  ├─ 1b. If query string contains GqlpOptions.BodyAsParametersFlag (e.g. ?body=parameters):
  │       Set body-as-parameters mode — the entire body will be decoded as the parameters
  │       value rather than as a full request envelope. All other side-channel values must
  │       be provided via step 1 mechanisms; the body Content-Type determines the deserialiser.
  │
  ├─ 2. Read raw request body bytes
  │
  ├─ 3. IRequestDecoder.DecodeBody(body, contentType, sidechannelValues, bodyAsParameters)
  │       └─ on error → IResponseEncoder.EncodeErrors → HTTP 400
  │
  ├─ 4. IOperationParser.Parse(request.Definition)
  │       └─ on error → IResponseEncoder.EncodeErrors → HTTP 400
  │
  ├─ 5. IRequestDecoder.DecodeParameters(request, operation, schema)
  │       └─ on error → IResponseEncoder.EncodeErrors → HTTP 400
  │
  ├─ 6. ISchemaExecutor.ExecuteAsync(operation, decodedParams, schema, services, ct)
  │       └─ on unhandled exception → HTTP 500
  │
  ├─ 7. IResponseEncoder.EncodeSuccess(result, mode)
  │
  └─ 8. Write body + headers to HttpResponse
```

### Content-type negotiation

| Request `Content-Type` | Normal body deserialiser | Body-as-parameters deserialiser |
|------------------------|-------------------------|---------------------------------|
| `application/json` (default) | `SystemTextJsonGqlpDeserializer` | `SystemTextJsonGqlpDeserializer` (body decoded as `IGqlpValue`) |
| `application/yaml` | `YamlDotNetGqlpDeserializer` (if registered) | `YamlDotNetGqlpDeserializer` (body decoded as `IGqlpValue`) |
| `application/x-www-form-urlencoded` | `FormGqlpDeserializer` (built-in) | `FormGqlpDeserializer` — `parameters` field only; other fields ignored |
| `multipart/form-data` | `FormGqlpDeserializer` (built-in, via `IFormCollection`) | `FormGqlpDeserializer` — `parameters` field only; other fields ignored |

When body-as-parameters mode is active, `IRequestDecoder.DecodeBody` skips the normal
envelope parsing and instead decodes the body as a single `IGqlpValue` (or a JSON/YAML
array as a list of values). The `definition`, `category`, and `operation` must have
been resolved from side-channel inputs in step 1; if `definition` is absent the
middleware returns HTTP 400 before reaching the decoder.

### Form encoding

When the request `Content-Type` is `application/x-www-form-urlencoded` or
`multipart/form-data`, ASP.NET Core's standard form-reading infrastructure
(`HttpRequest.ReadFormAsync`) is used. The `FormGqlpDeserializer` then maps
form fields to GraphQL+ request components as follows:

| Form field name | GraphQL+ component | Notes |
|-----------------|--------------------|-------|
| `definition` | definition string | Required unless supplied via side-channel |
| `category` | category identifier | Optional; overrides side-channel |
| `operation` | operation name | Optional; overrides side-channel |
| `parameters` | parameters value | Interpreted as a JSON-encoded `IGqlpValue` |
| `parameters[n]` | nth parameter | Positional shorthand; `parameters[0]`, `parameters[1]`, … |

Form fields that do not match any of the above are ignored.

The `parameters` field, if present, must be a JSON string (or JSON array for multiple
parameters) decoded by `SystemTextJsonGqlpDeserializer`. Scalar parameter values may
also be supplied as plain strings in `parameters[n]` fields and are decoded as
`GqlpScalar` string values; the operation's variable types govern final coercion.

File uploads via `multipart/form-data` are not decoded as parameters; a `multipart/form-data`
request that contains file parts alongside form fields is accepted but the file parts
are ignored.

| Response `Accept` | Serialiser used |
|-------------------|----------------|
| `application/json` (default) | `SystemTextJsonGqlpSerializer` |
| `application/yaml` | `YamlDotNetGqlpSerializer` (if registered) |

## Multiple endpoints

`MapGraphQLPlus` can be called multiple times with different route patterns and option
overrides. Each endpoint shares the same `GqlpSchema` and resolver registry, but can
differ in response mode and side-channel header names.

```csharp
app.MapGraphQLPlus("/graphql+/simple",  o => o.DefaultResponseMode = GqlpResponseMode.Simple);
app.MapGraphQLPlus("/graphql+/complex", o => o.DefaultResponseMode = GqlpResponseMode.Complex);
```

## Schema source helpers on `IGqlpSchemaBuilder`

```csharp
IGqlpSchemaBuilder AddSchemaFile(string filePath);
IGqlpSchemaBuilder AddSchemaString(string content, string? sourceName = null);
IGqlpSchemaBuilder AddSchemaAssemblyResource(Assembly assembly, string resourceName);
```

Multiple sources are merged by the validator before startup.

## Tests

- Integration tests using `WebApplicationFactory<T>` with a minimal test schema
- Test each side-channel input mechanism (header, route segment, query string)
- Test content-type negotiation for JSON and YAML request/response pairs
- Test `application/x-www-form-urlencoded` body with `definition`, `category`, `operation`, and `parameters` fields
- Test `multipart/form-data` body with the same named fields
- Test `parameters[n]` positional fields decoded as scalar strings
- Test that `parameters` JSON array is decoded to multiple parameter values
- Test form field `category`/`operation` override corresponding side-channel header values
- Test `?body=parameters` flag with JSON body decoded as bare `IGqlpValue`
- Test `?body=parameters` flag with YAML body decoded as bare `IGqlpValue`
- Test `?body=parameters` flag with `application/x-www-form-urlencoded` body
- Test `?body=parameters` requires `definition` via side-channel; missing definition → HTTP 400
- Test custom `BodyAsParametersFlag` name in options
- Test `BodyAsParametersFlag` empty string disables body-as-parameters mode entirely
- Test schema validation failure at startup produces a clear exception
- Test HTTP 400 on operation parse error
- Test HTTP 400 on parameter decode error
- Test HTTP 500 on unhandled resolver exception (with error body, not a plain 500)
- Test multi-endpoint setup with different response modes
- Test `AllowGetRequests` enabled and disabled
