# Objects Schema Samples

### Objects\alt-dual.graphql+

```gqlp
object ObjName { | ObjDualName }
dual ObjDualName { alt: Number | String }
```

### Objects\alt-mod-Boolean.graphql+

```gqlp
object ObjName { | ObjNameAlt[^] }
object ObjNameAlt { alt: Number | String }
```

### Objects\alt-mod-param.graphql+

```gqlp
object ObjName<$mod> { | ObjNameAlt[$mod] }
object ObjNameAlt { alt: Number | String }
```

### Objects\alt-simple.graphql+

```gqlp
object ObjName { | String }
```

### Objects\alt.graphql+

```gqlp
object ObjName { | ObjNameAlt }
object ObjNameAlt { alt: Number | String }
```

### Objects\field-dual.graphql+

```gqlp
object ObjName { field: ObjNameFld }
dual ObjNameFld { field: Number | String }
```

### Objects\field-mod-Enum.graphql+

```gqlp
object ObjName { field: *[ObjEnumName] }
enum ObjEnumName { value }
```

### Objects\field-mod-param.graphql+

```gqlp
object ObjName<$mod> { field: ObjNameFld[$mod] }
object ObjNameFld { field: Number | String }
```

### Objects\field-object.graphql+

```gqlp
object ObjName { field: ObjNameFld }
object ObjNameFld { field: Number | String }
```

### Objects\field-simple.graphql+

```gqlp
object ObjName { field: Number }
```

### Objects\field.graphql+

```gqlp
object ObjName { field: * }
```

### Objects\generic-alt-arg.graphql+

```gqlp
object ObjName<$type> { | ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### Objects\generic-alt-dual.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### Objects\generic-alt-param.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### Objects\generic-alt-simple.graphql+

```gqlp
object ObjName { | ObjNameRef<String> }
object ObjNameRef<$ref> { | $ref }
```

### Objects\generic-alt.graphql+

```gqlp
object ObjName<$type> { | $type }
```

### Objects\generic-dual.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### Objects\generic-field-arg.graphql+

```gqlp
object ObjName<$type> { field: ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### Objects\generic-field-dual.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### Objects\generic-field-param.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
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
object ObjName<$type> { :ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### Objects\generic-parent-dual-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
dual ObjNameAlt { alt: Number | String }
```

### Objects\generic-parent-dual.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### Objects\generic-parent-param-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
object ObjNameAlt { alt: Number | String }
```

### Objects\generic-parent-param.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### Objects\generic-parent.graphql+

```gqlp
object ObjName<$type> { :$type }
```

### Objects\input-field-Enum.graphql+

```gqlp
input InFieldEnum { field: InEnumField = value }
enum InEnumField { value }
```

### Objects\input-field-null.graphql+

```gqlp
input InFieldNull { field: InFieldNull? = null }
```

### Objects\input-field-Number.graphql+

```gqlp
input InFieldNum { field: Number = 0 }
```

### Objects\input-field-String.graphql+

```gqlp
input InFieldStr { field: String = '' }
```

### Objects\output-field-enum-parent.graphql+

```gqlp
output OutFieldParent { field = OutEnumParented.outEnumParent }
enum OutEnumParented { :OutEnumParent outParent ed }
enum OutEnumParent { outEnumParent }
```

### Objects\output-field-enum.graphql+

```gqlp
output OutFieldEnum { field = OutEnumField.outEnumField }
enum OutEnumField { outEnumField }
```

### Objects\output-field-value.graphql+

```gqlp
output OutFieldValue { field = outEnumValue }
enum OutEnumValue { outEnumValue }
```

### Objects\output-generic-enum.graphql+

```gqlp
output OutGenEnum { | OutGenEnumRef<OutEnumGen.outEnumGen> }
output OutGenEnumRef<$type> { field: $type }
enum OutEnumGen { outEnumGen }
```

### Objects\output-generic-value.graphql+

```gqlp
output OutGenValue { | OutGenValueRef<outValueGen> }
output OutGenValueRef<$type> { field: $type }
enum OutValueGen { outValueGen }
```

### Objects\output-param-mod-Domain.graphql+

```gqlp
output OutParamDomain { field(OutParamDomainIn[OutDomainParam]): OutDomainParam }
input OutParamDomainIn { param: Number | String }
domain OutDomainParam { number 1 ~ 10 }
```

### Objects\output-param-mod-param.graphql+

```gqlp
output OutParamDomainParam<$mod> { field(OutParamDomainParamIn[$mod]): OutDomainsParam }
input OutParamDomainParamIn { param: Number | String }
domain OutDomainsParam { number 1 ~ 10 }
```

### Objects\output-param.graphql+

```gqlp
output OutParam { field(OutParamIn): OutParam }
input OutParamIn { param: Number | String }
```

### Objects\output-parent-generic.graphql+

```gqlp
output OutGenParent { | OutGenParentRef<OutParentGen.outGenParent> }
output OutGenParentRef<$type> { field: $type }
enum OutParentGen { :OutPrntendedGen outGenPrntended }
enum OutPrntendedGen { outGenParent }
```

### Objects\output-parent-param.graphql+

```gqlp
output OutPrntParam { :OutParamParent field(OutPrntParamIn): OutPrntParam }
output OutParamParent { field(OutParamParentIn): OutPrntParam }
input OutPrntParamIn { param: Number | String }
input OutParamParentIn { parent: Number | String }
```

### Objects\parent-alt.graphql+

```gqlp
object ObjName { :ObjNameRef | Number }
object ObjNameRef {  parent: Number | String }
```

### Objects\parent-dual.graphql+

```gqlp
object ObjName { :ObjNameRef }
dual ObjNameRef { parent: Number | String }
```

### Objects\parent-field.graphql+

```gqlp
object ObjName { :ObjNameRef field: Number }
object ObjNameRef { parent: Number | String }
```

### Objects\parent-param-diff.graphql+

```gqlp
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$b> { | $b }
```

### Objects\parent-param-same.graphql+

```gqlp
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$a> { | $a }
```

### Objects\parent.graphql+

```gqlp
object ObjName { :ObjNameRef }
object ObjNameRef { parent: Number | String }
```
