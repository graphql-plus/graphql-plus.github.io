# ValidMerges Schema Samples

### category-alias.graphql+

```gqlp
category [CatA1] { CatAlias }
category [CatA2] { CatAlias }
output CatAlias { }
```

### category-mod.graphql+

```gqlp
category [CatM1] { CatMods? }
category [CatM2] { CatMods? }
output CatMods { }
```

### category.graphql+

```gqlp
category { Category }
category category { Category }
output Category { }
```

### directive-alias.graphql+

```gqlp
directive @DirAlias [DirA1] { variable }
directive @DirAlias [DirA2] { field }
```

### directive-param.graphql+

```gqlp
directive @DirParam(DirParamIn) { operation }
directive @DirParam { fragment }
input DirParamIn { }
```

### directive.graphql+

```gqlp
directive @Dir { inline }
directive @Dir { spread }
```

### domain-alias.graphql+

```gqlp
domain NumAlias [Num1] { number }
domain NumAlias [Num2] { number }
```

### domain-boolean-diff.graphql+

```gqlp
domain BoolDiff { boolean true }
domain BoolDiff { boolean false }
```

### domain-boolean-same.graphql+

```gqlp
domain BoolSame { boolean true }
domain BoolSame { boolean true }
```

### domain-boolean.graphql+

```gqlp
domain Bool { boolean }
domain Bool { boolean }
```

### domain-enum-diff.graphql+

```gqlp
domain EnumDiff { enum true }
domain EnumDiff { enum false }
```

### domain-enum-same.graphql+

```gqlp
domain EnumSame { enum true }
domain EnumSame { enum true }
```

### domain-number-diff.graphql+

```gqlp
domain NumDiff { number 1~9 }
domain NumDiff { number }
```

### domain-number-same.graphql+

```gqlp
domain NumSame { number 1~9 }
domain NumSame { number 1~9 }
```

### domain-number.graphql+

```gqlp
domain Num { number }
domain Num { number }
```

### domain-string-diff.graphql+

```gqlp
domain StrDiff { string /a+/ }
domain StrDiff { string }
```

### domain-string-same.graphql+

```gqlp
domain StrSame { string /a+/ }
domain StrSame { string /a+/ }
```

### domain-string.graphql+

```gqlp
domain Str { string }
domain Str { string }
```

### enum-alias.graphql+

```gqlp
enum EnAlias [En1] { alias }
enum EnAlias [En2] { alias }
```

### enum-diff.graphql+

```gqlp
enum EnDiff { one }
enum EnDiff { two }
```

### enum-same-parent.graphql+

```gqlp
enum EnSameParent { :EnParent sameP }
enum EnSameParent { :EnParent sameP }
enum EnParent { parent }
```

### enum-same.graphql+

```gqlp
enum EnSame { same }
enum EnSame { same }
```

### enum-value-alias.graphql+

```gqlp
enum EnValAlias { value [val1] }
enum EnValAlias { value [val2] }
```

### object-alias.graphql+

```gqlp
object ObjName [Obj1] { }
object ObjName [Obj2] { }
```

### object-alt.graphql+

```gqlp
object ObjName { | ObjNameType }
object ObjName { | ObjNameType }
object ObjNameType { }
```

### object-field-alias.graphql+

```gqlp
object ObjName { field [field1]: ObjNameFld }
object ObjName { field [field2]: ObjNameFld }
object ObjNameFld { }
```

### object-field.graphql+

```gqlp
object ObjName { field: ObjNameFld }
object ObjName { field: ObjNameFld }
object ObjNameFld { }
```

### object-param.graphql+

```gqlp
object ObjName<$test> { test: $test }
object ObjName<$type> { type: $type }
```

### object-parent.graphql+

```gqlp
object ObjName { :ObjNameRef }
object ObjName { :ObjNameRef }
object ObjNameRef { }
```

### object.graphql+

```gqlp
object ObjName { }
object ObjName { }
```

### option-alias.graphql+

```gqlp
option Schema [Opt1] { }
option Schema [Opt2] { }
```

### option-value.graphql+

```gqlp
option Schema { setting=true }
option Schema { setting=[0] }
```

### option.graphql+

```gqlp
option Schema { }
option Schema { }
```

### output-field-enum-alias.graphql+

```gqlp
output FieldEnumAlias { field [field1] = Boolean.true }
output FieldEnumAlias { field [field2] = true }
```

### output-field-enum-value.graphql+

```gqlp
output FieldEnums { field = Boolean.true }
output FieldEnums { field = true }
```

### output-field-param.graphql+

```gqlp
output FieldParam { field(FieldParam1): FieldParamFld }
output FieldParam { field(FieldParam2): FieldParamFld }
input FieldParam1 { }
input FieldParam2 { }
output FieldParamFld { }
```

### union-alias.graphql+

```gqlp
union UnDiff [UnA1] { Boolean }
union UnDiff [UnA2] { Number }
```

### union-diff.graphql+

```gqlp
union UnDiff { Boolean }
union UnDiff { Number }
```

### union-same-parent.graphql+

```gqlp
union UnSameParent { :UnParent Boolean }
union UnSameParent { :UnParent Boolean }
union UnParent { String }
```

### union-same.graphql+

```gqlp
union UnSame { Boolean }
union UnSame { Boolean }
```
