# Invalid Operation Samples

### empty.gql+

```gqlp

```

##### Expected Verify errors

- `Expected text`

### error.gql+

```gqlp
{}
```

##### Expected Verify errors

- `Expected Object or Type`

### frag-undef.gql+

```gqlp
{...named}
```

##### Expected Verify errors

- `Spread not defined`

### frag-unused.gql+

```gqlp
&named:Named{name}{name}
```

##### Expected Verify errors

- `Spread not used`

### list-map-def.gql+

```gqlp
($var:Id[]={a:b}):Boolean($var)
```

##### Expected Verify errors

- `List Type cannot have Object default`

### list-null-map-def.gql+

```gqlp
($var:Id[]?={a:b}):Boolean($var)
```

##### Expected Verify errors

- `Optional List Type cannot have Object default`

### map-list-def.gql+

```gqlp
($var:Id[*]=[a]):Boolean($var)
```

##### Expected Verify errors

- `Dictionary Type must have Object default`

### map-null-list-def.gql+

```gqlp
($var:Id[*]?=[a]):Boolean($var)
```

##### Expected Verify errors

- `Optional Dictionary Type must have Object default`

### null-def-invalid.gql+

```gqlp
($var:Id=null):Boolean($var)
```

##### Expected Verify errors

- `Default of 'null' must be on Optional Type`

### var-undef.gql+

```gqlp
:Boolean($var)
```

##### Expected Verify errors

- `Variable not defined`

### var-unused.gql+

```gqlp
($var):Boolean
```

##### Expected Verify errors

- `Variable not used`
