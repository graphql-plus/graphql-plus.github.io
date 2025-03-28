# Schema Samples

## Root

### all.graphql+

```gqlp
category { All }
directive @all { All }
enum One { Two Three }
input Param { afterId: Guid? beforeId: Guid | String }
output All { items(Param?): String[] | String }
domain Guid { String /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/ }
```

### default.graphql+

```gqlp
category { Query }
output Query { }

category { (sequential) Mutation }
output Mutation { }

category { (single) Subscription }
output Subscription { }

output _Schema { }
```

### errors.graphql+

```gqlp
category query {}
directive @ {}
enum None [] {}
input Empty {}
output NoParams<> {}
domain Other { Enum }
```

##### Expected Parse errors

- `Invalid Category. Expected output type`
- `Invalid Schema. Expected no more text`

##### Expected Verify errors

- `Invalid Category Output. '' not defined or not an Output type`
