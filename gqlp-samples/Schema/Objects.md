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
object ObjName { | ObjNameAlt[^] }
object ObjNameAlt { alt: Number | String }
```

### alt-mod-param.graphql+

```gqlp
object ObjName<$mod> { | ObjNameAlt[$mod] }
object ObjNameAlt { alt: Number | String }
```

### alt-simple.graphql+

```gqlp
object ObjName { | String }
```

### alt.graphql+

```gqlp
object ObjName { | ObjNameAlt }
object ObjNameAlt { alt: Number | String }
```

### constraint-alt-domain.graphql+

```gqlp
object ObjName { | ObjNameRef<DomName> }
object ObjNameRef<$ref:String> { | $ref }
domain DomName { String /\w+/ }
```

### constraint-alt-dual.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref:ObjNameParent> { | $ref }
dual ObjNameParent { | String }
object ObjNameAlt { :ObjNameParent alt: Number }
```

### constraint-alt-obj.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref:ObjNameParent> { | $ref }
object ObjNameParent { | String }
object ObjNameAlt { :ObjNameParent alt: Number }
```

### constraint-alt.graphql+

```gqlp
object ObjName<$type:Number> { | $type }
```

### constraint-field-domain.graphql+

```gqlp
object ObjName { :ObjNameRef<DomName> }
object ObjNameRef<$ref:String> { field: $ref }
domain DomName { String /\w+/ }
```

### constraint-field-dual.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref:ObjNameParent> { field: $ref }
dual ObjNameParent { | String }
object ObjNameAlt { :ObjNameParent alt: Number }
```

### constraint-field-obj.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref:ObjNameParent> { field: $ref }
object ObjNameParent { | String }
object ObjNameAlt { :ObjNameParent alt: Number }
```

### constraint-parent-dual-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref:ObjNameParent> { :$ref }
dual ObjNameParent { | String }
object ObjNameAlt { :ObjNameParent alt: Number }
```

