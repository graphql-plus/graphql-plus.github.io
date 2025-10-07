# Globals-Invalid Schema Samples

### category-no-type.graphql+

```gqlp
category { }
```

##### Expected Verify errors

- `Invalid Category Output. '' not defined or not an Output type`
- `Invalid Category Output. Expected type name`
- `Invalid Category. Expected output type`
- `Invalid Schema. Expected no more text`

### category-output-generic.graphql+

```gqlp
category { Test }
output Test<$a:_Output> { | $a }
```

##### Expected Verify errors

- `'Test' is a generic Output type`

### category-output-mod-param.graphql+

```gqlp
category { Test[$a] }
output Test { }
```

##### Expected Verify errors

- `'a' not defined`

### category-output-undef.graphql+

```gqlp
category { Test }
```

##### Expected Verify errors

- `'Test' not defined or not an Output type`

### category-output-wrong.graphql+

```gqlp
category { Test }
input Test { }
```

##### Expected Verify errors

- `'Test' not defined or not an Output type`

### directive-no-param.graphql+

```gqlp
directive @Test(Test) { all }
```

##### Expected Verify errors

- `'Test' not defined`

### directive-param-mod-param.graphql+

```gqlp
directive @Test(TestIn[$a]) { all }
input TestIn { }
```

##### Expected Verify errors

- `'a' not defined`

### operation-no-category.graphql+

```gqlp
operation Test { { test } }
```

##### Expected Verify errors

- `Invalid Operation. Expected category`
- `Invalid Schema. Expected no more text`

### operation-no-result.graphql+

```gqlp
operation Test { test }
category { Test }
output Test { }
```

##### Expected Verify errors

- `Invalid Operation. Expected Object or Type`
- `Invalid Schema. Expected no more text`
