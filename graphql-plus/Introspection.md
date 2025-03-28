# Schema Introspection

The `_Schema` output type is automatically defined as followed and can be used to allow introspection either through a Category or an Output field.

## Schema

### Declarations

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

### Names and Aliases

```gqlp
dual _Aliased {
    : _Described
        aliases: _Identifier[]
    }

dual _Described {
    : _Named
        description: String[]
    }

dual _Named {
        name: _Identifier
    }
```

## Global declarations

### Category declaration

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

### Directive declaration

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

### Option declaration

```gqlp
output _Setting {
    : _Described
        value: _Constant
}
```

## Type declarations

### Common

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
    : _ChildType<$kind _Described>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Domain Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

output _TypeRef<$kind> {
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

### Built-In types

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

## Simple types

### Domain type

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
        description: String[]
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
```

#### Boolean domain

```gqlp
dual _DomainTrueFalse {
    : _BaseDomainItem
        value: Boolean
    }

output _DomainItemTrueFalse {
    : _DomainItem<_DomainTrueFalse>
    }
```

#### Enum domain

```gqlp
output _DomainLabel {
    : _BaseDomainItem
        label: _EnumValue
    }

output _DomainItemLabel {
    : _DomainItem<_DomainLabel>
    }
```

#### Number domain

```gqlp
dual _DomainRange {
    : _BaseDomainItem
        lower: Number?
        upper: Number?
    }

output _DomainItemRange {
    : _DomainItem<_DomainRange>
    }
```

#### String domain

```gqlp
dual _DomainRegex {
    : _BaseDomainItem
        pattern: String
    }

output _DomainItemRegex {
    : _DomainItem<_DomainRegex>
    }
```

### Enum type

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

### Union type

```gqlp
output _TypeUnion {
    : _ParentType<_TypeKind.Union _Described _UnionMember>
    }

dual _UnionMember {
    : _Described
        union: _Identifier
    }
```

## Object types

### Object Commonalities

```gqlp
output _TypeObject<$kind $parent $typeParam $field $alternate> {
    : _ChildType<$kind $parent>
        typeParams: $typeParam[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

dual _ObjDescribed<$base> {
        base: $base
        description: String[]
    | $base
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
        typeArgs: _ObjDescribed<$arg>[]
    | _TypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
    | _TypeParam
}

domain _TypeParam { :_Identifier String }

output _ObjTypeParam<$base> {
    typeParam: _TypeParam
    description: String[]
    constraint: _ObjConstraint<$base>
}

output _Alternate<$base> {
      type: _ObjDescribed<$base>
      collections: _Collections[]
    }

output _ObjectFor<$for> {
    : $for
        object: _Identifier
    }

output _Field<$base> {
    : _Aliased
      type: _ObjDescribed<$base>
      modifiers: _Modifiers[]
    }
```

### Dual type

```gqlp
output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualParent _DualTypeParam _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase<_ObjTypeArg>
        dual: _Identifier
    }

output _DualParent {
    : _ObjDescribed<_DualBase>
    }

output _DualTypeParam {
    : _ObjTypeParam<_DualBase>
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualBase>
    }
```

### Input type

```gqlp
output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputParent _InputTypeParam _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase<_ObjTypeArg>
        input: _Identifier
    | _DualBase
    }

output _InputParent {
    : _ObjDescribed<_InputBase>
    }

output _InputTypeParam {
    : _ObjTypeParam<_InputBase>
    }

output _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

output _InputAlternate {
    : _Alternate<_InputBase>
    }

output _InputParam {
    : _ObjDescribed<_InputBase>
        modifiers: _Modifiers[]
        default: _Constant?
    }
```

### Output type

```gqlp
output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputParent _OutputTypeParam _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase<_OutputTypeArg>
        output: _Identifier
    | _DualBase
    }

output _OutputParent {
    : _ObjDescribed<_OutputBase>
    }

output _OutputTypeParam {
    : _ObjTypeParam<_OutputBase>
    }

output _OutputField {
    : _Field<_OutputBase>
        parameter: _InputParam[]
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

## Complete Definition

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
    : _Described
        aliases: _Identifier[]
    }

dual _Described {
    : _Named
        description: String[]
    }

dual _Named {
        name: _Identifier
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
    : _Described
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
    : _ChildType<$kind _Described>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Domain Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

output _TypeRef<$kind> {
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
        description: String[]
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
    : _ParentType<_TypeKind.Union _Described _UnionMember>
    }

dual _UnionMember {
    : _Described
        union: _Identifier
    }

output _TypeObject<$kind $parent $typeParam $field $alternate> {
    : _ChildType<$kind $parent>
        typeParams: $typeParam[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

dual _ObjDescribed<$base> {
        base: $base
        description: String[]
    | $base
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
        typeArgs: _ObjDescribed<$arg>[]
    | _TypeParam
    }

output _ObjTypeArg {
    : _TypeRef<_TypeKind>
    | _TypeParam
}

domain _TypeParam { :_Identifier String }

output _ObjTypeParam<$base> {
    typeParam: _TypeParam
    description: String[]
    constraint: _ObjConstraint<$base>
}

output _Alternate<$base> {
      type: _ObjDescribed<$base>
      collections: _Collections[]
    }

output _ObjectFor<$for> {
    : $for
        object: _Identifier
    }

output _Field<$base> {
    : _Aliased
      type: _ObjDescribed<$base>
      modifiers: _Modifiers[]
    }

output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualParent _DualTypeParam _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase<_ObjTypeArg>
        dual: _Identifier
    }

output _DualParent {
    : _ObjDescribed<_DualBase>
    }

output _DualTypeParam {
    : _ObjTypeParam<_DualBase>
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualBase>
    }

output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputParent _InputTypeParam _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase<_ObjTypeArg>
        input: _Identifier
    | _DualBase
    }

output _InputParent {
    : _ObjDescribed<_InputBase>
    }

output _InputTypeParam {
    : _ObjTypeParam<_InputBase>
    }

output _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

output _InputAlternate {
    : _Alternate<_InputBase>
    }

output _InputParam {
    : _ObjDescribed<_InputBase>
        modifiers: _Modifiers[]
        default: _Constant?
    }

output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputParent _OutputTypeParam _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase<_OutputTypeArg>
        output: _Identifier
    | _DualBase
    }

output _OutputParent {
    : _ObjDescribed<_OutputBase>
    }

output _OutputTypeParam {
    : _ObjTypeParam<_OutputBase>
    }

output _OutputField {
    : _Field<_OutputBase>
        parameter: _InputParam[]
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
