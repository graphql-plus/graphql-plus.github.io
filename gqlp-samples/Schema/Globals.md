# Globals Schema Samples

### Globals\category-description.graphql+

```gqlp
"A Category described"
category { CatDescr }
output CatDescr { }
```

### Globals\category-output-dict.graphql+

```gqlp
category { CatDict[*] }
output CatDict { }
```

### Globals\category-output-list.graphql+

```gqlp
category { CatList[] }
output CatList { }
```

### Globals\category-output-optional.graphql+

```gqlp
category { CatOpt? }
output CatOpt { }
```

### Globals\category-output.graphql+

```gqlp
category { Cat }
output Cat { }
```

### Globals\description-backslash.graphql+

```gqlp
'A backslash ("\\") description'
output DescrBackslash { }
```

### Globals\description-between.graphql+

```gqlp
category { DescrBetween }
"A description between"
output DescrBetween { }
```

### Globals\description-complex.graphql+

```gqlp
"A \"more\" 'Complicated' \\ description"
output DescrComplex { }
```

### Globals\description-double.graphql+

```gqlp
"A 'double-quoted' description"
output DescrDouble { }
```

### Globals\description-single.graphql+

```gqlp
'A "single-quoted" description'
output DescrSingle { }
```

### Globals\description.graphql+

```gqlp
"A simple description"
output Descr { }
```

### Globals\directive-description.graphql+

```gqlp
"A directive described"
directive @DirDescr { all }
```

### Globals\directive-no-param.graphql+

```gqlp
directive @DirNoParam { all }
```

### Globals\directive-param-dict.graphql+

```gqlp
directive @DirParamDict(DirParamIn[String]) { all }
input DirParamIn { }
```

### Globals\directive-param-in.graphql+

```gqlp
directive @DirParam(DirParamIn) { all }
input DirParamIn { }
```

### Globals\directive-param-list.graphql+

```gqlp
directive @DirParamList(DirParamIn[]) { all }
input DirParamIn { }
```

### Globals\directive-param-opt.graphql+

```gqlp
directive @DirParamOpt(DirParamIn?) { all }
input DirParamIn { }
```

### Globals\option-setting.graphql+

```gqlp
option Schema { global=true }
```
