# ValidGlobals Schema Samples

### category-output-dict.graphql+

```gqlp
category { CatDict[*] }
output CatDict { }
```

### category-output-list.graphql+

```gqlp
category { CatList[] }
output CatList { }
```

### category-output-optional.graphql+

```gqlp
category { CatOpt? }
output CatOpt { }
```

### category-output.graphql+

```gqlp
category { Cat }
output Cat { }
```

### description-backslash.graphql+

```gqlp
'A backslash ("\\") description'
output DescrBackslash { }
```

### description-between.graphql+

```gqlp
category { DescrBetween }
"A description between"
output DescrBetween { }
```

### description-complex.graphql+

```gqlp
"A \"more\" 'Complicated' \\ description"
output DescrComplex { }
```

### description-double.graphql+

```gqlp
"A 'double-quoted' description"
output DescrDouble { }
```

### description-single.graphql+

```gqlp
'A "single-quoted" description'
output DescrSingle { }
```

### description.graphql+

```gqlp
"A simple description"
output Descr { }
```

### directive-param-dict.graphql+

```gqlp
directive @DirParamDict(DirParamIn[String]) { all }
input DirParamIn { }
```

### directive-param-in.graphql+

```gqlp
directive @DirParam(DirParamIn) { all }
input DirParamIn { }
```

### directive-param-list.graphql+

```gqlp
directive @DirParamList(DirParamIn[]) { all }
input DirParamIn { }
```

### directive-param-opt.graphql+

```gqlp
directive @DirParamOpt(DirParamIn?) { all }
input DirParamIn { }
```

### operation-category.graphql+

```gqlp
operation Op { op :String }
category { Op }
output Op { }
```

### option-setting.graphql+

```gqlp
option Schema { setting = true }
```
