# Valid Operation Samples

### frag-end.gql+

```gqlp
{...named}fragment named on Named{name}
```

### frag-first.gql+

```gqlp
&named:Named{name}{|named}
```

### var-null.gql+

```gqlp
($var:Id?=null):Boolean($var)
```

### var.gql+

```gqlp
($var):Boolean($var)
```
