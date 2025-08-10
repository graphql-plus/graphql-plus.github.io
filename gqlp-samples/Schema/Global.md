# Global Schema Samples

### category-descrs.graphql+

```gqlp
"A Category"
"described"
category { Name }
output Name { }
```

### category-output-descr.graphql+

```gqlp
category { "Output comment" Name }
output Name { }
```

### category-output-dict.graphql+

```gqlp
category { Name[*] }
output Name { }
```

### category-output-list.graphql+

```gqlp
category { Name[] }
output Name { }
```

### category-output-optional.graphql+

```gqlp
category { Name? }
output Name { }
```

### category-output.graphql+

```gqlp
category { Name }
output Name { }
```

### descr-backslash.graphql+

```gqlp
'A backslash ("\\") description'
output Name { }
```

### descr-between.graphql+

```gqlp
category { Name }
"A description between"
output Name { }
```

### descr-complex.graphql+

```gqlp
"A \"more\" 'Complicated' \\ description"
output Name { }
```

### descr-double.graphql+

```gqlp
"A 'double-quoted' description"
output Name { }
```

### descr-single.graphql+

```gqlp
'A "single-quoted" description'
output Name { }
```

### descr.graphql+

```gqlp
"A simple description"
output Name { }
```

### descrs.graphql+

```gqlp
"A simple description"
"With extra"
output Name { }
```

### directive-descr.graphql+

```gqlp
"A directive described"
directive @Name { all }
```

### directive-no-param.graphql+

```gqlp
directive @Name { all }
```

### directive-param-dict.graphql+

```gqlp
directive @Name(InName[String]) { all }
input InName { }
```

### directive-param-in.graphql+

```gqlp
directive @Name(InName) { all }
input InName { }
```

### directive-param-list.graphql+

```gqlp
directive @Name(InName[]) { all }
input InName { }
```

### directive-param-opt.graphql+

```gqlp
directive @Name(InName?) { all }
input InName { }
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
