# Objects Schema Samples

### alt-descr.graphql+

```gqlp
object ObjName { | "Test" "Descr" String }
```

### alt-dual.graphql+

```gqlp
object ObjName { | ObjDualName }
dual ObjDualName { alt: Number | String }
```

### alt-mod-Boolean.graphql+

```gqlp
object ObjName { | AltObjName[^] }
object AltObjName { alt: Number | String }
```

### alt-mod-param.graphql+

```gqlp
object ObjName<$mod> { | AltObjName[$mod] }
object AltObjName { alt: Number | String }
```

### alt-simple.graphql+

```gqlp
object ObjName { | String }
```

### alt.graphql+

```gqlp
object ObjName { | AltObjName }
object AltObjName { alt: Number | String }
```

### constraint-alt-domain.graphql+

```gqlp
object ObjName { | RefObjName<DomName> }
object RefObjName<$ref:String> { | $ref }
domain DomName { String /\w+/ }
```

### constraint-alt-dual.graphql+

```gqlp
object ObjName { | RefObjName<AltObjName> }
object RefObjName<$ref:PrntObjName> { | $ref }
dual PrntObjName { | String }
object AltObjName { :PrntObjName alt: Number }
```

### constraint-alt-obj.graphql+

```gqlp
object ObjName { | RefObjName<AltObjName> }
object RefObjName<$ref:PrntObjName> { | $ref }
object PrntObjName { | String }
object AltObjName { :PrntObjName alt: Number }
```

### constraint-alt.graphql+

```gqlp
object ObjName<$type:Number> { | $type }
```

### constraint-field-domain.graphql+

```gqlp
object ObjName { :RefObjName<DomName> }
object RefObjName<$ref:String> { field: $ref }
domain DomName { String /\w+/ }
```

### constraint-field-dual.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref:PrntObjName> { field: $ref }
dual PrntObjName { | String }
object AltObjName { :PrntObjName alt: Number }
```

### constraint-field-obj.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref:PrntObjName> { field: $ref }
object PrntObjName { | String }
object AltObjName { :PrntObjName alt: Number }
```

### constraint-parent-dual-parent.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref:PrntObjName> { :$ref }
dual PrntObjName { | String }
object AltObjName { :PrntObjName alt: Number }
```

### constraint-parent-obj-parent.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref:PrntObjName> { :$ref }
object PrntObjName { | String }
object AltObjName { :PrntObjName alt: Number }
```

### field-descr.graphql+

```gqlp
object ObjName { "Test" "Descr" field: * }
```

### field-dual.graphql+

```gqlp
object ObjName { field: FldObjName }
dual FldObjName { field: Number | String }
```

### field-mod-Enum.graphql+

```gqlp
object ObjName { field: *[EnumObjName] }
enum EnumObjName { value }
```

### field-mod-param.graphql+

```gqlp
object ObjName<$mod> { field: FldObjName[$mod] }
object FldObjName { field: Number | String }
```

### field-object.graphql+

```gqlp
object ObjName { field: FldObjName }
object FldObjName { field: Number | String }
```

### field-simple.graphql+

```gqlp
object ObjName { field: Number }
```

### field-type-descr.graphql+

```gqlp
object ObjName { field: "Test" "Descr" Number }
```

### field.graphql+

```gqlp
object ObjName { field: * }
```

### generic-alt-arg-descr.graphql+

```gqlp
object ObjName<$type> { | RefObjName<"Test" "Descr"$type> }
object RefObjName<$ref> { | $ref }
```

### generic-alt-arg.graphql+

```gqlp
object ObjName<$type> { | RefObjName<$type> }
object RefObjName<$ref> { | $ref }
```

### generic-alt-dual.graphql+

```gqlp
object ObjName { | RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
dual AltObjName { alt: Number | String }
```

### generic-alt-param.graphql+

```gqlp
object ObjName { | RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
object AltObjName { alt: Number | String }
```

### generic-alt-simple.graphql+

```gqlp
object ObjName { | RefObjName<String> }
object RefObjName<$ref> { | $ref }
```

### generic-alt.graphql+

```gqlp
object ObjName<$type> { | $type }
```

### generic-descr.graphql+

