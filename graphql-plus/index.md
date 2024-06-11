# GraphQL+

Defining a successor to GraphQL <img src="../images/GraphQL_Logo.svg" width="50" alt="GraphQL logo">

## Intent

Whilst GraphQL is basically sufficient at it's core, there are a few limitations and issues that I wish to address.

- The [Schema](Schema.md) and [Operation](Operation.md) languages are too intertwined.
- No Generic types
- No Dictionary / Map core type
- No Input Union types
- The introspection model is flawed especially with respect to Nullable and List type modifiers. It's not possible
  for one query be guaranteed to return a Type's full definition.
