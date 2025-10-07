# Introspection Specification Samples

### -Global.graphql+

```gqlp
output _AndType {
    : _Named
        type: _Type
    | _Type
    }

output _Categories {
    : _AndType
        category: _Category
    | _Category
    }

output _Category {
    : _Aliased
        resolution: _Resolution
        output: _TypeRef<_TypeKind.Output>
        modifiers: _Modifiers[]
    }

enum _Resolution { Parallel Sequential Single }

output _Directives {
    : _AndType
        directive: _Directive
    | _Directive
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
        value: Value
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_InputParam' not defined`
- `'_Modifiers' not defined`
- `'_Named' not defined`
- `'_Type' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### -Object.graphql+

```gqlp
domain _ObjectKind { enum _TypeKind.Dual _TypeKind.Input _TypeKind.Output }

output _TypeObject<$kind:_ObjectKind $field:_ObjField> {
    : _ChildType<$kind _ObjBase>
        typeParams: _ObjTypeParam[]
        fields: $field[]
        alternates: _ObjAlternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<_ObjAlternate>[]
    }

output _ObjTypeParam {
    : _Named
        constraint: _TypeRef<_TypeKind>
    }

output _ObjBase {
    : _Named
        typeArgs: _ObjTypeArg[]
    | _TypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
        label: _Identifier?
    | _TypeParam
    }

output _TypeParam {
    : _Described
        typeParam: _Identifier
    }

output _ObjAlternate {
      type: _ObjBase
      collections: _Collections[]
    | _ObjAlternateEnum
    }

output _ObjAlternateEnum {
    : _TypeRef<_TypeKind.Enum>
        label: _Identifier
    }
output _ObjectFor<$for:_ForParam> {
    : $for
        object: _Identifier
    }

output _ObjField<$type:_ObjFieldType> {
    : _Aliased
      type: $type
    }

output _ObjFieldType {
    : _ObjBase
        modifiers: _Modifiers[]
    | _ObjFieldEnum
    }

output _ObjFieldEnum {
    : _TypeRef<_TypeKind.Enum>
        label: _Identifier
    }

output _ForParam<$type:_ObjFieldType> {
    | _ObjAlternate
    | _ObjField<$type>
    }

output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualField>
    }

output _DualField {
    : _ObjField<_ObjFieldType>
    }

output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputField>
    }

output _InputField {
    : _ObjField<_InputFieldType>
    }

output _InputFieldType {
    : _ObjFieldType
        default: Value?
    }

output _InputParam {
    : _InputFieldType
    }

output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputField>
    }

output _OutputField {
    : _ObjField<_ObjFieldType>
    }

output _OutputFieldType {
    : _ObjFieldType
        parameters: _InputParam[]
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_ChildType' not defined`
- `'_Collections' not defined`
- `'_Described' not defined`
- `'_Identifier' not defined`
- `'_Modifiers' not defined`
- `'_Named' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeKind' not match '_ObjectKind'`
- `'_TypeRef' not defined`

### -Schema.graphql+

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        types(_TypeFilter?): _Type[_Identifier]
        settings(_Filter?): _Setting[_Identifier]
    }

domain _Identifier { String /[A-Za-z_][A-Za-z0-9_]*/ }

input _Filter {
        names: _NameFilter[]
        matchAliases: Boolean? = true
        aliases: _NameFilter[]
        returnByAlias: Boolean? = false
        returnReferencedTypes: Boolean? = false
    | _NameFilter[]
    }

"_NameFilter is a simple match expression against _Identifier"
"where '.' matches any single character and '*' matches zero or more of any character."
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

```

##### Expected Verify errors

- `'_Categories' not defined`
- `'_Directives' not defined`
- `'_Resolution' not defined`
- `'_Setting' not defined`
- `'_Type' not defined`
- `'_TypeKind' not defined`

### -Simple.graphql+

```gqlp
enum _DomainKind { Boolean Enum Number String }

output _TypeDomain {
    | _BaseDomain<_DomainKind.Boolean _DomainTrueFalse _DomainItemTrueFalse>
    | _BaseDomain<_DomainKind.Enum _DomainLabel _DomainItemLabel>
    | _BaseDomain<_DomainKind.Number _DomainRange _DomainItemRange>
    | _BaseDomain<_DomainKind.String _DomainRegex _DomainItemRegex>
    }

output _DomainRef<$kind:_DomainKind> {
    : _TypeRef<_TypeKind.Domain>
        domainKind: $kind
    }

output _BaseDomain<$domain:_DomainKind $item:_BaseDomainItem $domainItem:_DomainItem> {
    : _ParentType<_TypeKind.Domain $item $domainItem>
        domainKind: $domain
    }