```gqlp
object ObjName<"Test" "Descr" $type> { field: $type }
```

### generic-field-arg.graphql+

```gqlp
object ObjName<$type> { field: RefObjName<$type> }
object RefObjName<$ref> { | $ref }
```

### generic-field-dual.graphql+

```gqlp
object ObjName { field: RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
dual AltObjName { alt: Number | String }
```

### generic-field-param.graphql+

```gqlp
object ObjName { field: RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
object AltObjName { alt: Number | String }
```

### generic-field.graphql+

```gqlp
object ObjName<$type> { field: $type }
```

### generic-parent-arg.graphql+

```gqlp
object ObjName<$type> { :RefObjName<$type> }
object RefObjName<$ref> { | $ref }
```

### generic-parent-dual-parent.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { :$ref }
dual AltObjName { alt: Number | String }
```

### generic-parent-dual.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
dual AltObjName { alt: Number | String }
```

### generic-parent-param-parent.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { :$ref }
object AltObjName { alt: Number | String }
```

### generic-parent-param.graphql+

```gqlp
object ObjName { :RefObjName<AltObjName> }
object RefObjName<$ref> { | $ref }
object AltObjName { alt: Number | String }
```

### generic-parent.graphql+

```gqlp
object ObjName<$type> { :$type }
```

### input-field-descr-Number.graphql+

```gqlp
input Name { "Test" "Descr" field: Number = 0 }
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
input Name { field: "Test" "Descr" Number = 0 }
```

### input-field-Number.graphql+

```gqlp
input Name { field: Number = 0 }
```

### input-field-String.graphql+

```gqlp
input Name { field: String = '' }
```

### output-constraint-enum-parent.graphql+

```gqlp
output Name { | RefName<name> }
output RefName<$type:ParentName> { field: $type }
enum EnumName { :ParentName name }
enum ParentName { parentName }
```

### output-constraint-enum.graphql+

```gqlp
output Name { | RefName<name> }
output RefName<$type:EnumName> { field: $type }
enum EnumName { name }
```

### output-constraint-parent-enum.graphql+

```gqlp
output Name { | RefName<parentName> }
output RefName<$type:EnumName> { field: $type }
enum EnumName { :ParentName name }
enum ParentName { parentName }
```

### output-descr-param.graphql+

```gqlp
output Name { "Test" "Descr" field(InName): FldName }
dual FldName { }
input InName { param: Number | String }
```

### output-field-enum-parent.graphql+

```gqlp
output Name { field = EnumName.prnt_name }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### output-field-enum.graphql+

```gqlp
output Name { field = EnumName.name }
enum EnumName { name }
```

### output-field-value-descr.graphql+

```gqlp
output Name { field = "Test" "Descr" name }
enum EnumName { name }
```

### output-field-value.graphql+

```gqlp
output Name { field = name }
enum EnumName { name }
```

### output-generic-enum.graphql+

```gqlp
output Name { | RefName<EnumName.name> }
output RefName<$type> { field: $type }
enum EnumName { name }
```

### output-generic-value.graphql+

```gqlp
output Name { | RefName<name> }
output RefName<$type> { field: $type }
enum EnumName { name }
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
output Name<$mod> { field(InName[$mod]): DomName }
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
output RefName<$type> { field: $type }
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
object ObjName { :RefObjName | Number }
object RefObjName {  parent: Number | String }
```

### parent-descr.graphql+

```gqlp
object ObjName { : "Test" "Descr" RefObjName }
object RefObjName { parent: Number | String }
```

### parent-dual.graphql+

```gqlp
object ObjName { :RefObjName }
dual RefObjName { parent: Number | String }
```

### parent-field.graphql+

```gqlp
object ObjName { :RefObjName field: Number }
object RefObjName { parent: Number | String }
```

### parent-param-diff.graphql+

```gqlp
object ObjName<$a> { :RefObjName<$a> field: $a }
object RefObjName<$b> { | $b }
```

### parent-param-same.graphql+

```gqlp
object ObjName<$a> { :RefObjName<$a> field: $a }
object RefObjName<$a> { | $a }
```

### parent.graphql+

```gqlp
object ObjName { :RefObjName }
object RefObjName { parent: Number | String }
```
