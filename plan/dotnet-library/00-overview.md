# GraphQL+ .NET Library — Overview

## Purpose

A set of NuGet packages that lets an existing ASP.NET Core application expose one or more
GraphQL+ endpoints with minimal boilerplate: register a schema, map a field to a C# method,
and the library handles parsing, validation, decoding, execution, encoding, and introspection.

## Package Layout

| Package | Responsibility | External deps |
|---------|---------------|---------------|
| `GraphQLPlus.Core` | Type model, simple value model | none |
| `GraphQLPlus.Parsing` | Schema + operation PEG parsers | Core |
| `GraphQLPlus.Execution` | Request pipeline: decode → validate → execute → encode | Core, Parsing |
| `GraphQLPlus.AspNetCore` | Middleware, DI, endpoint routing | Execution, Microsoft.AspNetCore.* |

All packages target `net8.0` and follow nullable reference type conventions throughout.

## Stages

| # | Stage | Package | Key output |
|---|-------|---------|------------|
| 1 | Core Type Model | Core | All C# types mirroring the GQL+ type system |
| 2 | Schema Parsing | Parsing | `ISchemaParser` — `.graphql+` text → raw schema AST |
| 3 | Schema Validation | Parsing | `ISchemaValidator` — raw AST → validated `GqlpSchema` |
| 4 | Operation Parsing | Parsing | `IOperationParser` — `.gql+` / inline text → `GqlpOperation` |
| 5 | Request Decoding | Execution | `IRequestDecoder` — HTTP body/headers → `GqlpRequest` with decoded parameters |
| 6 | Execution Engine | Execution | `ISchemaExecutor` — runs operation against registered resolvers |
| 7 | Response Encoding | Execution | `IResponseEncoder` — `GqlpValue` tree → simple value / JSON / YAML |
| 8 | ASP.NET Core Integration | AspNetCore | Middleware + DI extension methods |
| 9 | Introspection | Execution | Built-in `_Schema` resolver |

Each stage has its own plan document and can be implemented and tested independently
before the next stage begins, with the exception that Stage 6 depends on Stages 2–5
all being complete.

## Key Specification References

- Encoding/decoding rules: `graphql-plus/Coding.md`
- Language grammar: `graphql-plus/Definition.md`
- Schema grammar and type system: `graphql-plus/Schema.md`
- Operation grammar: `graphql-plus/Operation.md`
- Request/response format: `graphql-plus/Request.md`
- Introspection schema: `graphql-plus/Introspection.md`
- Existing reference implementation: <https://github.com/NeonGraal/graphql-plus>
