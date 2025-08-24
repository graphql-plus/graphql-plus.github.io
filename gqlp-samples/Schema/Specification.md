# Specification Schema Samples

### Intro\_!Complete.graphql+

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        operations(_Filter?): _Operations[_Identifier]
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


output _Operations {
        operation: _Operation
        type: _Type
    | _Operation
    | _Type
}

output _Operation {
    : _Aliased
        category: _Identifier
        variables: _OpVariable?
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
}

output _OpVariable {
        name: _Identifier
        type: _InputBase
        modifiers: _Modifiers[]
        default: String? # Todo: _OpDefault
        directives: _OpDirective[]
}

dual _OpDirective {
        name: _Identifier
        argument: String? # Todo: _OpArgument
}

output _OpFragment {
        name: _Identifier
        type: _OutputBase
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpResult {
        domain: _TypeRef<_SimpleKind>?
        argument: String? # Todo: _OpArgument
        body: _OpObject[]
}

output _OpObject {
    |   _OpField
    |   _OpSpread
    |   _OpInline
}

output _OpField {
        alias: String?
        field: String
        argument: String? # Todo: _OpArgument
        modifiers: _Modifiers
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpInline {
        type: String?
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpSpread {
        fragment: String
        directives: _OpDirective[]
}

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

output _TypeRef<$kind:_TypeKind> {
    : _Named
        typeKind: $kind
}

output _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Domain>
    | _TypeRef<_TypeKind.Union>
    }

output _Constant {
    | _SimpleValue
    | _ConstantList
    | _ConstantMap
    }

output _SimpleValue {
    | _DomainValue<_DomainKind.Boolean Boolean>
    | _DomainValue<_DomainKind.Enum _EnumValue>
    | _DomainValue<_DomainKind.Number Number>
    | _DomainValue<_DomainKind.String String>
    }

output _ConstantList {
    | _Constant[]
    }

output _ConstantMap {
    | _Constant[_Key]
    }

output _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

output _ModifierKeyed<$kind:_ModifierKind> {
    : _Modifier<$kind>
        by: _TypeSimple
        optional: Boolean
    }

output _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

output _Modifier<$kind:_ModifierKind> {
        modifierKind: $kind
    }

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

domain _ObjectKind { enum _TypeKind.Dual _TypeKind.Input _TypeKind.Output }

output _TypeObject<$kind:_ObjectKind $parent:_ObjBase
            $typeParam:_ObjTypeParam $field:_Field $alternate:_Alternate> {
    : _ChildType<$kind $parent>
        typeParams: $typeParam[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

output _ObjTypeParam<$kind:_ObjectKind> {
    : _Named
        constraint: _ObjConstraint<$kind>
    }

output _ObjConstraint<$kind:_ObjectKind> {
    : _TypeRef<$kind>
    }

output _ObjBase<$arg:_ObjTypeArg> {
    : _Named
        typeArgs: $arg[]
    | _TypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
    | _TypeParam
    }

output _TypeParam {
    : _Named
        typeParam: _Identifier
    }

output _Alternate<$base:_ObjBase> {
      type: $base
      collections: _Collections[]
    }

output _ObjectFor<$for:_ForParam> {
    : $for
        object: _Identifier
    }

output _Field<$base:_ObjBase> {
    : _Aliased
      type: $base
      modifiers: _Modifiers[]
    }

output _ForParam<$base:_ObjBase> {
    | _Alternate<$base>
    | _Field<$base>
    }

output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualBase _DualTypeParam _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase<_DualTypeArg>
    }

output _DualTypeParam {
    : _ObjTypeParam<_TypeKind.Dual>
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualBase>
    }

output _DualTypeArg {
    : _ObjTypeArg
    }

output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputBase _InputTypeParam _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase<_InputTypeArg>
    | _DualBase
    }

output _InputTypeParam {
    : _ObjTypeParam<_TypeKind.Input>
    | _TypeRef<_TypeKind.Dual>
    }

output _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

output _InputAlternate {
    : _Alternate<_InputBase>
    }

output _InputTypeArg {
    : _ObjTypeArg
    }

output _InputParam {
    : _InputBase
        modifiers: _Modifiers[]
        default: _Constant?
    }

output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputBase _OutputTypeParam _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase<_OutputTypeArg>
    | _DualBase
    }

output _OutputTypeParam {
    : _ObjTypeParam<_TypeKind.Output>
    | _TypeRef<_TypeKind.Dual>
    | _TypeRef<_TypeKind.Enum>
    }

output _OutputField {
    : _Field<_OutputBase>
        parameters: _InputParam[]
    | _OutputEnum
    }

output _OutputAlternate {
    : _Alternate<_OutputBase>
    }

output _OutputTypeArg {
    : _ObjTypeArg
        label: _Identifier?
    }

output _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: _Identifier
        label: _Identifier
    }

