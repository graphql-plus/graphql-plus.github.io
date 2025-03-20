# Globals Schema Samples

### category-descrs.graphql+

```gqlp
"A Category"
"described"
category { CatDescr }
output CatDescr { }
```

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

### descr-backslash.graphql+

```gqlp
'A backslash ("\\") description'
output DescrBackslash { }
```

### descr-between.graphql+

```gqlp
category { DescrBetween }
"A description between"
output DescrBetween { }
```

### descr-complex.graphql+

```gqlp
"A \"more\" 'Complicated' \\ description"
output DescrComplex { }
```

### descr-double.graphql+

```gqlp
"A 'double-quoted' description"
output DescrDouble { }
```

### descr-single.graphql+

```gqlp
'A "single-quoted" description'
output DescrSingle { }
```

### descr.graphql+

```gqlp
"A simple description"
output Descr { }
```

### descrs.graphql+

```gqlp
"A simple description"
"With extra"
output Descr { }
```

### directive-descr.graphql+

```gqlp
"A directive described"
directive @DirDescr { all }
```

### directive-no-param.graphql+

```gqlp
directive @DirNoParam { all }
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

### option-schema-alias.graphql+

```gqlp
option Schema [Alias] { }
```

### option-setting-descr.graphql+

```gqlp
option Schema { "Option" "Descr" descr=true }
```

### option-setting.graphql+

```gqlp
option Schema { global=true }
```
