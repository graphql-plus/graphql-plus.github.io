# Operation Samples

## Root

### error.gql+

```
{}
```

### simple.gql+

```
{simple}
```

## Invalid

### Invalid\empty.gql+

```

```

### Invalid\frag-undef.gql+

```
{...named}
```

### Invalid\frag-unused.gql+

```
&named:Named{name}{name}
```

### Invalid\list-map-def.gql+

```
($var:Id[]={a:b}):Boolean($var)
```

### Invalid\list-null-map-def.gql+

```
($var:Id[]?={a:b}):Boolean($var)
```

### Invalid\map-list-def.gql+

```
($var:Id[*]=[a]):Boolean($var)
```

### Invalid\map-null-list-def.gql+

```
($var:Id[*]?=[a]):Boolean($var)
```

### Invalid\null-def-invalid.gql+

```
($var:Id=null):Boolean($var)
```

### Invalid\var-undef.gql+

```
:Boolean($var)
```

### Invalid\var-unused.gql+

```
($var):Boolean
```

## Valid

### Valid\frag-end.gql+

```
{...named}fragment named on Named{name}
```

### Valid\frag-first.gql+

```
&named:Named{name}{|named}
```

### Valid\var-null.gql+

```
($var:Id?=null):Boolean($var)
```

### Valid\var.gql+

```
($var):Boolean($var)
```
