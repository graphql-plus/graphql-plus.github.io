# Merges-Invalid Schema Samples

### alt-diff-mod.graphql+

```gqlp
object Test { | Test1 }
object Test { | Test1[] }
object Test1 { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualAlternate for 'Test1' is not singular Modifiers['', '[]']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputAlternate for 'Test1' is not singular Modifiers['', '[]']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputAlternate for 'Test1' is not singular Modifiers['', '[]']`
- `Multiple Types with name 'Test' can't be merged`

### category-diff-mod.graphql+

```gqlp
category { Test }
category { Test? }
output Test { }
```

##### Expected Verify errors

- `Multiple Categories with name 'test' can't be merged`
- `Group of SchemaCategory for 'test' is not singular Output~Modifiers~Option['Test~?~Parallel', 'Test~~Parallel']`

### category-dup-alias.graphql+

```gqlp
category [a] { Test }
category [a] { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `Multiple Categories with alias 'a' found. Names 'test' 'output'`

### category-duplicate.graphql+

```gqlp
category { Test }
category test { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `Multiple Categories with name 'test' can't be merged`
- `Group of SchemaCategory for 'test' is not singular Output~Modifiers~Option['Output~~Parallel', 'Test~~Parallel']`

### directive-diff-option.graphql+

```gqlp
directive @Test { all }
directive @Test { ( repeatable ) all }
```

##### Expected Verify errors

- `Multiple Directives with name 'Test' can't be merged`
- `Group of SchemaDirective for 'Test' is not singular Option['Repeatable', 'Unique']`

### directive-diff-param.graphql+

```gqlp
directive @Test(Test) { all }
directive @Test(Test?) { all }
input Test { }
```

##### Expected Verify errors

- `Multiple Directives with name 'Test' can't be merged`
- `Group of InputParam for 'Test' is not singular Modifiers['', '?']`

### domain-diff-kind.graphql+

```gqlp
domain Test { string }
domain Test { number }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged`
- `Group of Domain for 'Test' is not singular Domain['Number', 'String']`
- `Multiple Types with name 'Test' can't be merged`

### domain-dup-alias.graphql+

```gqlp
domain Test [a] { Boolean }
domain Dup [a] { Boolean }
```

##### Expected Verify errors

- `Multiple Domains with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### domain-string-diff.graphql+

```gqlp
domain Test { string /a+/}
domain Test { string !/a+/ }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged`
- `Group of DomainRegex for 'a+' is not singular Regex['False', 'True']`
- `Multiple Types with name 'Test' can't be merged`

### enum-dup-alias.graphql+

```gqlp
enum Test [a] { test }
enum Dup [a] { dup }
```

##### Expected Verify errors

- `Multiple Enums with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### enum-parent-diff.graphql+

```gqlp
enum Test { :Parent test }
enum Test { test }
enum Parent { parent }
```

##### Expected Verify errors

- `Multiple Enums with name 'Test' can't be merged`
- `Group of Enum for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### field-diff-mod.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

### field-diff-type.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test1 }
object Test1 { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

### option-diff-name.graphql+

```gqlp
option Test { }
option Schema { }
```

##### Expected Verify errors

- `Multiple Schema names (Options) found`

### union-dup-alias.graphql+

```gqlp
union Test [a] { String }
union Dup [a] { Number }
```

##### Expected Verify errors

- `Multiple Unions with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### union-parent-diff.graphql+

```gqlp
union Test { :Parent Number }
union Test { Number }
union Parent { String }
```

##### Expected Verify errors

- `Multiple Unions with name 'Test' can't be merged`
- `Group of Union for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`