```

### Intro\_+Global.graphql+

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


output _Operations {
        operation: _Operation
        type: _Type
    | _Operation
    | _Type
}

output _Operation {
    : _Aliased
        category: _Identifier
        variables: _OpVariable?
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
}

output _OpVariable {
        name: _Identifier
        type: _InputBase
        modifiers: _Modifiers[]
        default: String? # Todo: _OpDefault
        directives: _OpDirective[]
}

dual _OpDirective {
        name: _Identifier
        argument: String? # Todo: _OpArgument
}

output _OpFragment {
        name: _Identifier
        type: _OutputBase
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpResult {
        domain: _TypeRef<_SimpleKind>?
        argument: String? # Todo: _OpArgument
        body: _OpObject[]
}

output _OpObject {
    |   _OpField
    |   _OpSpread
    |   _OpInline
}

output _OpField {
        alias: String?
        field: String
        argument: String? # Todo: _OpArgument
        modifiers: _Modifiers
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpInline {
        type: String?
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpSpread {
        fragment: String
        directives: _OpDirective[]
}

output _Setting {
    : _Named
        value: _Constant
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_Constant' not defined`
- `'_Identifier' not defined`
- `'_InputBase' not defined`
- `'_InputParam' not defined`
- `'_Modifiers' not defined`
- `'_Named' not defined`
- `'_OutputBase' not defined`
- `'_SimpleKind' not defined`
- `'_Type' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### Intro\_+Object.graphql+

```gqlp
domain _ObjectKind { enum _TypeKind.Dual _TypeKind.Input _TypeKind.Output }

output _TypeObject<$kind:_ObjectKind $parent:_ObjBase
            $typeParam:_ObjTypeParam $field:_Field $alternate:_Alternate> {
    : _ChildType<$kind $parent>
        typeParams: $typeParam[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

output _ObjTypeParam<$kind:_ObjectKind> {
    : _Named
        constraint: _ObjConstraint<$kind>
    }

output _ObjConstraint<$kind:_ObjectKind> {
    : _TypeRef<$kind>
    }

output _ObjBase<$arg:_ObjTypeArg> {
    : _Named
        typeArgs: $arg[]
    | _TypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
    | _TypeParam
    }

output _TypeParam {
    : _Named
        typeParam: _Identifier
    }

output _Alternate<$base:_ObjBase> {
      type: $base
      collections: _Collections[]
    }

output _ObjectFor<$for:_ForParam> {
    : $for
        object: _Identifier
    }

output _Field<$base:_ObjBase> {
    : _Aliased
      type: $base
      modifiers: _Modifiers[]
    }

output _ForParam<$base:_ObjBase> {
    | _Alternate<$base>
    | _Field<$base>
    }

output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualBase _DualTypeParam _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase<_DualTypeArg>
    }

output _DualTypeParam {
    : _ObjTypeParam<_TypeKind.Dual>
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualBase>
    }

output _DualTypeArg {
    : _ObjTypeArg
    }

output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputBase _InputTypeParam _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase<_InputTypeArg>
    | _DualBase
    }

output _InputTypeParam {
    : _ObjTypeParam<_TypeKind.Input>
    | _TypeRef<_TypeKind.Dual>
    }

output _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

output _InputAlternate {
    : _Alternate<_InputBase>
    }

output _InputTypeArg {
    : _ObjTypeArg
    }

output _InputParam {
    : _InputBase
        modifiers: _Modifiers[]
        default: _Constant?
    }

output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputBase _OutputTypeParam _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase<_OutputTypeArg>
    | _DualBase
    }

output _OutputTypeParam {
    : _ObjTypeParam<_TypeKind.Output>
    | _TypeRef<_TypeKind.Dual>
    | _TypeRef<_TypeKind.Enum>
    }

output _OutputField {
    : _Field<_OutputBase>
        parameters: _InputParam[]
    | _OutputEnum
    }

output _OutputAlternate {
    : _Alternate<_OutputBase>
    }

output _OutputTypeArg {
    : _ObjTypeArg
        label: _Identifier?
    }

output _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: _Identifier
        label: _Identifier
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_ChildType' not defined`
- `'_Collections' not defined`
- `'_Constant' not defined`
- `'_Identifier' not defined`
- `'_Modifiers' not defined`
- `'_Named' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeKind' not match '_ObjectKind'`
- `'_TypeRef' not defined`

### Intro\_+Schema.graphql+

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        operations(_Filter?): _Operations[_Identifier]
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
- `'_Operations' not defined`
- `'_Resolution' not defined`
- `'_Setting' not defined`
- `'_Type' not defined`
- `'_TypeKind' not defined`

