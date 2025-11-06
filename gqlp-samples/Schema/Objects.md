# Objects Schema Samples

### alt-descr.graphql+

```gqlp
object Name { | "Test" "Descr" String }
```

### alt-dual.graphql+

```gqlp
object Name { | ObjDualName }
dual ObjDualName { alt: Number | String }
```

### alt-enum.graphql+

```gqlp
object Name { ! EnumName.name }
enum EnumName { name }
```

### alt-mod-Boolean.graphql+

```gqlp
object Name { | AltName[^] }
object AltName { alt: Number | String }
```

### alt-mod-param.graphql+

```gqlp
object Name<$mod:String> { | AltName[$mod] }
object AltName { alt: Number | String }
```

### alt-simple.graphql+

```gqlp
object Name { | String }
```

### alt.graphql+

```gqlp
object Name { | AltName }
object AltName { alt: Number | String }
```

### constraint-alt-domain.graphql+

```gqlp
object Name { | RefName<DomName> }
object RefName<$ref:String> { | $ref }
domain DomName { String /\w+/ }
```

### constraint-alt-dual.graphql+

```gqlp
object Name { | RefName<AltName> }
object RefName<$ref:PrntName> { | $ref }
dual PrntName { | String }
object AltName { :PrntName alt: Number }
```

### constraint-alt-obj.graphql+

```gqlp
object Name { | RefName<AltName> }
object RefName<$ref:PrntName> { | $ref }
object PrntName { | String }
object AltName { :PrntName alt: Number }
```

### constraint-alt.graphql+

```gqlp
object Name<$type:Number> { | $type }
```

### constraint-dom-enum.graphql+

```gqlp
object Name { | RefName<name> }
object RefName<$type:JustName> { field: $type }
enum EnumName { name other }
domain JustName { enum EnumName.name }
```

### constraint-enum-parent.graphql+

```gqlp
object Name { | RefName<name> }
object RefName<$type:ParentName> { field: $type }
enum EnumName { :ParentName name }
enum ParentName { parentName }
```

### constraint-enum.graphql+

```gqlp
object Name { | RefName<name> }
object RefName<$type:EnumName> { field: $type }
enum EnumName { name }
```

### constraint-field-domain.graphql+

```gqlp
object Name { :RefName<DomName> }
object RefName<$ref:String> { field: $ref }
domain DomName { String /\w+/ }
```

### constraint-field-dual.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:PrntName> { field: $ref }
dual PrntName { | String }
object AltName { :PrntName alt: Number }
```

### constraint-field-obj.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:PrntName> { field: $ref }
object PrntName { | String }
object AltName { :PrntName alt: Number }
```

### constraint-parent-dual-grandparent.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:GrndName> { :$ref }
dual GrndName { | String }
dual PrntName { :GrndName }
object AltName { :PrntName alt: Number }
```

### constraint-parent-dual-parent.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:PrntName> { :$ref }
dual PrntName { | String }
object AltName { :PrntName alt: Number }
```

### constraint-parent-enum.graphql+

```gqlp
object Name { | RefName<parentName> }
object RefName<$type:EnumName> { field: $type }
enum EnumName { :ParentName name }
enum ParentName { parentName }
```

### constraint-parent-obj-parent.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:PrntName> { :$ref }
object PrntName { | String }
object AltName { :PrntName alt: Number }
```

### field-descr.graphql+

```gqlp
object Name { "Test" "Descr" field: String }
```

### field-dual.graphql+

```gqlp
object Name { field: FldName }
dual FldName { field: Number | String }
```

### field-enum-parent.graphql+

```gqlp
object Name { field = EnumName.prnt_name }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### field-enum.graphql+

```gqlp
object Name { field = EnumName.name }
enum EnumName { name }
```

### field-mod-Enum.graphql+

```gqlp
object Name { field: String[EnumName] }
enum EnumName { value }
```

### field-mod-param.graphql+