dual _BaseDomainItem {
    : _Described
        exclude: Boolean
    }

output _DomainItem<$item:_BaseDomainItem> {
    : $item
        domain: _Identifier
    }

output _DomainValue<$kind:_DomainKind $value:_BasicValue> {
    : _DomainRef<$kind>
        value: $value
    | $value
    }

output _BasicValue {
    | Boolean
    | _EnumValue
    | Number
    | String
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

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_Aliased' not defined`
- `'_Described' not defined`
- `'_Identifier' not defined`
- `'_ParentType' not defined`
- `'_SimpleKind' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### -Type.graphql+

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

output _BaseType<$kind:_TypeKind> {
    : _Aliased
        typeKind: $kind
    }

output _ChildType<$kind:_TypeKind $parent:_Described> {
    : _BaseType<$kind>
        parent: $parent
    }

output _ParentType<$kind:_TypeKind $item:_Described $allItem:_Described> {
    : _ChildType<$kind _Named>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Domain Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

dual _TypeRef<$kind:_TypeKind> {
    : _Named
        typeKind: $kind
}

dual _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Domain>
    | _TypeRef<_TypeKind.Union>
    }

dual _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

dual _ModifierKeyed<$kind:_ModifierKind> {
    : _Modifier<$kind>
        by: _TypeSimple
        optional: Boolean
    }

dual _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

dual _Modifier<$kind:_ModifierKind> {
        modifierKind: $kind
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_Described' not defined`
- `'_Named' not defined`
- `'_Named' not match '_Described'`
- `'_TypeDomain' not defined`
- `'_TypeDual' not defined`
- `'_TypeEnum' not defined`
- `'_TypeInput' not defined`
- `'_TypeOutput' not defined`
- `'_TypeUnion' not defined`

### Base.graphql+

```gqlp
domain _ObjectKind { enum _TypeKind.Dual _TypeKind.Input _TypeKind.Output }

output _TypeObject<$kind:_ObjectKind $field:_ObjField> {
    : _ChildType<$kind _ObjBase>
        typeParams: _ObjTypeParam[]
        fields: $field[]
        alternates: _ObjAlternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<_ObjAlternate>[]
    }

output _ObjTypeParam {
    : _Named
        constraint: _TypeRef<_TypeKind>
    }

output _ObjBase {
    : _Named
        typeArgs: _ObjTypeArg[]
    | _TypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
        label: _Identifier?
    | _TypeParam
    }

output _TypeParam {
    : _Described
        typeParam: _Identifier
    }

output _ObjAlternate {
      type: _ObjBase
      collections: _Collections[]
    | _ObjAlternateEnum
    }

output _ObjAlternateEnum {
    : _TypeRef<_TypeKind.Enum>
        label: _Identifier
    }
output _ObjectFor<$for:_ForParam> {
    : $for
        object: _Identifier
    }

output _ObjField<$type:_ObjFieldType> {
    : _Aliased
      type: $type
    }

output _ObjFieldType {
    : _ObjBase
        modifiers: _Modifiers[]
    | _ObjFieldEnum
    }

output _ObjFieldEnum {
    : _TypeRef<_TypeKind.Enum>
        label: _Identifier
    }

output _ForParam<$type:_ObjFieldType> {
    | _ObjAlternate
    | _ObjField<$type>
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_ChildType' not defined`
- `'_Collections' not defined`
- `'_Described' not defined`
- `'_Identifier' not defined`
- `'_Modifiers' not defined`
- `'_Named' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### Built-In.graphql+

```gqlp
dual _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

dual _ModifierKeyed<$kind:_ModifierKind> {
    : _Modifier<$kind>
        by: _TypeSimple
        optional: Boolean
    }

dual _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

dual _Modifier<$kind:_ModifierKind> {
        modifierKind: $kind
    }

```

##### Expected Verify errors

- `'_TypeSimple' not defined`

### Category.graphql+

```gqlp
output _Categories {
    : _AndType
        category: _Category
    | _Category
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

- `'_Aliased' not defined`
- `'_AndType' not defined`
- `'_Modifiers' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### Common.graphql+

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

output _BaseType<$kind:_TypeKind> {
    : _Aliased
        typeKind: $kind
    }

output _ChildType<$kind:_TypeKind $parent:_Described> {
    : _BaseType<$kind>
        parent: $parent
    }

output _ParentType<$kind:_TypeKind $item:_Described $allItem:_Described> {
    : _ChildType<$kind _Named>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Domain Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

dual _TypeRef<$kind:_TypeKind> {
    : _Named
        typeKind: $kind
}

dual _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Domain>
    | _TypeRef<_TypeKind.Union>
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_Described' not defined`
- `'_Named' not defined`
- `'_Named' not match '_Described'`
- `'_TypeDomain' not defined`
- `'_TypeDual' not defined`
- `'_TypeEnum' not defined`
- `'_TypeInput' not defined`
- `'_TypeOutput' not defined`
- `'_TypeUnion' not defined`

### Declarations.graphql+

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        types(_TypeFilter?): _Type[_Identifier]
        settings(_Filter?): _Setting[_Identifier]
    }

domain _Identifier { String /[A-Za-z_][A-Za-z0-9_]*/ }

input _Filter {
        names: _NameFilter[]
        matchAliases: Boolean? = true
        aliases: _NameFilter[]
        returnByAlias: Boolean? = false
        returnReferencedTypes: Boolean? = false
    | _NameFilter[]
    }

"_NameFilter is a simple match expression against _Identifier"
"where '.' matches any single character and '*' matches zero or more of any character."
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

- `'_Categories' not defined`
- `'_Directives' not defined`
- `'_Named' not defined`
- `'_Resolution' not defined`
- `'_Setting' not defined`
- `'_Type' not defined`
- `'_TypeKind' not defined`

### Directive.graphql+

```gqlp
output _Directives {
    : _AndType
        directive: _Directive
    | _Directive
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

- `'_Aliased' not defined`
- `'_AndType' not defined`
- `'_InputParam' not defined`

### Domain.graphql+

```gqlp
enum _DomainKind { Boolean Enum Number String }

output _TypeDomain {
    | _BaseDomain<_DomainKind.Boolean _DomainTrueFalse _DomainItemTrueFalse>
    | _BaseDomain<_DomainKind.Enum _DomainLabel _DomainItemLabel>
    | _BaseDomain<_DomainKind.Number _DomainRange _DomainItemRange>
    | _BaseDomain<_DomainKind.String _DomainRegex _DomainItemRegex>
    }

output _DomainRef<$kind:_DomainKind> {
    : _TypeRef<_TypeKind.Domain>
        domainKind: $kind
    }

output _BaseDomain<$domain:_DomainKind $item:_BaseDomainItem $domainItem:_DomainItem> {
    : _ParentType<_TypeKind.Domain $item $domainItem>
        domainKind: $domain
    }

dual _BaseDomainItem {
    : _Described
        exclude: Boolean
    }

output _DomainItem<$item:_BaseDomainItem> {
    : $item
        domain: _Identifier
    }

output _DomainValue<$kind:_DomainKind $value:_BasicValue> {
    : _DomainRef<$kind>
        value: $value
    | $value
    }

output _BasicValue {
    | Boolean
    | _EnumValue
    | Number
    | String
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

- `'_Described' not defined`
- `'_EnumValue' not defined`
- `'_Identifier' not defined`
- `'_ParentType' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### Dual.graphql+

```gqlp
output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualField>
    }

output _DualField {
    : _ObjField<_ObjFieldType>
    }

```

##### Expected Verify errors

- `'_ObjField' not defined`
- `'_ObjFieldType' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeObject' not defined`

### Enum.graphql+

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

- `'_Aliased' not defined`
- `'_Identifier' not defined`
- `'_ParentType' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### Input.graphql+

```gqlp
output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputField>
    }

output _InputField {
    : _ObjField<_InputFieldType>
    }

output _InputFieldType {
    : _ObjFieldType
        default: Value?
    }

output _InputParam {
    : _InputFieldType
    }

```

##### Expected Verify errors

- `'_ObjField' not defined`
- `'_ObjFieldType' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeObject' not defined`

### Names.graphql+

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

output _AndType {
    : _Named
        type: _Type
    | _Type
    }

```

##### Expected Verify errors

- `'_Identifier' not defined`
- `'_Type' not defined`

### Option.graphql+

```gqlp
output _Setting {
    : _Named
        value: Value
    }

```

##### Expected Verify errors

- `'_Named' not defined`

### Output.graphql+

```gqlp
output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputField>
    }

output _OutputField {
    : _ObjField<_ObjFieldType>
    }

output _OutputFieldType {
    : _ObjFieldType
        parameters: _InputParam[]
    }

```

##### Expected Verify errors

- `'_InputParam' not defined`
- `'_ObjField' not defined`
- `'_ObjFieldType' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeObject' not defined`

### Union.graphql+

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

- `'_Identifier' not defined`
- `'_ParentType' not defined`
- `'_SimpleKind' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`