### Intro\_+Simple.graphql+

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

### Intro\_+Type.graphql+

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

output _TypeRef<$kind:_TypeKind> {
    : _Named
        typeKind: $kind
}

output _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Domain>
    | _TypeRef<_TypeKind.Union>
    }

output _Constant {
    | _SimpleValue
    | _ConstantList
    | _ConstantMap
    }

output _SimpleValue {
    | _DomainValue<_DomainKind.Boolean Boolean>
    | _DomainValue<_DomainKind.Enum _EnumValue>
    | _DomainValue<_DomainKind.Number Number>
    | _DomainValue<_DomainKind.String String>
    }

output _ConstantList {
    | _Constant[]
    }

output _ConstantMap {
    | _Constant[_Key]
    }

output _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

output _ModifierKeyed<$kind:_ModifierKind> {
    : _Modifier<$kind>
        by: _TypeSimple
        optional: Boolean
    }

output _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

output _Modifier<$kind:_ModifierKind> {
        modifierKind: $kind
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_Described' not defined`
- `'_DomainKind' not an Enum type`
- `'_DomainKind' not defined`
- `'_DomainValue' not defined`
- `'_EnumValue' not defined`
- `'_Named' not defined`
- `'_Named' not match '_Described'`
- `'_TypeDomain' not defined`
- `'_TypeDual' not defined`
- `'_TypeEnum' not defined`
- `'_TypeInput' not defined`
- `'_TypeOutput' not defined`
- `'_TypeUnion' not defined`

### Intro_Base.graphql+

```gqlp
domain _ObjectKind { enum _TypeKind.Dual _TypeKind.Input _TypeKind.Output }

output _TypeObject<$kind:_ObjectKind $parent:_ObjBase
            $typeParam:_ObjTypeParam $field:_Field $alternate:_Alternate> {
    : _ChildType<$kind $parent>
        typeParams: $typeParam[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

output _ObjTypeParam<$kind:_ObjectKind> {
    : _Named
        constraint: _ObjConstraint<$kind>
    }

output _ObjConstraint<$kind:_ObjectKind> {
    : _TypeRef<$kind>
    }

output _ObjBase<$arg:_ObjTypeArg> {
    : _Named
        typeArgs: $arg[]
    | _TypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
    | _TypeParam
    }

output _TypeParam {
    : _Named
        typeParam: _Identifier
    }

output _Alternate<$base:_ObjBase> {
      type: $base
      collections: _Collections[]
    }

output _ObjectFor<$for:_ForParam> {
    : $for
        object: _Identifier
    }

output _Field<$base:_ObjBase> {
    : _Aliased
      type: $base
      modifiers: _Modifiers[]
    }

output _ForParam<$base:_ObjBase> {
    | _Alternate<$base>
    | _Field<$base>
    }

```

##### Expected Verify errors

- `'_Aliased' not defined`
- `'_ChildType' not defined`
- `'_Collections' not defined`
- `'_Identifier' not defined`
- `'_Modifiers' not defined`
- `'_Named' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeRef' not defined`

### Intro_Built-In.graphql+

```gqlp
output _Constant {
    | _SimpleValue
    | _ConstantList
    | _ConstantMap
    }

output _SimpleValue {
    | _DomainValue<_DomainKind.Boolean Boolean>
    | _DomainValue<_DomainKind.Enum _EnumValue>
    | _DomainValue<_DomainKind.Number Number>
    | _DomainValue<_DomainKind.String String>
    }

output _ConstantList {
    | _Constant[]
    }

output _ConstantMap {
    | _Constant[_Key]
    }

output _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

output _ModifierKeyed<$kind:_ModifierKind> {
    : _Modifier<$kind>
        by: _TypeSimple
        optional: Boolean
    }

output _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

output _Modifier<$kind:_ModifierKind> {
        modifierKind: $kind
    }

```

##### Expected Verify errors

- `'_DomainKind' not an Enum type`
- `'_DomainKind' not defined`
- `'_DomainValue' not defined`
- `'_EnumValue' not defined`
- `'_TypeSimple' not defined`

### Intro_Category.graphql+

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

### Intro_Common.graphql+

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

output _TypeRef<$kind:_TypeKind> {
    : _Named
        typeKind: $kind
}

output _TypeSimple {
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

### Intro_Declarations.graphql+

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        operations(_Filter?): _Operations[_Identifier]
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
- `'_Operations' not defined`
- `'_Resolution' not defined`
- `'_Setting' not defined`
- `'_Type' not defined`
- `'_TypeKind' not defined`

### Intro_Directive.graphql+

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

### Intro_Domain.graphql+

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

### Intro_Dual.graphql+

```gqlp
output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualBase _DualTypeParam _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase<_DualTypeArg>
    }

output _DualTypeParam {
    : _ObjTypeParam<_TypeKind.Dual>
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualBase>
    }

output _DualTypeArg {
    : _ObjTypeArg
    }

```

##### Expected Verify errors

- `'_Alternate' not defined`
- `'_Field' not defined`
- `'_ObjBase' not defined`
- `'_ObjTypeArg' not defined`
- `'_ObjTypeParam' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeObject' not defined`

### Intro_Enum.graphql+

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

### Intro_Input.graphql+

```gqlp
output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputBase _InputTypeParam _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase<_InputTypeArg>
    | _DualBase
    }

output _InputTypeParam {
    : _ObjTypeParam<_TypeKind.Input>
    | _TypeRef<_TypeKind.Dual>
    }

output _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

output _InputAlternate {
    : _Alternate<_InputBase>
    }

output _InputTypeArg {
    : _ObjTypeArg
    }

output _InputParam {
    : _InputBase
        modifiers: _Modifiers[]
        default: _Constant?
    }

```

##### Expected Verify errors

- `'_Alternate' not defined`
- `'_Constant' not defined`
- `'_DualBase' not defined`
- `'_Field' not defined`
- `'_Modifiers' not defined`
- `'_ObjBase' not defined`
- `'_ObjTypeArg' not defined`
- `'_ObjTypeParam' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeObject' not defined`
- `'_TypeRef' not defined`

### Intro_Names.graphql+

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

### Intro_Operation.graphql+

```gqlp
output _Operations {
        operation: _Operation
        type: _Type
    | _Operation
    | _Type
}

output _Operation {
    : _Aliased
        category: _Identifier
        variables: _OpVariable?
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
}

output _OpVariable {
        name: _Identifier
        type: _InputBase
        modifiers: _Modifiers[]
        default: String? # Todo: _OpDefault
        directives: _OpDirective[]
}

dual _OpDirective {
        name: _Identifier
        argument: String? # Todo: _OpArgument
}

output _OpFragment {
        name: _Identifier
        type: _OutputBase
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpResult {
        domain: _TypeRef<_SimpleKind>?
        argument: String? # Todo: _OpArgument
        body: _OpObject[]
}

output _OpObject {
    |   _OpField
    |   _OpSpread
    |   _OpInline
}

output _OpField {
        alias: String?
        field: String
        argument: String? # Todo: _OpArgument
        modifiers: _Modifiers
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpInline {
        type: String?
        directives: _OpDirective[]
        body: _OpObject[]
}

output _OpSpread {
        fragment: String
        directives: _OpDirective[]
}

```

##### Expected Verify errors

- `Invalid Dual Field. '_Identifier' not defined`
- `Invalid Output Alternate. '_Type' not defined`
- `Invalid Output Field. '_Identifier' not defined`
- `Invalid Output Field. '_InputBase' not defined`
- `Invalid Output Field. '_Modifiers' not defined`
- `Invalid Output Field. '_OutputBase' not defined`
- `Invalid Output Field. '_SimpleKind' not defined`
- `Invalid Output Field. '_Type' not defined`
- `Invalid Output Field. '_TypeRef' not defined`
- `Invalid Output Parent. '_Aliased' not defined`

### Intro_Option.graphql+

```gqlp
output _Setting {
    : _Named
        value: _Constant
    }

```

##### Expected Verify errors

- `'_Named' not defined`
- `'_Constant' not defined`

### Intro_Output.graphql+

```gqlp
output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputBase _OutputTypeParam _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase<_OutputTypeArg>
    | _DualBase
    }

output _OutputTypeParam {
    : _ObjTypeParam<_TypeKind.Output>
    | _TypeRef<_TypeKind.Dual>
    | _TypeRef<_TypeKind.Enum>
    }

output _OutputField {
    : _Field<_OutputBase>
        parameters: _InputParam[]
    | _OutputEnum
    }

output _OutputAlternate {
    : _Alternate<_OutputBase>
    }

output _OutputTypeArg {
    : _ObjTypeArg
        label: _Identifier?
    }

output _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: _Identifier
        label: _Identifier
    }

```

##### Expected Verify errors

- `'_Alternate' not defined`
- `'_DualBase' not defined`
- `'_Field' not defined`
- `'_Identifier' not defined`
- `'_InputParam' not defined`
- `'_ObjBase' not defined`
- `'_ObjTypeArg' not defined`
- `'_ObjTypeParam' not defined`
- `'_TypeKind' not an Enum type`
- `'_TypeKind' not defined`
- `'_TypeObject' not defined`
- `'_TypeRef' not defined`

### Intro_Union.graphql+

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
