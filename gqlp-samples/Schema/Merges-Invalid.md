# Merges-Invalid Schema Samples

### alt-diff-mod.graphql+

```gqlp
object Test { | Test1 }
object Test { | Test1[] }
object Test1 { }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Group of ObjAlt for 'Test1' not singular Modifiers['', '[]']`

### category-diff-mod.graphql+

```gqlp
category { Test }
category { Test? }
output Test { }
```

##### Expected Verify errors

- `'test' can't be merged`
- `Group of SchemaCategory for 'test' not singular Output~Modifiers~Option['Test~?~Parallel', 'Test~~Parallel']`

### category-dup-alias.graphql+

```gqlp
category [a] { Test }
category [a] { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `alias 'a' found. Names 'test' 'output'`

### category-duplicate.graphql+

```gqlp
category { Test }
category test { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `'test' can't be merged`
- `Group of SchemaCategory for 'test' not singular Output~Modifiers~Option['Output~~Parallel', 'Test~~Parallel']`

### constraint-diff.graphql+

```gqlp
object Test<$type:0> { num: $type }
object Test<$type:String> { str: $type }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Different values merging p => p.Constraint`

##### Expected Verify errors Dual

- `'Test' can't be merged`
- `Different values merging p => p.Constraint`

##### Expected Verify errors Input

- `'Test' can't be merged`
- `Different values merging p => p.Constraint`

##### Expected Verify errors Output

- `'Test' can't be merged`
- `Different values merging p => p.Constraint`

### directive-diff-option.graphql+

```gqlp
directive @Test { all }
directive @Test { ( repeatable ) all }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Group of SchemaDirective for 'Test' not singular Option['Repeatable', 'Unique']`

### directive-diff-param.graphql+

```gqlp
directive @Test(Test) { all }
directive @Test(Test?) { all }
input Test { }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Group of InputParam for 'Test' not singular Modifiers['', '?']`

### domain-diff-kind.graphql+

```gqlp
domain Test { string }
domain Test { number }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Group of Domain for 'Test' not singular Domain['Number', 'String']`

### domain-dup-alias.graphql+

```gqlp
domain Test [a] { Boolean }
domain Dup [a] { Boolean }
```

##### Expected Verify errors

- `alias 'a' found. Names 'Test' 'Dup'`

### domain-string-diff.graphql+

```gqlp
domain Test { string /a+/}
domain Test { string !/a+/ }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Group of DomainRegex for 'a+' not singular Regex['False', 'True']`

### enum-dup-alias.graphql+

```gqlp
enum Test [a] { test }
enum Dup [a] { dup }
```

##### Expected Verify errors

- `alias 'a' found. Names 'Test' 'Dup'`

### enum-parent-diff.graphql+

```gqlp
enum Test { :Parent test }
enum Test { test }
enum Parent { parent }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Group of Enum for 'Test' not singular Parent['', 'Parent']`

### field-diff-mod.graphql+

```gqlp
object Test { field: Field }
object Test { field: Field[] }
object Field { }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `for 'field' not singular ModifiedType_Label['Field', 'Field []']`

### field-diff-type.graphql+

```gqlp
object Test { field: Test1 }
object Test { field: Test2 }
object Test1 { }
object Test2 { }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `for 'field' not singular ModifiedType_Label['Test1', 'Test2']`

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

- `alias 'a' found. Names 'Test' 'Dup'`

### union-parent-diff.graphql+

```gqlp
union Test { :Parent Number }
union Test { Number }
union Parent { String }
```

##### Expected Verify errors

- `'Test' can't be merged`
- `Group of Union for 'Test' not singular Parent['', 'Parent']`
