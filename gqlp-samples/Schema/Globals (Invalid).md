# Globals (Invalid) Schema Samples

### Globals\Invalid\bad-parse.graphql+

```gqlp

```

##### Expected Parse errors

- `Parse Error: Invalid Schema. Expected text.`

### Globals\Invalid\category-diff-mod.graphql+

```gqlp
category { Test }
category { Test? }
output Test { }
```

##### Expected Verify errors

- `Multiple Categories with name 'test' can't be merged`
- `Group of SchemaCategory for 'test' is not singular Output~Modifiers~Option['Test~?~Parallel', 'Test~~Parallel']`

### Globals\Invalid\category-dup-alias.graphql+

```gqlp
category [a] { Test }
category [a] { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `Multiple Categories with alias 'a' found. Names 'test' 'output'`

### Globals\Invalid\category-dup-description.graphql+

```gqlp
"First category"
category { Test }
"Second category"
category { Test }
output Test { }
```

##### Expected Verify errors

- `Multiple Categories with name 'test' can't be merged`
- `Different values merging item => item.Description: First category != Second category`

### Globals\Invalid\category-duplicate.graphql+

```gqlp
category { Test }
category test { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `Multiple Categories with name 'test' can't be merged`
- `Group of SchemaCategory for 'test' is not singular Output~Modifiers~Option['Output~~Parallel', 'Test~~Parallel']`

### Globals\Invalid\category-output-generic.graphql+

```gqlp
category { Test }
output Test<$a> { | $a }
```

##### Expected Verify errors

- `Invalid Category Output. 'Test' is a generic Output type`

### Globals\Invalid\category-output-mod-param.graphql+

```gqlp
category { Test[$a] }
output Test { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined`

### Globals\Invalid\category-output-undef.graphql+

```gqlp
category { Test }
```

##### Expected Verify errors

- `Invalid Category Output. 'Test' not defined or not an Output type`

### Globals\Invalid\category-output-wrong.graphql+

```gqlp
category { Test }
input Test { }
```

##### Expected Verify errors

- `Invalid Category Output. 'Test' not defined or not an Output type`

### Globals\Invalid\directive-diff-option.graphql+

```gqlp
directive @Test { all }
directive @Test { ( repeatable ) all }
```

##### Expected Verify errors

- `Multiple Directives with name 'Test' can't be merged`
- `Group of SchemaDirective for 'Test' is not singular Option['Repeatable', 'Unique']`

### Globals\Invalid\directive-diff-param.graphql+

```gqlp
directive @Test(Test) { all }
directive @Test(Test?) { all }
input Test { }
```

##### Expected Verify errors

- `Multiple Directives with name 'Test' can't be merged`
- `Group of InputParam for 'Test' is not singular Modifiers['', '?']`

### Globals\Invalid\directive-no-param.graphql+

```gqlp
directive @Test(Test) { all }
```

##### Expected Verify errors

- `Invalid Directive Param. '( I@017/0001 Test )' not defined`

### Globals\Invalid\directive-param-mod-param.graphql+

```gqlp
directive @Test(TestIn[$a]) { all }
input TestIn { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined`

### Globals\Invalid\option-diff-name.graphql+

```gqlp
option Test { }
option Schema { }
```

##### Expected Verify errors

- `Multiple Schema names (Options) found`
