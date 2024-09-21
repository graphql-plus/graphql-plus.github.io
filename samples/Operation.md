# Operation Samples

## Root

### error.gql+

```gqlp
{}
```

##### Expected Verify errors

- `Invalid Operation. Expected at least one field or selection.`
- `Invalid Operation. Expected Object or Type.`

### simple.gql+

```gqlp
{simple}
```

## Invalid

### Invalid\empty.gql+

```gqlp

```

##### Expected Verify errors

- `Invalid Operation. Expected text.`

### Invalid\frag-undef.gql+

```gqlp
{...named}
```

##### Expected Verify errors

- `Invalid Spread usage. Spread not defined.`

### Invalid\frag-unused.gql+

```gqlp
&named:Named{name}{name}
```

##### Expected Verify errors

- `Invalid Spread definition. Spread not used.`

### Invalid\list-map-def.gql+

```gqlp
($var:Id[]={a:b}):Boolean($var)
```

##### Expected Verify errors

- `Invalid Variable definition. List Type cannot have Object default.`

### Invalid\list-null-map-def.gql+

```gqlp
($var:Id[]?={a:b}):Boolean($var)
```

##### Expected Verify errors

- `Invalid Variable definition. Optional List Type cannot have Object default.`

### Invalid\map-list-def.gql+

```gqlp
($var:Id[*]=[a]):Boolean($var)
```

##### Expected Verify errors

- `Invalid Variable definition. Dictionary Type must have Object default.`

### Invalid\map-null-list-def.gql+

```gqlp
($var:Id[*]?=[a]):Boolean($var)
```

##### Expected Verify errors

- `Invalid Variable definition. Optional Dictionary Type must have Object default.`

### Invalid\null-def-invalid.gql+

```gqlp
($var:Id=null):Boolean($var)
```

##### Expected Verify errors

- `Invalid Variable definition. Default of 'null' must be on Optional Type.`

### Invalid\var-undef.gql+

```gqlp
:Boolean($var)
```

##### Expected Verify errors

- `Invalid Variable usage. Variable not defined.`

### Invalid\var-unused.gql+

```gqlp
($var):Boolean
```

##### Expected Verify errors

- `Invalid Variable definition. Variable not used.`

## Valid

### Valid\frag-end.gql+

```gqlp
{...named}fragment named on Named{name}
```

### Valid\frag-first.gql+

```gqlp
&named:Named{name}{|named}
```

### Valid\var-null.gql+

```gqlp
($var:Id?=null):Boolean($var)
```

### Valid\var.gql+

```gqlp
($var):Boolean($var)
```
