# Operation Samples

## Root

### error.gql+

```gqlp
{}
```

### simple.gql+

```gqlp
{simple}
```

## Invalid

### Invalid\empty.gql+

```gqlp

```

### Invalid\frag-undef.gql+

```gqlp
{...named}
```

### Invalid\frag-unused.gql+

```gqlp
&named:Named{name}{name}
```

### Invalid\list-map-def.gql+

```gqlp
($var:Id[]={a:b}):Boolean($var)
```

### Invalid\list-null-map-def.gql+

```gqlp
($var:Id[]?={a:b}):Boolean($var)
```

### Invalid\map-list-def.gql+

```gqlp
($var:Id[*]=[a]):Boolean($var)
```

### Invalid\map-null-list-def.gql+

```gqlp
($var:Id[*]?=[a]):Boolean($var)
```

### Invalid\null-def-invalid.gql+

```gqlp
($var:Id=null):Boolean($var)
```

### Invalid\var-undef.gql+

```gqlp
:Boolean($var)
```

### Invalid\var-unused.gql+

```gqlp
($var):Boolean
```

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