### constraint-parent-obj-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref:ObjNameParent> { :$ref }
object ObjNameParent { | String }
object ObjNameAlt { :ObjNameParent alt: Number }
```

### field-descr.graphql+

```gqlp
object ObjName { "Test" "Descr" field: * }
```

### field-dual.graphql+

```gqlp
object ObjName { field: ObjNameFld }
dual ObjNameFld { field: Number | String }
```

### field-mod-Enum.graphql+

```gqlp
object ObjName { field: *[ObjEnumName] }
enum ObjEnumName { value }
```

### field-mod-param.graphql+

```gqlp
object ObjName<$mod> { field: ObjNameFld[$mod] }
object ObjNameFld { field: Number | String }
```

### field-object.graphql+

```gqlp
object ObjName { field: ObjNameFld }
object ObjNameFld { field: Number | String }
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
object ObjName<$type> { | ObjNameRef<"Test" "Descr"$type> }
object ObjNameRef<$ref> { | $ref }
```

### generic-alt-arg.graphql+

```gqlp
object ObjName<$type> { | ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### generic-alt-dual.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### generic-alt-param.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### generic-alt-simple.graphql+

```gqlp
object ObjName { | ObjNameRef<String> }
object ObjNameRef<$ref> { | $ref }
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
object ObjName<$type> { field: ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### generic-field-dual.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### generic-field-param.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### generic-field.graphql+

```gqlp
object ObjName<$type> { field: $type }
```

### generic-parent-arg.graphql+

```gqlp
object ObjName<$type> { :ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### generic-parent-dual-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
dual ObjNameAlt { alt: Number | String }
```

### generic-parent-dual.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### generic-parent-param-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
object ObjNameAlt { alt: Number | String }
```

### generic-parent-param.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### generic-parent.graphql+

```gqlp
object ObjName<$type> { :$type }
```

### input-field-descr-Number.graphql+

```gqlp
input InFieldNum { "Test" "Descr" field: Number = 0 }
```

### input-field-Enum.graphql+

```gqlp
input InFieldEnum { field: InEnumField = value }
enum InEnumField { value }
```

### input-field-null.graphql+

```gqlp
input InFieldNull { field: InFieldNull? = null }
```

### input-field-Number-descr.graphql+

```gqlp
input InFieldNum { field: "Test" "Descr" Number = 0 }
```

### input-field-Number.graphql+

```gqlp
input InFieldNum { field: Number = 0 }
```

### input-field-String.graphql+

```gqlp
input InFieldStr { field: String = '' }
```

### output-constraint-enum.graphql+

```gqlp
output OutGenEnum { | OutGenEnumRef<outEnumGen> }
output OutGenEnumRef<$type:OutEnumGen> { field: $type }
enum OutEnumGen { outEnumGen }
```

### output-descr-param.graphql+

```gqlp
output OutParam { "Test" "Descr" field(OutParamIn): OutParam }
input OutParamIn { param: Number | String }
```

### output-field-enum-parent.graphql+

```gqlp
output OutFieldParent { field = OutEnumParented.outEnumParent }
enum OutEnumParented { :OutEnumParent outParent ed }
enum OutEnumParent { outEnumParent }
```

### output-field-enum.graphql+

```gqlp
output OutFieldEnum { field = OutEnumField.outEnumField }
enum OutEnumField { outEnumField }
```

### output-field-value-descr.graphql+

```gqlp
output OutFieldValueDescr { field = "Test" "Descr" outEnumValueDescr }
enum OutEnumValueDescr { outEnumValueDescr }
```

### output-field-value.graphql+

```gqlp
output OutFieldValue { field = outEnumValue }
enum OutEnumValue { outEnumValue }
```

### output-generic-enum.graphql+

```gqlp
output OutGenEnum { | OutGenEnumRef<OutEnumGen.outEnumGen> }
output OutGenEnumRef<$type> { field: $type }
enum OutEnumGen { outEnumGen }
```

### output-generic-value.graphql+

```gqlp
output OutGenValue { | OutGenValueRef<outValueGen> }
output OutGenValueRef<$type> { field: $type }
enum OutValueGen { outValueGen }
```

### output-param-descr.graphql+

```gqlp
output OutParam { field("Test" "Descr" OutParamIn): OutParam }
input OutParamIn { param: Number | String }
```

### output-param-mod-Domain.graphql+

```gqlp
output OutParamDomain { field(OutParamDomainIn[OutDomainParam]): OutDomainParam }
input OutParamDomainIn { param: Number | String }
domain OutDomainParam { number 1 ~ 10 }
```

### output-param-mod-param.graphql+

```gqlp
output OutParamDomainParam<$mod> { field(OutParamDomainParamIn[$mod]): OutDomainsParam }
input OutParamDomainParamIn { param: Number | String }
domain OutDomainsParam { number 1 ~ 10 }
```

### output-param-type-descr.graphql+

```gqlp
output OutParam { field(OutParamIn): "Test" "Descr" OutParam }
input OutParamIn { param: Number | String }
```

### output-param.graphql+

```gqlp
output OutParam { field(OutParamIn): OutParam }
input OutParamIn { param: Number | String }
```

### output-parent-generic.graphql+

```gqlp
output OutGenParent { | OutGenParentRef<OutParentGen.outGenParent> }
output OutGenParentRef<$type> { field: $type }
enum OutParentGen { :OutPrntendedGen outGenPrntended }
enum OutPrntendedGen { outGenParent }
```

### output-parent-param.graphql+

```gqlp
output OutPrntParam { :OutParamParent field(OutPrntParamIn): OutPrntParam }
output OutParamParent { field(OutParamParentIn): OutPrntParam }
input OutPrntParamIn { param: Number | String }
input OutParamParentIn { parent: Number | String }
```

### parent-alt.graphql+

```gqlp
object ObjName { :ObjNameRef | Number }
object ObjNameRef {  parent: Number | String }
```

### parent-descr.graphql+

```gqlp
object ObjName { : "Test" "Descr" ObjNameRef }
object ObjNameRef { parent: Number | String }
```

### parent-dual.graphql+

```gqlp
object ObjName { :ObjNameRef }
dual ObjNameRef { parent: Number | String }
```

### parent-field.graphql+

```gqlp
object ObjName { :ObjNameRef field: Number }
object ObjNameRef { parent: Number | String }
```

### parent-param-diff.graphql+

```gqlp
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$b> { | $b }
```

### parent-param-same.graphql+

```gqlp
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$a> { | $a }
```

### parent.graphql+

```gqlp
object ObjName { :ObjNameRef }
object ObjNameRef { parent: Number | String }
```
