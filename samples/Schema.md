# Schema Samples

## Root

### all.graphql+

```gqlp
"A Category"
category { "Category Result" All }
"A Directive"
directive @all { All }
"An Option"
option Schema { "Schema Setting" all="test" }
"A Domain"
domain Guid { String "Guid Regex" /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/ }
"An Enum"
enum One { "Label 2" Two "Label 3" Three }
"A Union"
union Many { "Guid Id" Guid "Numeric Id" Number }
"A Dual"
dual Field { "Some strings" strings: "Strings array" String[] }
"An Input"
input Param {
    "First Id" afterId: "Guid or Int" Many?
    "Last Id" beforeId: "Guid or Int" Many
    | "Alternate parameter" String
    }
"An Output"
output All {
    "Some items" items(Param?): Field
    | "Alternates" String
    }
```

### default.graphql+

```gqlp
category { Query }
output Query { }

category { (sequential) Mutation }
output Mutation { }

category { (single) Subscription }
output Subscription { }

output _Schema { }
```

### errors.graphql+

```gqlp
category query {}
directive @ {}
domain Other { Enum }
enum None [] {}
union Missing {}
dual Nothing [] {}
input Empty {}
output NoParams<> {}
```

##### Expected Parse errors

- `Invalid Category. Expected output type`
- `Invalid Category Output. Expected type name`
- `Invalid Schema. Expected no more text`

##### Expected Verify errors

- `Invalid Category Output. 'query' not defined or not an Output type`

## Globals

### Globals\category-descrs.graphql+

```gqlp
"A Category"
"described"
category { Name }
output Name { }
```

### Globals\category-output-dict.graphql+

```gqlp
category { Name[*] }
output Name { }
```

### Globals\category-output-list.graphql+

```gqlp
category { Name[] }
output Name { }
```

### Globals\category-output-optional.graphql+

```gqlp
category { Name? }
output Name { }
```

### Globals\category-output.graphql+

```gqlp
category { Name }
output Name { }
```

### Globals\descr-backslash.graphql+

```gqlp
'A backslash ("\\") description'
output Name { }
```

### Globals\descr-between.graphql+

```gqlp
category { Name }
"A description between"
output Name { }
```

### Globals\descr-complex.graphql+

```gqlp
"A \"more\" 'Complicated' \\ description"
output Name { }
```

### Globals\descr-double.graphql+

```gqlp
"A 'double-quoted' description"
output Name { }
```

### Globals\descr-single.graphql+

```gqlp
'A "single-quoted" description'
output Name { }
```

### Globals\descr.graphql+

```gqlp
"A simple description"
output Name { }
```

### Globals\descrs.graphql+

```gqlp
"A simple doc"
"With extra"
output Name { }
```

### Globals\directive-descr.graphql+

```gqlp
"A directive described"
directive @Name { all }
```

### Globals\directive-no-param.graphql+

```gqlp
directive @Name { all }
```

### Globals\directive-param-dict.graphql+

```gqlp
directive @Name(InName[String]) { all }
input InName { }
```

### Globals\directive-param-in.graphql+

```gqlp
directive @Name(InName) { all }
input InName { }
```

### Globals\directive-param-list.graphql+

```gqlp
directive @Name(InName[]) { all }
input InName { }
```

### Globals\directive-param-opt.graphql+

```gqlp
directive @Name(InName?) { all }
input InName { }
```

### Globals\option-schema-alias.graphql+

```gqlp
option Schema [Alias] { }
```

### Globals\option-setting-descr.graphql+

```gqlp
option Schema { "Option" "Descr" descr=true }
```

### Globals\option-setting.graphql+

```gqlp
option Schema { global=true }
```

## Globals (Invalid)

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

- `Invalid Directive Param. 'Test' not defined`

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

## Merges

### Merges\category-alias.graphql+

```gqlp
category [CatA1] { Name }
category [CatA2] { Name }
output Name { }
```

### Merges\category-descr.graphql+

```gqlp
"First category"
category { Name }
"Second category"
category { Name }
output Name { }
```

### Merges\category-mod.graphql+

```gqlp
category [CatM1] { Name? }
category [CatM2] { Name? }
output Name { }
```

### Merges\category.graphql+

```gqlp
category { Name }
category name { Name }
output Name { }
```

### Merges\directive-alias.graphql+

```gqlp
directive @Name [DirA1] { variable }
directive @Name [DirA2] { field }
```

### Merges\directive-param.graphql+

```gqlp
directive @Name(InName) { operation }
directive @Name { fragment }
input InName { }
```

### Merges\directive.graphql+

```gqlp
directive @Name { inline }
directive @Name { spread }
```

### Merges\domain-alias.graphql+

```gqlp
domain Name [Num1] { number }
domain Name [Num2] { number }
```

### Merges\domain-boolean-diff.graphql+

```gqlp
domain Name { boolean true }
domain Name { boolean false }
```

### Merges\domain-boolean-same.graphql+

```gqlp
domain Name { boolean true }
domain Name { boolean true }
```

### Merges\domain-boolean.graphql+

```gqlp
domain Name { boolean }
domain Name { boolean }
```

### Merges\domain-enum-diff.graphql+

```gqlp
domain Name { enum true }
domain Name { enum false }
```

### Merges\domain-enum-same.graphql+

```gqlp
domain Name { enum true }
domain Name { enum true }
```

### Merges\domain-number-diff.graphql+

```gqlp
domain Name { number 1~9 }
domain Name { number }
```

### Merges\domain-number-same.graphql+

```gqlp
domain Name { number 1~9 }
domain Name { number 1~9 }
```

### Merges\domain-number.graphql+

```gqlp
domain Name { number }
domain Name { number }
```

### Merges\domain-string-diff.graphql+

```gqlp
domain Name { string /a+/ }
domain Name { string }
```

### Merges\domain-string-same.graphql+

```gqlp
domain Name { string /a+/ }
domain Name { string /a+/ }
```

### Merges\domain-string.graphql+

```gqlp
domain Name { string }
domain Name { string }
```

### Merges\enum-alias.graphql+

```gqlp
enum Name [En1] { name }
enum Name [En2] { name }
```

### Merges\enum-diff.graphql+

```gqlp
enum Name { one }
enum Name { two }
```

### Merges\enum-same-parent.graphql+

```gqlp
enum Name { :PrntName name }
enum Name { :PrntName name }
enum PrntName { prnt_name }
```

### Merges\enum-same.graphql+

```gqlp
enum Name { name }
enum Name { name }
```

### Merges\enum-value-alias.graphql+

```gqlp
enum Name { name [val1] }
enum Name { name [val2] }
```

### Merges\object-alias.graphql+

```gqlp
object ObjName [Obj1] { }
object ObjName [Obj2] { }
```

### Merges\object-alt.graphql+

```gqlp
object ObjName { | ObjNameType }
object ObjName { | ObjNameType }
object ObjNameType { }
```

### Merges\object-field-alias.graphql+

```gqlp
object ObjName { field [field1]: FldObjName }
object ObjName { field [field2]: FldObjName }
object FldObjName { }
```

### Merges\object-field.graphql+

```gqlp
object ObjName { field: FldObjName }
object ObjName { field: FldObjName }
object FldObjName { }
```

### Merges\object-param.graphql+

```gqlp
object ObjName<$test> { test: $test }
object ObjName<$type> { type: $type }
```

### Merges\object-parent.graphql+

