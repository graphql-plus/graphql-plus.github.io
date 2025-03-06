# Operation Samples

## Root

### error.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Operation. Expected at least one field or selection`
- `Invalid Operation. Expected Object or Type`

### simple.gql+

```gqlp

```

## Invalid

### Invalid\empty.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Operation. Expected text`

### Invalid\frag-undef.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Spread usage. Spread not defined`

### Invalid\frag-unused.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Spread definition. Spread not used`

### Invalid\list-map-def.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Variable definition. List Type cannot have Object default`

### Invalid\list-null-map-def.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Variable definition. Optional List Type cannot have Object default`

### Invalid\map-list-def.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Variable definition. Dictionary Type must have Object default`

### Invalid\map-null-list-def.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Variable definition. Optional Dictionary Type must have Object default`

### Invalid\null-def-invalid.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Variable definition. Default of 'null' must be on Optional Type`

### Invalid\var-undef.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Variable usage. Variable not defined`

### Invalid\var-unused.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Variable definition. Variable not used`

## Valid

### Valid\frag-end.gql+

```gqlp

```

### Valid\frag-first.gql+

```gqlp

```

### Valid\var-null.gql+

```gqlp

```

### Valid\var.gql+

```gqlp

```