```gqlp
object Name<$mod:String> { field: FldName[$mod] }
object FldName { field: Number | String }
```

### field-object.graphql+

```gqlp
object Name { field: FldName }
object FldName { field: Number | String }
```

### field-simple.graphql+

```gqlp
object Name { field: Number }
```

### field-type-descr.graphql+

```gqlp
object Name { field: "Test" "Descr" Number }
```

### field-value-descr.graphql+

```gqlp
object Name { field = "Test" "Descr" name }
enum EnumName { name }
```

### field-value.graphql+

```gqlp
object Name { field = name }
enum EnumName { name }
```

### field.graphql+

```gqlp
object Name { field: String }
```

### generic-alt-arg-descr.graphql+

```gqlp
object Name<$type:String> { | RefName<"Test" "Descr"$type> }
object RefName<$ref:String> { | $ref }
```

### generic-alt-arg.graphql+

```gqlp
object Name<$type:String> { | RefName<$type> }
object RefName<$ref:String> { | $ref }
```

### generic-alt-dual.graphql+

```gqlp
object Name { | RefName<AltName> }
object RefName<$ref:_Dual> { | $ref }
dual AltName { alt: Number | String }
```

### generic-alt-mod-param.graphql+

```gqlp
object RefName<$ref:String $mod:String> { | $ref[$mod] }
```

### generic-alt-mod-String.graphql+

```gqlp
object RefName<$ref:String> { | $ref[*] }
```

### generic-alt-param.graphql+

```gqlp
object Name { | RefName<AltName> }
object RefName<$ref:_Object> { | $ref }
object AltName { alt: Number | String }
```

### generic-alt-simple.graphql+

```gqlp
object Name { | RefName<String> }
object RefName<$ref:String> { | $ref }
```

### generic-alt.graphql+

```gqlp
object Name<$type:String> { | $type }
```

### generic-descr.graphql+

```gqlp
object Name<"Test" "Descr" $type:String> { field: $type }
```

### generic-enum.graphql+

```gqlp
object Name { | RefName<EnumName.name> }
object RefName<$type:_Enum> { field: $type }
enum EnumName { name }
```

### generic-field-arg.graphql+

```gqlp
object Name<$type:String> { field: RefName<$type> }
object RefName<$ref:String> { | $ref }
```

### generic-field-dual.graphql+

```gqlp
object Name { field: RefName<AltName> }
object RefName<$ref:_Dual> { | $ref }
dual AltName { alt: Number | String }
```

### generic-field-param.graphql+

```gqlp
object Name { field: RefName<AltName> }
object RefName<$ref:_Object> { | $ref }
object AltName { alt: Number | String }
```

### generic-field.graphql+

```gqlp
object Name<$type:String> { field: $type }
```

### generic-parent-arg.graphql+

```gqlp
object Name<$type:String> { :RefName<$type> }
object RefName<$ref:String> { | $ref }
```

### generic-parent-descr.graphql+

```gqlp
object Name<$type:_Dual> { :"Parent comment"$type }
```

### generic-parent-dual-parent.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:_Dual> { :$ref }
dual AltName { alt: Number | String }
```

### generic-parent-dual.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:_Dual> { | $ref }
dual AltName { alt: Number | String }
```

### generic-parent-enum-child.graphql+

```gqlp
object Name { :FieldName<ParentName> }
object FieldName<$ref:EnumName> { field: $ref }
enum EnumName { :ParentName nameLabel }
enum ParentName { nameParent }
```

### generic-parent-enum-dom.graphql+

```gqlp
object Name { :FieldName<DomName> }
object FieldName<$ref:EnumName> { field: $ref }
enum EnumName { nameLabel nameOther }
domain DomName { enum nameLabel }
```

### generic-parent-enum-parent.graphql+

```gqlp
object Name { :FieldName<EnumName> }
object FieldName<$ref:ParentName> { field: $ref }
enum EnumName { :ParentName nameLabel }
enum ParentName { nameParent }
```