```gqlp
object ObjName { :RefObjName }
object ObjName { :RefObjName }
object RefObjName { }
```

### Merges\object.graphql+

```gqlp
object ObjName { }
object ObjName { }
```

### Merges\option-alias.graphql+

```gqlp
option Schema [Opt1] { }
option Schema [Opt2] { }
```

### Merges\option-value.graphql+

```gqlp
option Schema { merged=true }
option Schema { merged=[0] }
```

### Merges\option.graphql+

```gqlp
option Schema { }
option Schema { }
```

### Merges\output-field-enum-alias.graphql+

```gqlp
output Name { field [field1] = Boolean.true }
output Name { field [field2] = true }
```

### Merges\output-field-enum-value.graphql+

```gqlp
output Name { field = Boolean.true }
output Name { field = true }
```

### Merges\output-field-param.graphql+

```gqlp
output Name { field(Name1): FldName }
output Name { field(Name2): FldName }
input Name1 { }
input Name2 { }
dual FldName { }
```

### Merges\union-alias.graphql+

```gqlp
union Name [UnA1] { Boolean }
union Name [UnA2] { Number }
```

### Merges\union-diff.graphql+

```gqlp
union Name { Boolean }
union Name { Number }
```

### Merges\union-same-parent.graphql+

```gqlp
union Name { :PrntName Boolean }
union Name { :PrntName Boolean }
union PrntName { String }
```

### Merges\union-same.graphql+

```gqlp
union Name { Boolean }
union Name { Boolean }
```

## Objects

### Objects\alt-descr.graphql+

```gqlp
object ObjName { | "Test" "Descr" String }
```

### Objects\alt-dual.graphql+

```gqlp
object ObjName { | ObjDualName }
dual ObjDualName { alt: Number | String }
```

### Objects\alt-mod-Boolean.graphql+

```gqlp
object ObjName { | AltObjName[^] }
object AltObjName { alt: Number | String }
```

### Objects\alt-mod-param.graphql+

```gqlp
object ObjName<$mod> { | AltObjName[$mod] }
object AltObjName { alt: Number | String }
```

### Objects\alt-simple.graphql+

```gqlp
object ObjName { | String }
```

### Objects\alt.graphql+

```gqlp
object ObjName { | AltObjName }
object AltObjName { alt: Number | String }
```

### Objects\field-descr.graphql+

```gqlp
object ObjName { "Test" "Descr" field: * }
```

### Objects\field-dual.graphql+

```gqlp
object ObjName { field: FldObjName }
dual FldObjName { field: Number | String }
```

### Objects\field-mod-Enum.graphql+

```gqlp
object ObjName { field: *[EnumObjName] }
enum EnumObjName { value }
```

### Objects\field-mod-param.graphql+

```gqlp
object ObjName<$mod> { field: FldObjName[$mod] }
object FldObjName { field: Number | String }
```

### Objects\field-object.graphql+

```gqlp
object ObjName { field: FldObjName }
object FldObjName { field: Number | String }
```

### Objects\field-simple.graphql+

```gqlp
object ObjName { field: Number }
```

### Objects\field-type-descr.graphql+

```gqlp
object ObjName { field: "Test" "Descr" Number }
```

### Objects\field.graphql+

```gqlp
object ObjName { field: * }
```

### Objects\generic-alt-arg-descr.graphql+

```gqlp
object ObjName<$type> { | RefObjName<"Test" "Descr"$type> }
object RefObjName<$ref> { | $ref }
```

### Objects\generic-alt-arg.graphql+

```gqlp
object ObjName<$type> { | RefObjName<$type> }
object RefObjName<$ref> { | $ref }
```

### Objects\generic-alt-dual.graphql+

```gqlp
object ObjName { | RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
dual AltObjName { alt: Number | String }
```

### Objects\generic-alt-param.graphql+

```gqlp
object ObjName { | RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
object AltObjName { alt: Number | String }
```

### Objects\generic-alt-simple.graphql+

```gqlp
object ObjName { | RefObjName<String> }
object RefObjName<$ref> { | $ref }
```

### Objects\generic-alt.graphql+

```gqlp
object ObjName<$type> { | $type }
```

### Objects\generic-descr.graphql+

```gqlp
object ObjName<"Test" "Descr" $type> { field: $type }
```

### Objects\generic-dual.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### Objects\generic-field-arg.graphql+

```gqlp
object ObjName<$type> { field: RefObjName<$type> }
object RefObjName<$ref> { | $ref }
```

### Objects\generic-field-dual.graphql+

```gqlp
object ObjName { field: RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
dual AltObjName { alt: Number | String }
```

### Objects\generic-field-param.graphql+

```gqlp
object ObjName { field: RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
object AltObjName { alt: Number | String }
```

### Objects\generic-field.graphql+

```gqlp
object ObjName<$type> { field: $type }
```

### Objects\generic-param.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### Objects\generic-parent-arg.graphql+

```gqlp
object ObjName<$type> { :RefObjName<$type> }
object RefObjName<$ref> { | $ref }
```

### Objects\generic-parent-dual-parent.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { :$ref }
dual AltObjName { alt: Number | String }
```

### Objects\generic-parent-dual.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
dual AltObjName { alt: Number | String }
```

### Objects\generic-parent-param-parent.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { :$ref }
object AltObjName { alt: Number | String }
```

### Objects\generic-parent-param.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
object AltObjName { alt: Number | String }
```

### Objects\generic-parent.graphql+

```gqlp
object ObjName<$type> { :$type }
```

### Objects\input-field-descr-Number.graphql+

```gqlp
input Name { "Test" "Descr" field: Number = 0 }
```

### Objects\input-field-Enum.graphql+

```gqlp
input Name { field: EnumName = name }
enum EnumName { name }
```

### Objects\input-field-null.graphql+

```gqlp
input Name { field: FldName? = null }
dual FldName { }
```

### Objects\input-field-Number-descr.graphql+

```gqlp
input Name { field: "Test" "Descr" Number = 0 }
```

### Objects\input-field-Number.graphql+

```gqlp
input Name { field: Number = 0 }
```

### Objects\input-field-String.graphql+

```gqlp
input Name { field: String = '' }
```

### Objects\output-descr-param.graphql+

```gqlp
output Name { "Test" "Descr" field(InName): FldName }
dual FldName { }
input InName { param: Number | String }
```

### Objects\output-field-enum-parent.graphql+

```gqlp
output Name { field = EnumName.prnt_name }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### Objects\output-field-enum.graphql+

```gqlp
output Name { field = EnumName.name }
enum EnumName { name }
```

### Objects\output-field-value-descr.graphql+

```gqlp
output Name { field = "Test" "Descr" name }
enum EnumName { name }
```

### Objects\output-field-value.graphql+

```gqlp
output Name { field = name }
enum EnumName { name }
```

### Objects\output-generic-enum.graphql+

```gqlp
output Name { | RefName<EnumName.name> }
output RefName<$type> { field: $type }
enum EnumName { name }
```

### Objects\output-generic-value.graphql+

```gqlp
output Name { | RefName<name> }
output RefName<$type> { field: $type }
enum EnumName { name }
```

### Objects\output-param-descr.graphql+

```gqlp
output Name { field("Test" "Descr" InName): FldName }
dual FldName { }
input InName { param: Number | String }
```

### Objects\output-param-mod-Domain.graphql+

```gqlp
output Name { field(InName[DomName]): DomName }
input InName { param: Number | String }
domain DomName { number 1 ~ 10 }
```

### Objects\output-param-mod-param.graphql+

```gqlp
output Name<$mod> { field(InName[$mod]): DomName }
input InName { param: Number | String }
domain DomName { number 1 ~ 10 }
```

### Objects\output-param-type-descr.graphql+

```gqlp
output Name { field(InName): "Test" "Descr" FldName }
dual FldName { }
input InName { param: Number | String }
```

### Objects\output-param.graphql+

```gqlp
output Name { field(InName): FldName }
dual FldName { }
input InName { param: Number | String }
```

### Objects\output-parent-generic.graphql+

```gqlp
output Name { | RefName<EnumName.prnt_name> }
output RefName<$type> { field: $type }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### Objects\output-parent-param.graphql+

