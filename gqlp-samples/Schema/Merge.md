# Merge Schema Samples

### category-alias.graphql+

```gqlp
category [CatA1] { Name }
category [CatA2] { Name }
output Name { }
```

### category-descr.graphql+

```gqlp
"First category"
category { Name }
"Second category"
category { Name }
output Name { }
```

### category-mod.graphql+

```gqlp
category [CatM1] { Name? }
category [CatM2] { Name? }
output Name { }
```

### category.graphql+

```gqlp
category { Name }
category name { Name }
output Name { }
```

### directive-alias.graphql+

```gqlp
directive @Name [DirA1] { variable }
directive @Name [DirA2] { field }
```

### directive-param.graphql+

```gqlp
directive @Name(InName) { operation }
directive @Name { fragment }
input InName { }
```

### directive.graphql+

```gqlp
directive @Name { inline }
directive @Name { spread }
```

### domain-alias.graphql+

```gqlp
domain Name [Num1] { number }
domain Name [Num2] { number }
```

### domain-boolean-diff.graphql+

```gqlp
domain Name { boolean true }
domain Name { boolean false }
```

### domain-boolean-same.graphql+

```gqlp
domain Name { boolean true }
domain Name { boolean true }
```

### domain-boolean.graphql+

```gqlp
domain Name { boolean }
domain Name { boolean }
```

### domain-enum-diff.graphql+

```gqlp
domain Name { enum true }
domain Name { enum false }
```

### domain-enum-same.graphql+

```gqlp
domain Name { enum true }
domain Name { enum true }
```

### domain-number-diff.graphql+

```gqlp
domain Name { number 1~9 }
domain Name { number }
```

### domain-number-same.graphql+

```gqlp
domain Name { number 1~9 }
domain Name { number 1~9 }
```

### domain-number.graphql+

```gqlp
domain Name { number }
domain Name { number }
```

### domain-string-diff.graphql+

```gqlp
domain Name { string /a+/ }
domain Name { string }
```

### domain-string-same.graphql+

```gqlp
domain Name { string /a+/ }
domain Name { string /a+/ }
```

### domain-string.graphql+

```gqlp
domain Name { string }
domain Name { string }
```

### enum-alias.graphql+

```gqlp
enum Name [En1] { name }
enum Name [En2] { name }
```

### enum-diff.graphql+

```gqlp
enum Name { one }
enum Name { two }
```

### enum-same-parent.graphql+

```gqlp
enum Name { :PrntName name }
enum Name { :PrntName name }
enum PrntName { prnt_name }
```

### enum-same.graphql+

```gqlp
enum Name { name }
enum Name { name }
```

### enum-value-alias.graphql+

```gqlp
enum Name { name [val1] }
enum Name { name [val2] }
```

### object-alias.graphql+

```gqlp
object Name [Object1] { }
object Name [Object2] { }
```

### object-alt.graphql+

```gqlp
object Name { | NameType }
object Name { | NameType }
object NameType { }
```

### object-constraint.graphql+

```gqlp
object Name<$type:String> { field: $type }
object Name<$type:String> { str: $type }
```

### object-field-alias.graphql+

```gqlp
object Name { field [field1]: FldName }
object Name { field [field2]: FldName }
object FldName { }
```

### object-field-type-alias.graphql+

```gqlp
object Name { field: String }
object Name { field: String }
```

### object-field.graphql+

```gqlp
object Name { field: FldName }
object Name { field: FldName }
object FldName { }
```

### object-param-constraint.graphql+

```gqlp
object Name<$test:String> { test: $test }
object Name<$test:String> { type: $test }
```

### object-param-dup.graphql+

```gqlp
object Name<$test:String> { test: $test }
object Name<$test:String> { type: $test }
```

### object-param.graphql+

```gqlp
object Name<$test:String> { test: $test }
object Name<$type:String> { type: $type }
```

### object-parent.graphql+

```gqlp
object Name { :RefName }
object Name { :RefName }
object RefName { }
```

### object.graphql+

```gqlp
object Name { }
object Name { }
```

### option-alias.graphql+

```gqlp
option Schema [Opt1] { }
option Schema [Opt2] { }
```

### option-value.graphql+

```gqlp
option Schema { merged=true }
option Schema { merged=[0] }
```

### option.graphql+

```gqlp
option Schema { }
option Schema { }
```

### output-field-enum-alias.graphql+

```gqlp
output Name { field [field1] = Boolean.true }
output Name { field [field2] = true }
```

### output-field-enum-value.graphql+

```gqlp
output Name { field = Boolean.true }
output Name { field = true }
```

### output-field-param.graphql+

```gqlp
output Name { field(Name1): FldName }
output Name { field(Name2): FldName }
input Name1 { }
input Name2 { }
dual FldName { }
```

### union-alias.graphql+

```gqlp
union Name [UnA1] { Boolean }
union Name [UnA2] { Number }
```

### union-diff.graphql+

```gqlp
union Name { Boolean }
union Name { Number }
```

### union-same-parent.graphql+

```gqlp
union Name { :PrntName Boolean }
union Name { :PrntName Boolean }
union PrntName { String }
```

### union-same.graphql+

```gqlp
union Name { Boolean }
union Name { Boolean }
```