### generic-parent-param-parent.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:_Object> { :$ref }
object AltName { alt: Number | String }
```

### generic-parent-param.graphql+

```gqlp
object Name { :RefName<AltName> }
object RefName<$ref:_Object> { | $ref }
object AltName { alt: Number | String }
```

### generic-parent-simple-enum.graphql+

```gqlp
object Name { :FieldName<EnumName> }
object FieldName<$ref:_Simple> { field: $ref }
enum EnumName { name }
```

### generic-parent-string-dom.graphql+

```gqlp
object Name { :FieldName<DomName> }
object FieldName<$ref:String> { field: $ref }
domain DomName { string /\w+/ }
```

### generic-parent.graphql+

```gqlp
object Name<$type:_Dual> { :$type }
```

### generic-value.graphql+

```gqlp
object Name { | RefName<name> }
object RefName<$type:_Enum> { field: $type }
enum EnumName { name }
```

### input-field-descr-Number.graphql+

```gqlp
input Name { "Test" "Descr" field: Number = 42 }
```

### input-field-Enum.graphql+

```gqlp
input Name { field: EnumName = name }
enum EnumName { name }
```

### input-field-null.graphql+

```gqlp
input Name { field: FldName? = null }
dual FldName { }
```

### input-field-Number-descr.graphql+

```gqlp
input Name { field: "Test" "Descr" Number = 42 }
```

### input-field-Number.graphql+

```gqlp
input Name { field: Number = 42 }
```

### input-field-String.graphql+

```gqlp
input Name { field: String = 'default' }
```

### output-descr-param.graphql+

```gqlp
output Name { "Test" "Descr" field(InName): FldName }
dual FldName { }
input InName { param: Number | String }
```

### output-param-descr.graphql+

```gqlp
output Name { field("Test" "Descr" InName): FldName }
dual FldName { }
input InName { param: Number | String }
```

### output-param-mod-Domain.graphql+

```gqlp
output Name { field(InName[DomName]): DomName }
input InName { param: Number | String }
domain DomName { number 1 ~ 10 }
```

### output-param-mod-param.graphql+

```gqlp
output Name<$mod:String> { field(InName[$mod]): DomName }
input InName { param: Number | String }
domain DomName { number 1 ~ 10 }
```

### output-param-type-descr.graphql+

```gqlp
output Name { field(InName): "Test" "Descr" FldName }
dual FldName { }
input InName { param: Number | String }
```

### output-param.graphql+

```gqlp
output Name { field(InName): FldName }
dual FldName { }
input InName { param: Number | String }
```

### output-parent-generic.graphql+

```gqlp
output Name { | RefName<EnumName.prnt_name> }
output RefName<$type:PrntName> { field: $type }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### output-parent-param.graphql+

```gqlp
output Name { :PrntName field(InName): FldName }
output PrntName { field(PrntNameIn): FldName }
dual FldName { }
input InName { param: Number | String }
input PrntNameIn { parent: Number | String }
```

### parent-alt.graphql+

```gqlp
object Name { :RefName | Number }
object RefName {  parent: Number | String }
```

### parent-descr.graphql+

```gqlp
object Name { : "Test" "Descr" RefName }
object RefName { parent: Number | String }
```

### parent-dual.graphql+

```gqlp
object Name { :RefName }
dual RefName { parent: Number | String }
```

### parent-field.graphql+

```gqlp
object Name { :RefName field: Number }
object RefName { parent: Number | String }
```

### parent-param-diff.graphql+

```gqlp
object Name<$a:String> { :RefName<$a> field: $a }
object RefName<$b:String> { | $b }
```

### parent-param-same.graphql+

```gqlp
object Name<$a:String> { :RefName<$a> field: $a }
object RefName<$a:String> { | $a }
```

### parent.graphql+

```gqlp
object Name { :RefName }
object RefName { parent: Number | String }
```