```gqlp
output Name { :PrntName field(InName): FldName }
output PrntName { field(PrntNameIn): FldName }
dual FldName { }
input InName { param: Number | String }
input PrntNameIn { parent: Number | String }
```

### Objects\parent-alt.graphql+

```gqlp
object ObjName { :RefObjName | Number }
object RefObjName {  parent: Number | String }
```

### Objects\parent-descr.graphql+

```gqlp
object ObjName { : "Test" "Descr" RefObjName }
object RefObjName { parent: Number | String }
```

### Objects\parent-dual.graphql+

```gqlp
object ObjName { :RefObjName }
dual RefObjName { parent: Number | String }
```

### Objects\parent-field.graphql+

```gqlp
object ObjName { :RefObjName field: Number }
object RefObjName { parent: Number | String }
```

### Objects\parent-param-diff.graphql+

```gqlp
object ObjName<$a> { :RefObjName<$a> field: $a }
object RefObjName<$b> { | $b }
```

### Objects\parent-param-same.graphql+

```gqlp
object ObjName<$a> { :RefObjName<$a> field: $a }
object RefObjName<$a> { | $a }
```

### Objects\parent.graphql+

```gqlp
object ObjName { :RefObjName }
object RefObjName { parent: Number | String }
```

## Objects (Invalid)

### Objects\Invalid\alt-diff-mod.graphql+

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

### Objects\Invalid\alt-mod-undef-param.graphql+

```gqlp
object Test { | Alt[$a] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'a' not defined`

### Objects\Invalid\alt-mod-undef.graphql+

```gqlp
object Test { | Alt[Domain] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Domain' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'Domain' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'Domain' not defined`

### Objects\Invalid\alt-mod-wrong.graphql+

```gqlp
object Test { | Alt[Test] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Input

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Output

- `Invalid Modifier. 'Test' invalid type`

### Objects\Invalid\alt-more.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | More }
object More { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via More`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Recurse`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via More`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Recurse`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via More`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Recurse`

### Objects\Invalid\alt-recurse.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test`

### Objects\Invalid\alt-self.graphql+

```gqlp
object Test { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself`

### Objects\Invalid\alt-simple-param.graphql+

```gqlp
object Test { | Number<String> }
```

##### Expected Verify errors Dual

- `Invalid Dual Alternate. Args invalid on Number. Expected 0, given 1`

##### Expected Verify errors Input

- `Invalid Input Alternate. Args invalid on Number. Expected 0, given 1`

##### Expected Verify errors Output

- `Invalid Output Alternate. Args invalid on Number. Expected 0, given 1`

### Objects\Invalid\dual-alt-input.graphql+

```gqlp
dual Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-alt-output.graphql+

```gqlp
dual Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-alt-param-input.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-alt-param-output.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-field-input.graphql+

```gqlp
dual Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-field-output.graphql+

```gqlp
dual Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-field-param-input.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-field-param-output.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-parent-input.graphql+

```gqlp
dual Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Input'`

### Objects\Invalid\dual-parent-output.graphql+

```gqlp
dual Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Output'`

### Objects\Invalid\dual-parent-param-input.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-parent-param-output.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\field-alias.graphql+

```gqlp
object Test { field1 [alias]: Test }
object Test { field2 [alias]: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\field-diff-mod.graphql+

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

### Objects\Invalid\field-diff-type.graphql+

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

### Objects\Invalid\field-mod-undef-param.graphql+

```gqlp
object Test { field: Test[$a] }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'a' not defined`

### Objects\Invalid\field-mod-undef.graphql+

```gqlp
object Test { field: Test[Random] }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Random' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'Random' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'Random' not defined`

### Objects\Invalid\field-mod-wrong.graphql+

