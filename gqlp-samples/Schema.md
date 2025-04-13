# Schema Samples

## Root

### all.graphql+

```gqlp
"A Category"
category { "Category Result" All }
"A Directive"
directive @all { All }
"An Option"
option Schema { "Schema Setting" all="test" }
"A Domain"
domain Guid { String "Guid Regex" /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/ }
"An Enum"
enum One { "Label 2" Two "Label 3" Three }
"A Union"
union Many { "Guid Id" Guid "Numeric Id" Number }
"A Dual"
dual Field { "Some strings" strings: "Strings array" String[] }
"An Input"
input Param {
    "First Id" afterId: "Guid or Int" Many?
    "Last Id" beforeId: "Guid or Int" Many
    | "Alternate parameter" String
    }
"An Output"
output All {
    "Some items" items(Param?): Field
    | "Alternates" String
    }
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
domain Other { Enum }
enum None [] {}
union Missing {}
dual Nothing [] {}
input Empty {}
output NoParams<> {}
```

##### Expected Parse errors

- `Expected output type`
- `Expected type name`
- `Expected no more text`

##### Expected Verify errors

- `'query' not defined or not an Output type`
