# Globals-Invalid Schema Samples

### bad-parse.graphql+

```gqlp

```

##### Expected Parse errors

- `Expected text`

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
