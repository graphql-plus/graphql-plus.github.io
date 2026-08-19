# Operation Samples

## Root

### complex-dict.gql+

```gqlp
{complex[String]{first last}}
```

### complex-list.gql+

```gqlp
{complex[]{first last}}
```

### complex.gql+

```gqlp
{complex{first last}}
```

### dictionary.gql+

```gqlp
{dict[String]}
```

### domain-argument.gql+

```gqlp
:Number("first")
```

### domain-dict.gql+

```gqlp
:Number[String]
```

### domain-list.gql+

```gqlp
:Number[]
```

### domain-optional.gql+

```gqlp
:Number?
```

### domain.gql+

```gqlp
:Number
```

### fragment-end.gql+

```gqlp
{...named}fragment named on Named{name}
```

### fragment-list.gql+

```gqlp
&named:Named{name}{|named[]}
```

### fragment.gql+

```gqlp
&named:Named{name}{|named}
```

### inline-list.gql+

```gqlp
{simple |[]{extra}}
```

### inline-typed.gql+

```gqlp
{simple |:Extra{extra}}
```

### inline.gql+

```gqlp
{simple |{extra}}
```

### list.gql+

```gqlp
{list[]}
```

### simple-alias.gql+

```gqlp
{alias:simple}
```

### simple-argument.gql+

```gqlp
{simple(true)}
```

### simple-optional.gql+

```gqlp
{simple?}
```

### simple-required.gql+

```gqlp
{simple!}
```

### simple.gql+

```gqlp
{simple}
```

### variable-null.gql+

```gqlp
($var:Id?=null):Boolean($var)
```

### variable.gql+

```gqlp
($var):Boolean($var)
```