```gqlp
object Test { field: Test[Test] }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Input

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Output

- `Invalid Modifier. 'Test' invalid type`

### Objects\Invalid\field-simple-param.graphql+

```gqlp
object Test { field: String<0> }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. Args invalid on String. Expected 0, given 1`

##### Expected Verify errors Input

- `Invalid Input Field. Args invalid on String. Expected 0, given 1`

##### Expected Verify errors Output

- `Invalid Output Field. Args invalid on String. Expected 0, given 1`

### Objects\Invalid\generic-alt-undef.graphql+

```gqlp
object Test { | $type }
```

##### Expected Verify errors Dual

- `Invalid Dual Alternate. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Alternate. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Alternate. '$type' not defined`

### Objects\Invalid\generic-arg-less.graphql+

```gqlp
object Test { field: Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Input

- `Invalid Input Field. Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Output

- `Invalid Output Field. Args mismatch on Ref. Expected 1, given 0`

### Objects\Invalid\generic-arg-more.graphql+

```gqlp
object Test<$type> { field: Ref<$type> }
object Ref { }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Input

- `Invalid Input Field. Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Output

- `Invalid Output Field. Args mismatch on Ref. Expected 0, given 1`

### Objects\Invalid\generic-arg-undef.graphql+

```gqlp
object Test { field: Ref<$type> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Field. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Field. '$type' not defined`

### Objects\Invalid\generic-field-undef.graphql+

```gqlp
object Test { field: $type }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Field. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Field. '$type' not defined`

### Objects\Invalid\generic-param-undef.graphql+

```gqlp
object Test { field: Ref<Test1> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. 'Test1' not defined`

##### Expected Verify errors Input

- `Invalid Input Field. 'Test1' not defined`

##### Expected Verify errors Output

- `Invalid Output Field. 'Test1' not defined`

### Objects\Invalid\generic-parent-less.graphql+

```gqlp
object Test { :Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Input

- `Invalid Input Parent. Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Output

- `Invalid Output Parent. Args mismatch on Ref. Expected 1, given 0`

### Objects\Invalid\generic-parent-more.graphql+

```gqlp
object Test { :Ref<Number> }
object Ref { }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Input

- `Invalid Input Parent. Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Output

- `Invalid Output Parent. Args mismatch on Ref. Expected 0, given 1`

### Objects\Invalid\generic-parent-undef.graphql+

```gqlp
object Test { :$type }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Parent. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Parent. '$type' not defined`

### Objects\Invalid\generic-unused.graphql+

```gqlp
object Test<$type> { }
```

##### Expected Verify errors Dual

- `Invalid Dual. '$type' not used`

##### Expected Verify errors Input

- `Invalid Input. '$type' not used`

##### Expected Verify errors Output

- `Invalid Output. '$type' not used`

### Objects\Invalid\input-alt-output.graphql+

```gqlp
input Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Alternate. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\input-field-null.graphql+

```gqlp
input Test { field: Test = null }
```

##### Expected Verify errors

- `Invalid Input Field Default. 'null' default requires Optional type, not 'Test'`

### Objects\Invalid\input-field-output.graphql+

```gqlp
input Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Field. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\input-parent-output.graphql+

```gqlp
input Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Parent. 'Bad' invalid type. Found 'Output'`

### Objects\Invalid\output-alt-input.graphql+

```gqlp
output Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Alternate. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\output-enum-bad.graphql+

```gqlp
output Test { field = unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum. Enum Value 'unknown' not defined`
- `Invalid Output Field. '' not defined`

### Objects\Invalid\output-enum-diff.graphql+

```gqlp
output Test { field = true }
output Test { field = false }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' is not singular ModifiedType['Boolean.false', 'Boolean.true']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\output-enumValue-bad.graphql+

```gqlp
output Test { field = Boolean.unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum Value. 'unknown' not a Value of 'Boolean'`

### Objects\Invalid\output-enumValue-wrong.graphql+

```gqlp
output Test { field = Wrong.unknown }
input Wrong { }
```

##### Expected Verify errors

- `Invalid Output Field Enum. 'Wrong' is not an Enum type`
- `Invalid Output Field. Type kind mismatch for Wrong. Found Input`

### Objects\Invalid\output-field-input.graphql+

```gqlp
output Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Field. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\output-generic-arg-enum-wrong.graphql+

```gqlp
output Test<$arg> { | Ref<$arg.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `Invalid Output. '$arg' not used`
- `Invalid Output Arg. Expected Enum value not allowed after Type parameter`
- `Invalid Schema. Expected declaration selector. 'unknown' unknown`
- `Invalid Schema. Expected no more text`

### Objects\Invalid\output-generic-enum-bad.graphql+

```gqlp
output Test { | Ref<Boolean.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `Invalid Output Arg Enum Value. 'unknown' not a Value of 'Boolean'`

### Objects\Invalid\output-generic-enum-wrong.graphql+

```gqlp
output Test { | Ref<Wrong.unknown> }
output Ref<$type> { field: $type }
output Wrong { }
```

##### Expected Verify errors

- `Invalid Output Arg Enum. 'Wrong' is not an Enum type`

### Objects\Invalid\output-param-diff.graphql+

```gqlp
output Test { field(Param): Test }
output Test { field(Param?): Test }
input Param { }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of InputParam for 'Param' is not singular Modifiers['', '?']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\output-param-mod-undef-param.graphql+

```gqlp
output Test { field(Param[$a]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined`

### Objects\Invalid\output-param-mod-undef.graphql+

```gqlp
output Test { field(Param[Domain]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Domain' not defined`

### Objects\Invalid\output-param-mod-wrong.graphql+

```gqlp
output Test { field(Param[Test]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Test' invalid type`

### Objects\Invalid\output-param-undef.graphql+

```gqlp
output Test { field(Param): Test }
```

##### Expected Verify errors

- `Invalid Input Param. 'Param' not defined`

### Objects\Invalid\output-parent-input.graphql+

```gqlp
output Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Parent. 'Bad' invalid type. Found 'Input'`

### Objects\Invalid\parent-alt-mod.graphql+

```gqlp
object Test { :Parent }
object Test { | Alt }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\parent-alt-more.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :More }
object More { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`

### Objects\Invalid\parent-alt-recurse.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`

### Objects\Invalid\parent-alt-self-more.graphql+

```gqlp
object Test { :Alt }
object Alt { | More }
object More { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More`

### Objects\Invalid\parent-alt-self-recurse.graphql+

```gqlp
object Test { :Alt }
object Alt { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

### Objects\Invalid\parent-alt-self.graphql+

```gqlp
object Test { :Alt }
object Alt { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`

### Objects\Invalid\parent-field-alias-more.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`

### Objects\Invalid\parent-field-alias-recurse.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`

### Objects\Invalid\parent-field-alias.graphql+

```gqlp
object Test { :Parent }
object Test { field1 [alias]: Test }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\parent-field-mod-more.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`

### Objects\Invalid\parent-field-mod-recurse.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`

### Objects\Invalid\parent-field-mod.graphql+

```gqlp
object Test { :Parent }
object Test { field: Test }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\parent-more.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :More }
object More { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be a child of itself, even recursively via Recurse`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be a child of itself, even recursively via Recurse`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be a child of itself, even recursively via Recurse`

### Objects\Invalid\parent-recurse.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test`

### Objects\Invalid\parent-self-alt-more.graphql+

```gqlp
object Test { | Alt }
object Alt { :More }
object More { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More`

### Objects\Invalid\parent-self-alt-recurse.graphql+

```gqlp
object Test { | Alt }
object Alt { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

### Objects\Invalid\parent-self-alt.graphql+

```gqlp
object Test { | Alt }
object Alt { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`

### Objects\Invalid\parent-self.graphql+

```gqlp
object Test { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be a child of itself`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be a child of itself`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be a child of itself`

### Objects\Invalid\parent-simple.graphql+

```gqlp
object Test { :String }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. 'String' invalid type. Found 'Domain'`

##### Expected Verify errors Input

- `Invalid Input Parent. 'String' invalid type. Found 'Domain'`

##### Expected Verify errors Output

- `Invalid Output Parent. 'String' invalid type. Found 'Domain'`

### Objects\Invalid\parent-undef.graphql+

```gqlp
object Test { :Parent }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. 'Parent' not defined`

##### Expected Verify errors Input

- `Invalid Input Parent. 'Parent' not defined`

##### Expected Verify errors Output

- `Invalid Output Parent. 'Parent' not defined`

### Objects\Invalid\unique-alias.graphql+

```gqlp
object Test [a] { }
object Dup [a] { }
```

##### Expected Verify errors Dual

- `Multiple Duals with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Input

- `Multiple Inputs with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Output

- `Multiple Outputs with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

## Simple

### Simple\domain-bool-descr.graphql+

```gqlp
domain Name { Boolean "DomBool" "Descr" true }
```

### Simple\domain-bool-parent.graphql+

```gqlp
domain Name { :PrntName Boolean false }
domain PrntName { Boolean true }
```

### Simple\domain-enum-all-descr.graphql+

```gqlp
domain Name { enum "DomAll" "Descr" EnumName.* }
enum EnumName { name enum_name }
```

### Simple\domain-enum-all-parent.graphql+

```gqlp
domain Name { enum EnumName.* }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### Simple\domain-enum-all.graphql+

```gqlp
domain Name { enum EnumName.* }
enum EnumName { name enum_name }
```

### Simple\domain-enum-descr.graphql+

```gqlp
domain Name { enum "DomEnum" "Descr" name }
enum EnumName { name }
```

### Simple\domain-enum-label.graphql+

```gqlp
domain Name { enum name }
enum EnumName { name }
```

### Simple\domain-enum-parent.graphql+

```gqlp
domain Name { :PrntName Enum enum_name }
domain PrntName { Enum prnt_name }
enum EnumName { enum_name prnt_name }
```

### Simple\domain-enum-unique-parent.graphql+

```gqlp
# domain Name { enum EnumName.* !PrntName.name DupName.name }
enum EnumName { :PrntName enum_name }
enum PrntName { name prnt_name }
enum DupName { name dup_name }
```

### Simple\domain-enum-unique.graphql+

```gqlp
# domain Name { enum EnumName.* !EnumName.name DupName.name }
enum EnumName { enum_name name }
enum EnumDomDup { name dup_name }
```

### Simple\domain-enum-value-parent.graphql+

```gqlp
domain Name { Enum EnumName.prnt_name }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### Simple\domain-enum-value.graphql+

```gqlp
domain Name { Enum EnumName.name }
enum EnumName { name }
```

### Simple\domain-number-descr.graphql+

```gqlp
domain Name { Number "DomNumber" "Descr" <2 }
```

### Simple\domain-number-parent.graphql+

```gqlp
domain Name { :PrntName Number 2>}
domain PrntName { Number <2 }
```

### Simple\domain-string-descr.graphql+

```gqlp
domain Name { String "DomString" "Descr" /a+/ }
```

### Simple\domain-string-parent.graphql+

```gqlp
domain Name { :PrntName String /a+/ }
domain PrntName { String /b+/ }
```

### Simple\enum-descr.graphql+

```gqlp
enum Name { "Enum" "Descr" name }
```

### Simple\enum-parent-alias.graphql+

```gqlp
enum Name { :PrntName val_name prnt_name[name] }
enum PrntName { prnt_name }
```

### Simple\enum-parent-dup.graphql+

```gqlp
enum Name { :PrntName name  }
enum PrntName { prnt_name[name] }
```

### Simple\enum-parent.graphql+

```gqlp
enum Name { :PrntName name }
enum PrntName { prnt_name }
```

### Simple\union-descr.graphql+

```gqlp
union Name { "Union" "Descr" Number }
```

### Simple\union-parent-dup.graphql+

```gqlp
union Name { :PrntName Number }
union PrntName { Number }
```

### Simple\union-parent.graphql+

```gqlp
union Name { :PrntName String }
union PrntName { Number }
```

## Simple (Invalid)

### Simple\Invalid\domain-diff-kind.graphql+

```gqlp
domain Test { string }
domain Test { number }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged`
- `Group of Domain for 'Test' is not singular Domain['Number', 'String']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\domain-dup-alias.graphql+

```gqlp
domain Test [a] { Boolean }
domain Dup [a] { Boolean }
```

##### Expected Verify errors

- `Multiple Domains with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\domain-enum-none.graphql+

```gqlp
domain Test { Enum }
```

##### Expected Verify errors

- `Invalid Domain. Expected enum Labels`

### Simple\Invalid\domain-enum-parent-unique.graphql+

```gqlp
domain Test { :Parent Enum Enum.value }
domain Parent { Enum Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items`
- `Group of DomainLabel for 'value' is not singular Excludes~EnumType['False~Dup', 'False~Enum']`

### Simple\Invalid\domain-enum-undef-all.graphql+

```gqlp
domain Test { enum Undef.* }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Undef' not an Enum type`

### Simple\Invalid\domain-enum-undef-member.graphql+

```gqlp
domain Test { enum Enum.undef }
enum Enum { value }
```

##### Expected Verify errors

- `Invalid Domain Enum Value. 'undef' not a Value of 'Enum'`

### Simple\Invalid\domain-enum-undef-value.graphql+

```gqlp
domain Test { enum Undef.value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Undef' not an Enum type`

### Simple\Invalid\domain-enum-undef.graphql+

```gqlp
domain Test { enum undef }
```

##### Expected Verify errors

- `Invalid Domain Enum Item. Enum Value 'undef' not defined`

### Simple\Invalid\domain-enum-unique-all.graphql+

```gqlp
domain Test { enum Enum.* Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup`

### Simple\Invalid\domain-enum-unique-member.graphql+

```gqlp
domain Test { enum Enum.value Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup`

### Simple\Invalid\domain-enum-unique.graphql+

```gqlp
domain Test { enum Enum.value Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup`

### Simple\Invalid\domain-enum-wrong.graphql+

```gqlp
domain Test { enum Bad.value }
output Bad { }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Bad' not an Enum type`

### Simple\Invalid\domain-number-parent.graphql+

```gqlp
domain Test { :Parent number 1> }
domain Parent { number !1> }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items`
- `Group of DomainRange for '1 >' is not singular Range['False', 'True']`

### Simple\Invalid\domain-parent-self-more.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :More Boolean }
domain More { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test`
- `Invalid Domain. 'Recurse' cannot be a child of itself, even recursively via Parent`
- `Invalid Domain. 'More' cannot be a child of itself, even recursively via Recurse`

### Simple\Invalid\domain-parent-self-parent.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via Parent`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test`

### Simple\Invalid\domain-parent-self-recurse.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test`
- `Invalid Domain. 'Recurse' cannot be a child of itself, even recursively via Parent`

### Simple\Invalid\domain-parent-self.graphql+

```gqlp
domain Test { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself`

### Simple\Invalid\domain-parent-undef.graphql+

```gqlp
domain Test { :Parent Boolean }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' not defined`

### Simple\Invalid\domain-parent-wrong-kind.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { String }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' invalid domain. Found 'String'`

### Simple\Invalid\domain-parent-wrong-type.graphql+

```gqlp
domain Test { :Parent Boolean }
output Parent { }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' invalid type. Found 'Output'`

### Simple\Invalid\domain-string-diff.graphql+

```gqlp
domain Test { string /a+/}
domain Test { string !/a+/ }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged`
- `Group of DomainRegex for 'a+' is not singular Regex['False', 'True']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\domain-string-parent.graphql+

```gqlp
domain Test { :Parent string /a+/}
domain Parent { string !/a+/ }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items`
- `Group of DomainRegex for 'a+' is not singular Regex['False', 'True']`

### Simple\Invalid\enum-dup-alias.graphql+

```gqlp
enum Test [a] { test }
enum Dup [a] { dup }
```

##### Expected Verify errors

- `Multiple Enums with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\enum-parent-alias-dup.graphql+

```gqlp
enum Test { :Parent test[alias] }
enum Parent { parent[alias] }
```

##### Expected Verify errors

- `Invalid Enum Child. Can't merge Test into Parent Parent`
- `Aliases of EnumLabel for 'alias' is not singular Name['parent', 'test']`

### Simple\Invalid\enum-parent-diff.graphql+

```gqlp
enum Test { :Parent test }
enum Test { test }
enum Parent { parent }
```

##### Expected Verify errors

- `Multiple Enums with name 'Test' can't be merged`
- `Group of Enum for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\enum-parent-undef.graphql+

```gqlp
enum Test { :Parent test }
```

##### Expected Verify errors

- `Invalid Enum Parent. 'Parent' not defined`

### Simple\Invalid\enum-parent-wrong.graphql+

```gqlp
enum Test { :Parent test }
output Parent { }
```

##### Expected Verify errors

- `Invalid Enum Parent. 'Parent' invalid type. Found 'Output'`

### Simple\Invalid\union-dup-alias.graphql+

```gqlp
union Test [a] { String }
union Dup [a] { Number }
```

##### Expected Verify errors

- `Multiple Unions with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\union-more-parent.graphql+

```gqlp
union Test { Recurse }
union Recurse { :Parent }
union Parent { More }
union More { :Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union. Expected at least one member`

### Simple\Invalid\union-more.graphql+

```gqlp
union Test { Bad }
union Bad { More }
union More { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`
- `Invalid Union Member. 'More' cannot refer to self, even recursively`

### Simple\Invalid\union-parent-diff.graphql+

```gqlp
union Test { :Parent Number }
union Test { Number }
union Parent { String }
```

##### Expected Verify errors

- `Multiple Unions with name 'Test' can't be merged`
- `Group of Union for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\union-parent-more.graphql+

```gqlp
union Test { :Parent String }
union Parent { More }
union More { :Bad String }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'More' cannot refer to self, even recursively`

### Simple\Invalid\union-parent-recurse.graphql+

```gqlp
union Test { :Parent String }
union Parent { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`

### Simple\Invalid\union-parent-undef.graphql+

```gqlp
union Test { :Parent Number }
```

##### Expected Verify errors

- `Invalid Union Parent. 'Parent' not defined`

### Simple\Invalid\union-parent-wrong.graphql+

```gqlp
union Test { :Parent Number }
output Parent { }
```

##### Expected Verify errors

- `Invalid Union Parent. 'Parent' invalid type. Found 'Output'`

### Simple\Invalid\union-parent.graphql+

```gqlp
union Test { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`

### Simple\Invalid\union-recurse-parent.graphql+

```gqlp
union Test { Bad }
union Bad { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`

### Simple\Invalid\union-recurse.graphql+

```gqlp
union Test { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`

### Simple\Invalid\union-self.graphql+

```gqlp
union Test { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self`

### Simple\Invalid\union-undef.graphql+

```gqlp
union Test { Bad }
```

##### Expected Verify errors

- `Invalid Union. 'Bad' not defined`

### Simple\Invalid\union-wrong.graphql+

```gqlp
union Test { Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid union. Type kind mismatch for Bad. Found Input`

### Simple\Invalid\unique-type-alias.graphql+

```gqlp
enum Test [a] { Value }
output Dup [a] { }
```

##### Expected Verify errors

- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\unique-types.graphql+

```gqlp
enum Test { Value }
output Test { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`
- `Group of Type for 'Test' is not singular Type['Enum', 'Output']`

## Specification

### Specification\Intro_Built-In.graphql+

```gqlp
output _Constant {
    | _Simple
    | _ConstantList
    | _ConstantMap
    }

output _Simple {
    | Boolean
    | _DomainValue<_DomainKind.Number Number>
    | _DomainValue<_DomainKind.String String>
    | _EnumValue
}

output _ConstantList {
    | _Constant[]
    }

output _ConstantMap {
    | _Constant[Simple]
    }

output _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

output _ModifierKeyed<$kind> {
    : _Modifier<$kind>
        by: _TypeSimple
        optional: Boolean
    }

output _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

output _Modifier<$kind> {
        modifierKind: $kind
    }
```

##### Expected Verify errors

- `Invalid Output Alternate. '_DomainValue' not defined`
- `Invalid Output Alternate. '_EnumValue' not defined`
- `Invalid Output Field. '_TypeSimple' not defined`
- `Invalid Output Alternate. '_DomainKind' not defined`
- `Invalid Output Arg Enum. '_DomainKind' is not an Enum type`

### Specification\Intro_Category.graphql+

```gqlp
output _Categories {
        category: _Category
        type: _Type
    | _Category
    | _Type
}

output _Category {
    : _Aliased
        resolution: _Resolution
        output: _TypeRef<_TypeKind.Output>
        modifiers: _Modifiers[]
    }

enum _Resolution { Parallel Sequential Single }
```

##### Expected Verify errors

- `Invalid Output Alternate. '_Type' not defined`
- `Invalid Output Parent. '_Aliased' not defined`
- `Invalid Output Field. '_Type' not defined`
- `Invalid Output Field. '_TypeRef' not defined`
- `Invalid Output Field. '_Modifiers' not defined`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Field. '_TypeKind' not defined`

### Specification\Intro_Common.graphql+

```gqlp
output _Type {
    | _BaseType<_TypeKind.Basic>
    | _BaseType<_TypeKind.Internal>
    | _TypeDual
    | _TypeEnum
    | _TypeInput
    | _TypeOutput
    | _TypeDomain
    | _TypeUnion
    }

output _BaseType<$kind> {
    : _Aliased
        typeKind: $kind
    }

output _ChildType<$kind $parent> {
    : _BaseType<$kind>
        parent: $parent
    }

output _ParentType<$kind $item $allItem> {
    : _ChildType<$kind _Named>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Domain Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

output _TypeRef<$kind> {
    : _Described
        typeKind: $kind
        name: _Identifier
}

output _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Domain>
    | _TypeRef<_TypeKind.Union>
    }
```

##### Expected Verify errors

- `Invalid Output Alternate. '_TypeDual' not defined`
- `Invalid Output Alternate. '_TypeEnum' not defined`
- `Invalid Output Alternate. '_TypeInput' not defined`
- `Invalid Output Alternate. '_TypeOutput' not defined`
- `Invalid Output Alternate. '_TypeDomain' not defined`
- `Invalid Output Alternate. '_TypeUnion' not defined`
- `Invalid Output Parent. '_Aliased' not defined`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Parent. '_Described' not defined`
- `Invalid Output Parent. '_Named' not defined`

### Specification\Intro_Complete.graphql+

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        types(_TypeFilter?): _Type[_Identifier]
        settings(_Filter?): _Setting[_Identifier]
    }

domain _Identifier { String /[A-Za-z_]+/ }

input _Filter {
        names: _NameFilter[]
        matchAliases: Boolean? = true
        aliases: _NameFilter[]
        returnByAlias: Boolean? = false
        returnReferencedTypes: Boolean? = false
    | _NameFilter[]
    }

"_NameFilter is a simple match expression against _Identifier where '.' matches any single character and '*' matches zero or more of any character."
domain _NameFilter { String /[A-Za-z_.*]+/ }

input _CategoryFilter {
    : _Filter
        resolutions: _Resolution[]
    }

input _TypeFilter {
    : _Filter
        kinds: _TypeKind[]
    }
dual _Aliased {
    : _Named
        aliases: _Identifier[]
    }

dual _Named {
    : _Described
        name: _Identifier
    }

dual _Described {
        description: String[]
    }
output _Categories {
        category: _Category
        type: _Type
    | _Category
    | _Type
}

output _Category {
    : _Aliased
        resolution: _Resolution
        output: _TypeRef<_TypeKind.Output>
        modifiers: _Modifiers[]
    }

enum _Resolution { Parallel Sequential Single }
output _Directives {
        directive: _Directive
        type: _Type
    | _Directive
    | _Type
}

output _Directive {
    : _Aliased
        parameters: _InputParam[]
        repeatable: Boolean
        locations: _[_Location]
    }

enum _Location { Operation Variable Field Inline Spread Fragment }

output _Setting {
    : _Named
        value: _Constant
}
output _Type {
    | _BaseType<_TypeKind.Basic>
    | _BaseType<_TypeKind.Internal>
    | _TypeDual
    | _TypeEnum
    | _TypeInput
    | _TypeOutput
    | _TypeDomain
    | _TypeUnion
    }

output _BaseType<$kind> {
    : _Aliased
        typeKind: $kind
    }

output _ChildType<$kind $parent> {
    : _BaseType<$kind>
        parent: $parent
    }

output _ParentType<$kind $item $allItem> {
    : _ChildType<$kind _Named>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Domain Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

output _TypeRef<$kind> {
    : _Described
        typeKind: $kind
        name: _Identifier
}

output _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Domain>
    | _TypeRef<_TypeKind.Union>
    }
output _Constant {
    | _Simple
    | _ConstantList
    | _ConstantMap
    }

output _Simple {
    | Boolean
    | _DomainValue<_DomainKind.Number Number>
    | _DomainValue<_DomainKind.String String>
    | _EnumValue
}

output _ConstantList {
    | _Constant[]
    }

output _ConstantMap {
    | _Constant[Simple]
    }

output _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

output _ModifierKeyed<$kind> {
    : _Modifier<$kind>
        by: _TypeSimple
        optional: Boolean
    }

output _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

output _Modifier<$kind> {
        modifierKind: $kind
    }
enum _DomainKind { Boolean Enum Number String }

output _TypeDomain {
    | _BaseDomain<_DomainKind.Boolean _DomainTrueFalse _DomainItemTrueFalse>
    | _BaseDomain<_DomainKind.Enum _DomainLabel _DomainItemLabel>
    | _BaseDomain<_DomainKind.Number _DomainRange _DomainItemRange>
    | _BaseDomain<_DomainKind.String _DomainRegex _DomainItemRegex>
    }

output _DomainRef<$kind> {
    : _TypeRef<_TypeKind.Domain>
        domainKind: $kind
    }

output _BaseDomain<$domain $item $domainItem> {
    : _ParentType<_TypeKind.Domain $item $domainItem>
        domainKind: $domain
    }

dual _BaseDomainItem {
    : _Described
        exclude: Boolean
    }

output _DomainItem<$item> {
    : $item
        domain: _Identifier
    }

output _DomainValue<$kind $value> {
    : _DomainRef<$kind>
        value: $value
    }
dual _DomainTrueFalse {
    : _BaseDomainItem
        value: Boolean
    }

output _DomainItemTrueFalse {
    : _DomainItem<_DomainTrueFalse>
    }
output _DomainLabel {
    : _BaseDomainItem
        label: _EnumValue
    }

output _DomainItemLabel {
    : _DomainItem<_DomainLabel>
    }
dual _DomainRange {
    : _BaseDomainItem
        lower: Number?
        upper: Number?
    }

output _DomainItemRange {
    : _DomainItem<_DomainRange>
    }
dual _DomainRegex {
    : _BaseDomainItem
        pattern: String
    }

output _DomainItemRegex {
    : _DomainItem<_DomainRegex>
    }
output _TypeEnum {
    : _ParentType<_TypeKind.Enum _Aliased _EnumLabel>
    }

dual _EnumLabel {
    : _Aliased
        enum: _Identifier
    }

output _EnumValue {
    : _TypeRef<_TypeKind.Enum>
        label: _Identifier
    }
output _TypeUnion {
    : _ParentType<_TypeKind.Union _UnionRef _UnionMember>
    }

output _UnionRef {
    : _TypeRef<_SimpleKind>
}

output _UnionMember {
    : _UnionRef
        union: _Identifier
    }
output _TypeObject<$kind $parent $field $alternate> {
    : _ChildType<$kind $parent>
        typeParams: _ObjTypeParam[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

output _ObjConstraint<$base> {
    | _TypeSimple
    | $base
}
output _ObjType<$base> {
    | _BaseType<_TypeKind.Internal>
    | _ObjConstraint<$base>
    }

output _ObjBase<$arg> {
    : _Described
        typeArgs: $arg[]
    | _ObjTypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
    | _ObjTypeParam
}

domain _TypeParam { :_Identifier String }

output _ObjTypeParam {
    : _Described
        typeParam: _TypeParam
}

output _Alternate<$arg> {
    : _ObjBase<$arg>
      collections: _Collections[]
    }

output _ObjectFor<$for> {
    : $for
        object: _Identifier
    }

output _Field<$base> {
    : _Aliased
      type: $base
      modifiers: _Modifiers[]
    }
output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualBase _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase<_DualTypeArg>
        dual: _Identifier
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualTypeArg>
        dual: _Identifier
    }

output _DualTypeArg {
    : _ObjTypeArg
        dual: _Identifier
    }
output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputBase _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase<_InputTypeArg>
        input: _Identifier
    | _DualBase
    }

output _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

output _InputAlternate {
    : _Alternate<_InputTypeArg>
        input: _Identifier
    }

output _InputTypeArg {
    : _ObjTypeArg
        input: _Identifier
    }

output _InputParam {
    : _InputBase
        modifiers: _Modifiers[]
        default: _Constant?
    }
output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputBase _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase<_OutputTypeArg>
        output: _Identifier
    | _DualBase
    }

output _OutputField {
    : _Field<_OutputBase>
        parameters: _InputParam[]
    | _OutputEnum
    }

output _OutputAlternate {
    : _Alternate<_OutputTypeArg>
        output: _Identifier
    }

output _OutputTypeArg {
    : _ObjTypeArg
        output: _Identifier
        label: _Identifier?
    }

output _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: _Identifier
        label: _Identifier
    }
```

### Specification\Intro_Declarations.graphql+

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        types(_TypeFilter?): _Type[_Identifier]
        settings(_Filter?): _Setting[_Identifier]
    }

domain _Identifier { String /[A-Za-z_]+/ }

input _Filter {
        names: _NameFilter[]
        matchAliases: Boolean? = true
        aliases: _NameFilter[]
        returnByAlias: Boolean? = false
        returnReferencedTypes: Boolean? = false
    | _NameFilter[]
    }

"_NameFilter is a simple match expression against _Identifier where '.' matches any single character and '*' matches zero or more of any character."
domain _NameFilter { String /[A-Za-z_.*]+/ }

input _CategoryFilter {
    : _Filter
        resolutions: _Resolution[]
    }

input _TypeFilter {
    : _Filter
        kinds: _TypeKind[]
    }
```

##### Expected Verify errors

- `Invalid Output Parent. '_Named' not defined`
- `Invalid Input Field. '_TypeKind' not defined`
- `Invalid Input Field. '_Resolution' not defined`
- `Invalid Output Field. '_Setting' not defined`
- `Invalid Output Field. '_Type' not defined`
- `Invalid Output Field. '_Directives' not defined`
- `Invalid Output Field. '_Categories' not defined`

### Specification\Intro_Directive.graphql+

```gqlp
output _Directives {
        directive: _Directive
        type: _Type
    | _Directive
    | _Type
}

output _Directive {
    : _Aliased
        parameters: _InputParam[]
        repeatable: Boolean
        locations: _[_Location]
    }

enum _Location { Operation Variable Field Inline Spread Fragment }

```

##### Expected Verify errors

- `Invalid Output Alternate. '_Type' not defined`
- `Invalid Output Parent. '_Aliased' not defined`
- `Invalid Output Field. '_Type' not defined`
- `Invalid Output Field. '_InputParam' not defined`

### Specification\Intro_Domain.graphql+

```gqlp
enum _DomainKind { Boolean Enum Number String }

output _TypeDomain {
    | _BaseDomain<_DomainKind.Boolean _DomainTrueFalse _DomainItemTrueFalse>
    | _BaseDomain<_DomainKind.Enum _DomainLabel _DomainItemLabel>
    | _BaseDomain<_DomainKind.Number _DomainRange _DomainItemRange>
    | _BaseDomain<_DomainKind.String _DomainRegex _DomainItemRegex>
    }

output _DomainRef<$kind> {
    : _TypeRef<_TypeKind.Domain>
        domainKind: $kind
    }

output _BaseDomain<$domain $item $domainItem> {
    : _ParentType<_TypeKind.Domain $item $domainItem>
        domainKind: $domain
    }

dual _BaseDomainItem {
    : _Described
        exclude: Boolean
    }

output _DomainItem<$item> {
    : $item
        domain: _Identifier
    }

output _DomainValue<$kind $value> {
    : _DomainRef<$kind>
        value: $value
    }
dual _DomainTrueFalse {
    : _BaseDomainItem
        value: Boolean
    }

output _DomainItemTrueFalse {
    : _DomainItem<_DomainTrueFalse>
    }
output _DomainLabel {
    : _BaseDomainItem
        label: _EnumValue
    }

output _DomainItemLabel {
    : _DomainItem<_DomainLabel>
    }
dual _DomainRange {
    : _BaseDomainItem
        lower: Number?
        upper: Number?
    }

output _DomainItemRange {
    : _DomainItem<_DomainRange>
    }
dual _DomainRegex {
    : _BaseDomainItem
        pattern: String
    }

output _DomainItemRegex {
    : _DomainItem<_DomainRegex>
    }
```

##### Expected Verify errors

- `Invalid Dual Parent. '_Described' not defined`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Field. '_EnumValue' not defined`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Parent. '_ParentType' not defined`
- `Invalid Output Parent. '_TypeKind' not defined`
- `Invalid Output Parent. '_TypeRef' not defined`

### Specification\Intro_Dual.graphql+

```gqlp
output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualBase _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase<_DualTypeArg>
        dual: _Identifier
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualTypeArg>
        dual: _Identifier
    }

output _DualTypeArg {
    : _ObjTypeArg
        dual: _Identifier
    }
```

##### Expected Verify errors

- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Parent. '_Alternate' not defined`
- `Invalid Output Parent. '_Field' not defined`
- `Invalid Output Parent. '_ObjBase' not defined`
- `Invalid Output Parent. '_ObjTypeArg' not defined`
- `Invalid Output Parent. '_TypeKind' not defined`
- `Invalid Output Parent. '_TypeObject' not defined`

### Specification\Intro_Enum.graphql+

```gqlp
output _TypeEnum {
    : _ParentType<_TypeKind.Enum _Aliased _EnumLabel>
    }

dual _EnumLabel {
    : _Aliased
        enum: _Identifier
    }

output _EnumValue {
    : _TypeRef<_TypeKind.Enum>
        label: _Identifier
    }
```

##### Expected Verify errors

- `Invalid Dual Parent. '_Aliased' not defined`
- `Invalid Output Parent. '_ParentType' not defined`
- `Invalid Output Parent. '_TypeRef' not defined`
- `Invalid Dual Field. '_Identifier' not defined`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Parent. '_TypeKind' not defined`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Parent. '_Aliased' not defined`

### Specification\Intro_Input.graphql+

```gqlp
output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputBase _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase<_InputTypeArg>
        input: _Identifier
    | _DualBase
    }

output _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

output _InputAlternate {
    : _Alternate<_InputTypeArg>
        input: _Identifier
    }

output _InputTypeArg {
    : _ObjTypeArg
        input: _Identifier
    }

output _InputParam {
    : _InputBase
        modifiers: _Modifiers[]
        default: _Constant?
    }
```

##### Expected Verify errors

- `Invalid Output Alternate. '_DualBase' not defined`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Field. '_Constant' not defined`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Field. '_Modifiers' not defined`
- `Invalid Output Parent. '_Alternate' not defined`
- `Invalid Output Parent. '_Field' not defined`
- `Invalid Output Parent. '_ObjBase' not defined`
- `Invalid Output Parent. '_ObjTypeArg' not defined`
- `Invalid Output Parent. '_TypeKind' not defined`
- `Invalid Output Parent. '_TypeObject' not defined`

### Specification\Intro_Names.graphql+

```gqlp
dual _Aliased {
    : _Named
        aliases: _Identifier[]
    }

dual _Named {
    : _Described
        name: _Identifier
    }

dual _Described {
        description: String[]
    }
```

##### Expected Verify errors

- `Invalid Dual Field. '_Identifier' not defined`

### Specification\Intro_Object.graphql+

```gqlp
output _TypeObject<$kind $parent $field $alternate> {
    : _ChildType<$kind $parent>
        typeParams: _ObjTypeParam[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

output _ObjConstraint<$base> {
    | _TypeSimple
    | $base
}
output _ObjType<$base> {
    | _BaseType<_TypeKind.Internal>
    | _ObjConstraint<$base>
    }

output _ObjBase<$arg> {
    : _Described
        typeArgs: $arg[]
    | _ObjTypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
    | _ObjTypeParam
}

domain _TypeParam { :_Identifier String }

output _ObjTypeParam {
    : _Described
        typeParam: _TypeParam
}

output _Alternate<$arg> {
    : _ObjBase<$arg>
      collections: _Collections[]
    }

output _ObjectFor<$for> {
    : $for
        object: _Identifier
    }

output _Field<$base> {
    : _Aliased
      type: $base
      modifiers: _Modifiers[]
    }
```

##### Expected Verify errors

- `Invalid Domain Parent. '_Identifier' not defined`
- `Invalid Output Alternate. '_BaseType' not defined`
- `Invalid Output Alternate. '_TypeKind' not defined`
- `Invalid Output Alternate. '_TypeSimple' not defined`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Field. '_Collections' not defined`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Field. '_Modifiers' not defined`
- `Invalid Output Parent. '_Aliased' not defined`
- `Invalid Output Parent. '_ChildType' not defined`
- `Invalid Output Parent. '_Described' not defined`
- `Invalid Output Parent. '_TypeKind' not defined`
- `Invalid Output Parent. '_TypeRef' not defined`

### Specification\Intro_Option.graphql+

```gqlp
output _Setting {
    : _Named
        value: _Constant
}
```

##### Expected Verify errors

- `Invalid Output Parent. '_Named' not defined`
- `Invalid Output Field. '_Constant' not defined`

### Specification\Intro_Output.graphql+

```gqlp
output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputBase _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase<_OutputTypeArg>
        output: _Identifier
    | _DualBase
    }

output _OutputField {
    : _Field<_OutputBase>
        parameters: _InputParam[]
    | _OutputEnum
    }

output _OutputAlternate {
    : _Alternate<_OutputTypeArg>
        output: _Identifier
    }

output _OutputTypeArg {
    : _ObjTypeArg
        output: _Identifier
        label: _Identifier?
    }

output _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: _Identifier
        label: _Identifier
    }
```

##### Expected Verify errors

- `Invalid Output Alternate. '_DualBase' not defined`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Field. '_InputParam' not defined`
- `Invalid Output Parent. '_Alternate' not defined`
- `Invalid Output Parent. '_Field' not defined`
- `Invalid Output Parent. '_ObjBase' not defined`
- `Invalid Output Parent. '_ObjTypeArg' not defined`
- `Invalid Output Parent. '_TypeKind' not defined`
- `Invalid Output Parent. '_TypeObject' not defined`
- `Invalid Output Parent. '_TypeRef' not defined`

### Specification\Intro_Union.graphql+

```gqlp
output _TypeUnion {
    : _ParentType<_TypeKind.Union _UnionRef _UnionMember>
    }

output _UnionRef {
    : _TypeRef<_SimpleKind>
}

output _UnionMember {
    : _UnionRef
        union: _Identifier
    }
```

##### Expected Verify errors

- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Parent. '_ParentType' not defined`
- `Invalid Output Parent. '_SimpleKind' not defined`
- `Invalid Output Parent. '_TypeKind' not defined`
- `Invalid Output Parent. '_TypeRef' not defined`
