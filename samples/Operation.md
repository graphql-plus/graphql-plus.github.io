# Operation Samples

## Root

### frag-end.gql+

```gqlp
{...named}fragment named on Named{name}
```

### frag-first.gql+

```gqlp
&named:Named{name}{|named}
```

### simple.gql+

```gqlp
{simple}
```

### var-null.gql+

```gqlp
($var:Id?=null):Boolean($var)
```

### var.gql+

```gqlp
($var):Boolean($var)
```

## Invalid (Invalid)

### Invalid\empty.gql+

```gqlp

```

##### Expected Verify errors

- `Expected text`

### Invalid\error.gql+

```gqlp
{}
```

##### Expected Verify errors

- `Expected Object or Type`

### Invalid\frag-undef.gql+

```gqlp
{...named}
```

##### Expected Verify errors

- `Spread not defined`

### Invalid\frag-unused.gql+

```gqlp
&named:Named{name}{name}
```

##### Expected Verify errors

- `Spread not used`

### Invalid\list-map-def.gql+

```gqlp
($var:Id[]={a:b}):Boolean($var)
```

##### Expected Verify errors

- `List Type cannot have Object default`

### Invalid\list-null-map-def.gql+

```gqlp
($var:Id[]?={a:b}):Boolean($var)
```

##### Expected Verify errors

- `Optional List Type cannot have Object default`

### Invalid\map-list-def.gql+

```gqlp
($var:Id[*]=[a]):Boolean($var)
```

##### Expected Verify errors

- `Dictionary Type must have Object default`

### Invalid\map-null-list-def.gql+

```gqlp
($var:Id[*]?=[a]):Boolean($var)
```

##### Expected Verify errors

- `Optional Dictionary Type must have Object default`

### Invalid\null-def-invalid.gql+

```gqlp
($var:Id=null):Boolean($var)
```

##### Expected Verify errors

- `Default of 'null' must be on Optional Type`

### Invalid\var-undef.gql+

```gqlp
:Boolean($var)
```

##### Expected Verify errors

- `Variable not defined`

### Invalid\var-unused.gql+

```gqlp
($var):Boolean
```

##### Expected Verify errors

- `Variable not used`
