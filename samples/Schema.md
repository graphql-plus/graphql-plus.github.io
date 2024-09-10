# Schema Samples

## Root

### all.graphql+

```
category { All }
directive @all { All }
enum One { Two Three }
input Param { afterId: Guid? beforeId: Guid | String }
output All { items(Param?): String[] | String }
domain Guid { String /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/ }
```

### default.graphql+

```
category { Query }
output Query { }

category { (sequential) Mutation }
output Mutation { }

category { (single) Subscription }
output Subscription { }

output _Schema { }
```

### errors.graphql+

```
category query {}
directive @ {}
enum None [] {}
input Empty {}
output NoParams<> {}
domain Other { Enum }
```

### Intro_Built-In.graphql+

```
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

### Intro_Category.graphql+

```
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

### Intro_Common.graphql+

```
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
    : _ChildType<$kind _Identifier>
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

### Intro_Complete.graphql+

```
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        types(_TypeFilter?): _Type[_Identifier]
        settings(_Filter?): _Setting[_Identifier]
    }

domain _Identifier { String /[A-Za-z_]+/ }

input _Filter  {
        names: _NameFilter[]
        matchAliases: Boolean? = true
        aliases: _NameFilter[]
        returnByAlias: Boolean? = false
        returnReferencedTypes: Boolean? = false
    | _NameFilter[]
    }

"_NameFilter is a simple match expression against _Identifier  where '.' matches any single character and '*' matches zero or more of any character."
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
        description: String
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
    : _ChildType<$kind _Identifier>
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
    | _BaseDomain<_DomainKind.Enum _DomainMember _DomainItemMember>
    | _BaseDomain<_DomainKind.Number _DomainRange _DomainItemRange>
    | _BaseDomain<_DomainKind.String _DomainRegex _DomainItemRegex>
    }

output _DomainRef<$kind> {
    : _TypeRef<_TypeKind.Domain>
        domainKind: $kind
    }

output _BaseDomain<$domain $item $domainItem> {
    : _ParentType<_TypeKind.Domain $item  $domainItem>
        domain: $domain
    }

dual _BaseDomainItem {
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
output _DomainMember {
    : _BaseDomainItem
        value: _EnumValue
    }

output _DomainItemMember {
    : _DomainItem<_DomainMember>
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
    : _ParentType<_TypeKind.Enum _Aliased _EnumMember>
    }

dual _EnumMember {
    : _Aliased
        enum: _Identifier
    }

output _EnumValue {
    : _TypeRef<_TypeKind.Enum>
        member: _Identifier
    }
output _TypeUnion {
    : _ParentType<_TypeKind.Union _Named _UnionMember>
    }

dual _UnionMember {
    : _Named
        union: _Identifier
    }
output _TypeObject<$kind $parent $field $alternate> {
    : _ChildType<$kind $parent>
        typeParams: _Described[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

dual _ObjDescribed<$base> {
        base: $base
        description: String
    | $base
    }

output _ObjType<$base> {
    | _BaseType<_TypeKind.Internal>
    | _TypeSimple
    | $base
    }

output _ObjBase {
        typeArgs: _ObjDescribed<_ObjArg>[]
    | _TypeParam
    }

output _ObjArg {
    : _TypeRef<_TypeKind>
    | _TypeParam
}

domain _TypeParam { :_Identifier String }

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
    : _TypeObject<_TypeKind.Dual _DualParent _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase
        dual: _Identifier
    }

output _DualParent {
    : _ObjDescribed<_DualBase>
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualBase>
    }
output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputParent _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase
        input: _Identifier
    | _DualBase
    }

output _InputParent {
    : _ObjDescribed<_InputBase>
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
    : _TypeObject<_TypeKind.Output _OutputParent _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase
        output: _Identifier
    | _DualBase
    }

output _OutputParent {
    : _ObjDescribed<_OutputBase>
    }

output _OutputField {
    : _Field<_OutputBase>
        parameter: _InputParam[]
    | _OutputEnum
    }

output _OutputAlternate {
    : _Alternate<_OutputBase>
    }

output _OutputArg {
    : _TypeRef<_TypeKind>
        member: _Identifier?
    | _TypeParam
    }

output _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: _Identifier
        member: _Identifier
    }
```

### Intro_Declarations.graphql+

```
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[_Identifier]
        directives(_Filter?): _Directives[_Identifier]
        types(_TypeFilter?): _Type[_Identifier]
        settings(_Filter?): _Setting[_Identifier]
    }

domain _Identifier { String /[A-Za-z_]+/ }

input _Filter  {
        names: _NameFilter[]
        matchAliases: Boolean? = true
        aliases: _NameFilter[]
        returnByAlias: Boolean? = false
        returnReferencedTypes: Boolean? = false
    | _NameFilter[]
    }

"_NameFilter is a simple match expression against _Identifier  where '.' matches any single character and '*' matches zero or more of any character."
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

### Intro_Directive.graphql+

```
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

### Intro_Domain.graphql+

```
enum _DomainKind { Boolean Enum Number String }

output _TypeDomain {
    | _BaseDomain<_DomainKind.Boolean _DomainTrueFalse _DomainItemTrueFalse>
    | _BaseDomain<_DomainKind.Enum _DomainMember _DomainItemMember>
    | _BaseDomain<_DomainKind.Number _DomainRange _DomainItemRange>
    | _BaseDomain<_DomainKind.String _DomainRegex _DomainItemRegex>
    }

output _DomainRef<$kind> {
    : _TypeRef<_TypeKind.Domain>
        domainKind: $kind
    }

output _BaseDomain<$domain $item $domainItem> {
    : _ParentType<_TypeKind.Domain $item  $domainItem>
        domain: $domain
    }

dual _BaseDomainItem {
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
output _DomainMember {
    : _BaseDomainItem
        value: _EnumValue
    }

output _DomainItemMember {
    : _DomainItem<_DomainMember>
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

### Intro_Dual.graphql+

```
output _TypeDual {
    : _TypeObject<_TypeKind.Dual _DualParent _DualField _DualAlternate>
    }

output _DualBase {
    : _ObjBase
        dual: _Identifier
    }

output _DualParent {
    : _ObjDescribed<_DualBase>
    }

output _DualField {
    : _Field<_DualBase>
    }

output _DualAlternate {
    : _Alternate<_DualBase>
    }
```

### Intro_Enum.graphql+

```
output _TypeEnum {
    : _ParentType<_TypeKind.Enum _Aliased _EnumMember>
    }

dual _EnumMember {
    : _Aliased
        enum: _Identifier
    }

output _EnumValue {
    : _TypeRef<_TypeKind.Enum>
        member: _Identifier
    }
```

### Intro_Input.graphql+

```
output _TypeInput {
    : _TypeObject<_TypeKind.Input _InputParent _InputField _InputAlternate>
    }

output _InputBase {
    : _ObjBase
        input: _Identifier
    | _DualBase
    }

output _InputParent {
    : _ObjDescribed<_InputBase>
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

### Intro_Names.graphql+

```
dual _Aliased {
    : _Described
        aliases: _Identifier[]
    }

dual _Described {
    : _Named
        description: String
    }

dual _Named {
        name: _Identifier
    }
```

### Intro_Object.graphql+

```
output _TypeObject<$kind $parent $field $alternate> {
    : _ChildType<$kind $parent>
        typeParams: _Described[]
        fields: $field[]
        alternates: $alternate[]
        allFields: _ObjectFor<$field>[]
        allAlternates: _ObjectFor<$alternate>[]
    }

dual _ObjDescribed<$base> {
        base: $base
        description: String
    | $base
    }

output _ObjType<$base> {
    | _BaseType<_TypeKind.Internal>
    | _TypeSimple
    | $base
    }

output _ObjBase {
        typeArgs: _ObjDescribed<_ObjArg>[]
    | _TypeParam
    }

output _ObjArg {
    : _TypeRef<_TypeKind>
    | _TypeParam
}

domain _TypeParam { :_Identifier String }

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

### Intro_Option.graphql+

```
output _Setting {
    : _Described
        value: _Constant
}
```

### Intro_Output.graphql+

```
output _TypeOutput {
    : _TypeObject<_TypeKind.Output _OutputParent _OutputField _OutputAlternate>
    }

output _OutputBase {
    : _ObjBase
        output: _Identifier
    | _DualBase
    }

output _OutputParent {
    : _ObjDescribed<_OutputBase>
    }

output _OutputField {
    : _Field<_OutputBase>
        parameter: _InputParam[]
    | _OutputEnum
    }

output _OutputAlternate {
    : _Alternate<_OutputBase>
    }

output _OutputArg {
    : _TypeRef<_TypeKind>
        member: _Identifier?
    | _TypeParam
    }

output _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: _Identifier
        member: _Identifier
    }
```

### Intro_Union.graphql+

```
output _TypeUnion {
    : _ParentType<_TypeKind.Union _Named _UnionMember>
    }

dual _UnionMember {
    : _Named
        union: _Identifier
    }
```

## InvalidGlobals

### InvalidGlobals\bad-parse.graphql+

```

```

### InvalidGlobals\category-diff-mod.graphql+

```
category { Test }
category { Test? }
output Test { }
```

### InvalidGlobals\category-dup-alias.graphql+

```
category [a] { Test }
category [a] { Output }
output Test { }
output Output { }
```

### InvalidGlobals\category-duplicate.graphql+

```
category { Test }
category test { Output }
output Test { }
output Output { }
```

### InvalidGlobals\category-output-generic.graphql+

```
category { Test }
output Test<$a> { | $a }
```

### InvalidGlobals\category-output-mod-param.graphql+

```
category { Test[$a] }
output Test { }
```

### InvalidGlobals\category-output-undef.graphql+

```
category { Test }
```

### InvalidGlobals\category-output-wrong.graphql+

```
category { Test }
input Test { }
```

### InvalidGlobals\directive-diff-option.graphql+

```
directive @Test { all }
directive @Test { ( repeatable ) all }
```

### InvalidGlobals\directive-diff-param.graphql+

```
directive @Test(Test) { all }
directive @Test(Test?) { all }
input Test { }
```

### InvalidGlobals\directive-no-param.graphql+

```
directive @Test(Test) { all }
```

### InvalidGlobals\directive-param-mod-param.graphql+

```
directive @Test(TestIn[$a]) { all }
input TestIn { }
```

### InvalidGlobals\option-diff-name.graphql+

```
option Test { }
option Schema { }
```

## InvalidObjects

### InvalidObjects\alt-diff-mod.graphql+

```
object Test { | Test1 }
object Test { | Test1[] }
object Test1 { }
```

### InvalidObjects\alt-mod-undef-param.graphql+

```
object Test { | Alt[$a] }
object Alt { }
```

### InvalidObjects\alt-mod-undef.graphql+

```
object Test { | Alt[Domain] }
object Alt { }
```

### InvalidObjects\alt-mod-wrong.graphql+

```
object Test { | Alt[Test] }
object Alt { }
```

### InvalidObjects\alt-more.graphql+

```
object Test { | Recurse }
object Recurse { | More }
object More { | Test }
```

### InvalidObjects\alt-recurse.graphql+

```
object Test { | Recurse }
object Recurse { | Test }
```

### InvalidObjects\alt-self.graphql+

```
object Test { | Test }
```

### InvalidObjects\alt-simple-param.graphql+

```
object Test { | Number<String> }
```

### InvalidObjects\dual-alt-input.graphql+

```
dual Test { | Bad }
input Bad { }
```

### InvalidObjects\dual-alt-output.graphql+

```
dual Test { | Bad }
output Bad { }
```

### InvalidObjects\dual-alt-param-input.graphql+

```
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

### InvalidObjects\dual-alt-param-output.graphql+

```
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

### InvalidObjects\dual-field-input.graphql+

```
dual Test { field: Bad }
input Bad { }
```

### InvalidObjects\dual-field-output.graphql+

```
dual Test { field: Bad }
output Bad { }
```

### InvalidObjects\dual-field-param-input.graphql+

```
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

### InvalidObjects\dual-field-param-output.graphql+

```
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

### InvalidObjects\dual-parent-input.graphql+

```
dual Test { :Bad }
input Bad { }
```

### InvalidObjects\dual-parent-output.graphql+

```
dual Test { :Bad }
output Bad { }
```

### InvalidObjects\dual-parent-param-input.graphql+

```
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

### InvalidObjects\dual-parent-param-output.graphql+

```
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

### InvalidObjects\field-alias.graphql+

```
object Test { field1[alias]: Test }
object Test { field2[alias]: Test[] }
```

### InvalidObjects\field-diff-mod.graphql+

```
object Test { field: Test }
object Test { field: Test[] }
```

### InvalidObjects\field-diff-type.graphql+

```
object Test { field: Test }
object Test { field: Test1 }
object Test1 { }
```

### InvalidObjects\field-mod-undef-param.graphql+

```
object Test { field: Test[$a] }
```

### InvalidObjects\field-mod-undef.graphql+

```
object Test { field: Test[Random] }
```

### InvalidObjects\field-mod-wrong.graphql+

```
object Test { field: Test[Test] }
```

### InvalidObjects\field-simple-param.graphql+

```
object Test { field: String<0> }
```

### InvalidObjects\generic-alt-undef.graphql+

```
object Test { | $type }
```

### InvalidObjects\generic-arg-less.graphql+

```
object Test { field: Ref }
object Ref<$ref> { | $ref }
```

### InvalidObjects\generic-arg-more.graphql+

```
object Test<$type> { field: Ref<$type> }
object Ref { }
```

### InvalidObjects\generic-arg-undef.graphql+

```
object Test { field: Ref<$type> }
object Ref<$ref> { | $ref }
```

### InvalidObjects\generic-field-undef.graphql+

```
object Test { field: $type }
```

### InvalidObjects\generic-param-undef.graphql+

```
object Test { field: Ref<Test1> }
object Ref<$ref> { | $ref }
```

### InvalidObjects\generic-parent-less.graphql+

```
object Test { :Ref }
object Ref<$ref> { | $ref }
```

### InvalidObjects\generic-parent-more.graphql+

```
object Test { :Ref<Number> }
object Ref { }
```

### InvalidObjects\generic-parent-undef.graphql+

```
object Test { :$type }
```

### InvalidObjects\generic-unused.graphql+

```
object Test<$type> { }
```

### InvalidObjects\input-alt-output.graphql+

```
input Test { | Bad }
output Bad { }
```

### InvalidObjects\input-field-null.graphql+

```
input Test { field: Test = null }
```

### InvalidObjects\input-field-output.graphql+

```
input Test { field: Bad }
output Bad { }
```

### InvalidObjects\input-parent-output.graphql+

```
input Test { :Bad }
output Bad { }
```

### InvalidObjects\output-alt-input.graphql+

```
output Test { | Bad }
input Bad { }
```

### InvalidObjects\output-enum-bad.graphql+

```
output Test { field = unknown }
```

### InvalidObjects\output-enum-diff.graphql+

```
output Test { field = true }
output Test { field = false }
```

### InvalidObjects\output-enumValue-bad.graphql+

```
output Test { field = Boolean.unknown }
```

### InvalidObjects\output-enumValue-wrong.graphql+

```
output Test { field = Wrong.unknown }
input Wrong { }
```

### InvalidObjects\output-field-input.graphql+

```
output Test { field: Bad }
input Bad { }
```

### InvalidObjects\output-generic-enum-bad.graphql+

```
output Test { | Ref<Boolean.unknown> }
output Ref<$type> { field: $type }
```

### InvalidObjects\output-generic-enum-wrong.graphql+

```
output Test { | Ref<Wrong.unknown> }
output Ref<$type> { field: $type }
output Wrong { }
```

### InvalidObjects\output-param-diff.graphql+

```
output Test { field(Param): Test }
output Test { field(Param?): Test }
input Param { }
```

### InvalidObjects\output-param-mod-undef-param.graphql+

```
output Test { field(Param[$a]): Test }
input Param { }
```

### InvalidObjects\output-param-mod-undef.graphql+

```
output Test { field(Param[Domain]): Test }
input Param { }
```

### InvalidObjects\output-param-mod-wrong.graphql+

```
output Test { field(Param[Test]): Test }
input Param { }
```

### InvalidObjects\output-param-undef.graphql+

```
output Test { field(Param): Test }
```

### InvalidObjects\output-parent-input.graphql+

```
output Test { :Bad }
input Bad { }
```

### InvalidObjects\parent-alt-mod.graphql+

```
object Test { :Parent }
object Test { | Alt }
object Parent { | Alt[] }
object Alt { }
```

### InvalidObjects\parent-alt-more.graphql+

```
object Test { :Recurse | Alt }
object Recurse { :More }
object More { :Parent }
object Parent { | Alt[] }
object Alt { }
```

### InvalidObjects\parent-alt-recurse.graphql+

```
object Test { :Recurse | Alt }
object Recurse { :Parent }
object Parent { | Alt[] }
object Alt { }
```

### InvalidObjects\parent-alt-self-more.graphql+

```
object Test { :Alt }
object Alt { | More }
object More { :Recurse }
object Recurse { | Test }
```

### InvalidObjects\parent-alt-self-recurse.graphql+

```
object Test { :Alt }
object Alt { | Recurse }
object Recurse { :Test }
```

### InvalidObjects\parent-alt-self.graphql+

```
object Test { :Alt }
object Alt { | Test }
```

### InvalidObjects\parent-field-alias-more.graphql+

```
object Test { :Recurse field1[alias]: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field2[alias]: Parent }
```

### InvalidObjects\parent-field-alias-recurse.graphql+

```
object Test { :Recurse field1[alias]: Test }
object Recurse { :Parent }
object Parent { field2[alias]: Parent }
```

### InvalidObjects\parent-field-alias.graphql+

```
object Test { :Parent }
object Test { field1[alias]: Test }
object Parent { field2[alias]: Parent }
```

### InvalidObjects\parent-field-mod-more.graphql+

```
object Test { :Recurse field: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field: Test[] }
```

### InvalidObjects\parent-field-mod-recurse.graphql+

```
object Test { :Recurse field: Test }
object Recurse { :Parent }
object Parent { field: Test[] }
```

### InvalidObjects\parent-field-mod.graphql+

```
object Test { :Parent }
object Test { field: Test }
object Parent { field: Test[] }
```

### InvalidObjects\parent-more.graphql+

```
object Test { :Recurse }
object Recurse { :More }
object More { :Test }
```

### InvalidObjects\parent-recurse.graphql+

```
object Test { :Recurse }
object Recurse { :Test }
```

### InvalidObjects\parent-self-alt-more.graphql+

```
object Test { | Alt }
object Alt { :More }
object More { | Recurse }
object Recurse { :Test }
```

### InvalidObjects\parent-self-alt-recurse.graphql+

```
object Test { | Alt }
object Alt { :Recurse }
object Recurse { | Test }
```

### InvalidObjects\parent-self-alt.graphql+

```
object Test { | Alt }
object Alt { :Test }
```

### InvalidObjects\parent-self.graphql+

```
object Test { :Test }
```

### InvalidObjects\parent-simple.graphql+

```
object Test { :String }
```

### InvalidObjects\parent-undef.graphql+

```
object Test { :Parent }
```

### InvalidObjects\unique-alias.graphql+

```
object Test [a] { }
object Dup [a] { }
```

## InvalidSimple

### InvalidSimple\domain-diff-kind.graphql+

```
domain Test { string }
domain Test { number }
```

### InvalidSimple\domain-dup-alias.graphql+

```
domain Test [a] { Boolean }
domain Dup [a] { Boolean }
```

### InvalidSimple\domain-enum-none.graphql+

```
domain Test { Enum }
```

### InvalidSimple\domain-enum-parent-unique.graphql+

```
domain Test { :Parent Enum Enum.value }
domain Parent { Enum Dup.value }
enum Enum { value }
enum Dup { value }
```

### InvalidSimple\domain-enum-undef-all.graphql+

```
domain Test { enum Undef.* }
```

### InvalidSimple\domain-enum-undef-member.graphql+

```
domain Test { enum Enum.undef }
enum Enum { value }
```

### InvalidSimple\domain-enum-undef-value.graphql+

```
domain Test { enum Undef.value }
```

### InvalidSimple\domain-enum-undef.graphql+

```
domain Test { enum undef }
```

### InvalidSimple\domain-enum-unique-all.graphql+

```
domain Test { enum Enum.* Dup.* }
enum Enum { value }
enum Dup { value }
```

### InvalidSimple\domain-enum-unique-member.graphql+

```
domain Test { enum Enum.value Dup.* }
enum Enum { value }
enum Dup { value }
```

### InvalidSimple\domain-enum-unique.graphql+

```
domain Test { enum Enum.value Dup.value }
enum Enum { value }
enum Dup { value }
```

### InvalidSimple\domain-enum-wrong.graphql+

```
domain Test { enum Bad.value }
output Bad { }
```

### InvalidSimple\domain-number-parent.graphql+

```
domain Test { :Parent number 1> }
domain Parent { number !1> }
```

### InvalidSimple\domain-parent-self-more.graphql+

```
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :More Boolean }
domain More { :Test Boolean }
```

### InvalidSimple\domain-parent-self-parent.graphql+

```
domain Test { :Parent Boolean }
domain Parent { :Test Boolean }
```

### InvalidSimple\domain-parent-self-recurse.graphql+

```
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :Test Boolean }
```

### InvalidSimple\domain-parent-self.graphql+

```
domain Test { :Test Boolean }
```

### InvalidSimple\domain-parent-undef.graphql+

```
domain Test { :Parent Boolean }
```

### InvalidSimple\domain-parent-wrong-kind.graphql+

```
domain Test { :Parent Boolean }
domain Parent { String }
```

### InvalidSimple\domain-parent-wrong-type.graphql+

```
domain Test { :Parent Boolean }
output Parent { }
```

### InvalidSimple\domain-string-diff.graphql+

```
domain Test { string /a+/}
domain Test { string !/a+/ }
```

### InvalidSimple\domain-string-parent.graphql+

```
domain Test { :Parent string /a+/}
domain Parent { string !/a+/ }
```

### InvalidSimple\enum-dup-alias.graphql+

```
enum Test [a] { test }
enum Dup [a] { dup }
```

### InvalidSimple\enum-parent-alias-dup.graphql+

```
enum Test { :Parent test[alias] }
enum Parent { parent[alias] }
```

### InvalidSimple\enum-parent-diff.graphql+

```
enum Test { :Parent test }
enum Test { test }
enum Parent { parent }
```

### InvalidSimple\enum-parent-undef.graphql+

```
enum Test { :Parent test }
```

### InvalidSimple\enum-parent-wrong.graphql+

```
enum Test { :Parent test }
output Parent { }
```

### InvalidSimple\union-more-parent.graphql+

```
union Test { Recurse }
union Recurse { :Parent }
union Parent { More }
union More { :Bad }
union Bad { Test }
```

### InvalidSimple\union-more.graphql+

```
union Test { Bad }
union Bad { More }
union More { Test }
```

### InvalidSimple\union-parent-more.graphql+

```
union Test { :Parent }
union Parent { More }
union More { :Bad }
union Bad { Test }
```

### InvalidSimple\union-parent-recurse.graphql+

```
union Test { :Parent }
union Parent { Bad }
union Bad { Test }
```

### InvalidSimple\union-parent.graphql+

```
union Test { :Parent }
union Parent { Test }
```

### InvalidSimple\union-recurse-parent.graphql+

```
union Test { Bad }
union Bad { :Parent }
union Parent { Test }
```

### InvalidSimple\union-recurse.graphql+

```
union Test { Bad }
union Bad { Test }
```

### InvalidSimple\union-self.graphql+

```
union Test { Test }
```

### InvalidSimple\union-undef.graphql+

```
union Test { Bad }
```

### InvalidSimple\union-wrong.graphql+

```
union Test { Bad }
input Bad { }
```

### InvalidSimple\unique-type-alias.graphql+

```
enum Test [a] { Value }
output Dup [a] { }
```

### InvalidSimple\unique-types.graphql+

```
enum Test { Value }
output Test { }
```

## ValidGlobals

### ValidGlobals\category-output-dict.graphql+

```
category { CatDict[*] }
output CatDict { }
```

### ValidGlobals\category-output-list.graphql+

```
category { CatList[] }
output CatList { }
```

### ValidGlobals\category-output-optional.graphql+

```
category { CatOpt? }
output CatOpt { }
```

### ValidGlobals\category-output.graphql+

```
category { Cat }
output Cat { }
```

### ValidGlobals\description-backslash.graphql+

```
'A backslash ("\\") description'
output DescrBackslash { }
```

### ValidGlobals\description-between.graphql+

```
category { DescrBetween }
"A description between"
output DescrBetween { }
```

### ValidGlobals\description-complex.graphql+

```
"A \"more\" 'Complicated' \\ description"
output DescrComplex { }
```

### ValidGlobals\description-double.graphql+

```
"A 'double-quoted' description"
output DescrDouble { }
```

### ValidGlobals\description-single.graphql+

```
'A "single-quoted" description'
output DescrSingle { }
```

### ValidGlobals\description.graphql+

```
"A simple description"
output Descr { }
```

### ValidGlobals\directive-param-dict.graphql+

```
directive @DirParamDict(DirParamIn[String]) { all }
input DirParamIn { }
```

### ValidGlobals\directive-param-in.graphql+

```
directive @DirParam(DirParamIn) { all }
input DirParamIn { }
```

### ValidGlobals\directive-param-list.graphql+

```
directive @DirParamList(DirParamIn[]) { all }
input DirParamIn { }
```

### ValidGlobals\directive-param-opt.graphql+

```
directive @DirParamOpt(DirParamIn?) { all }
input DirParamIn { }
```

### ValidGlobals\option-setting.graphql+

```
option Schema { setting = true }
```

## ValidMerges

### ValidMerges\category-alias.graphql+

```
category [CatA1] { CatAlias }
category [CatA2] { CatAlias }
output CatAlias { }
```

### ValidMerges\category-mod.graphql+

```
category [CatM1] { CatMods? }
category [CatM2] { CatMods? }
output CatMods { }
```

### ValidMerges\category.graphql+

```
category { Category }
category category { Category }
output Category { }
```

### ValidMerges\directive-alias.graphql+

```
directive @DirAlias [DirA1] { variable }
directive @DirAlias [DirA2] { field }
```

### ValidMerges\directive-param.graphql+

```
directive @DirParam(DirParamIn) { operation }
directive @DirParam { fragment }
input DirParamIn { }
```

### ValidMerges\directive.graphql+

```
directive @Dir { inline }
directive @Dir { spread }
```

### ValidMerges\domain-alias.graphql+

```
domain NumAlias [Num1] { number }
domain NumAlias [Num2] { number }
```

### ValidMerges\domain-boolean-diff.graphql+

```
domain BoolDiff { boolean true }
domain BoolDiff { boolean false }
```

### ValidMerges\domain-boolean-same.graphql+

```
domain BoolSame { boolean true }
domain BoolSame { boolean true }
```

### ValidMerges\domain-boolean.graphql+

```
domain Bool { boolean }
domain Bool { boolean }
```

### ValidMerges\domain-enum-diff.graphql+

```
domain EnumDiff { enum true }
domain EnumDiff { enum false }
```

### ValidMerges\domain-enum-same.graphql+

```
domain EnumSame { enum true }
domain EnumSame { enum true }
```

### ValidMerges\domain-number-diff.graphql+

```
domain NumDiff { number 1~9 }
domain NumDiff { number }
```

### ValidMerges\domain-number-same.graphql+

```
domain NumSame { number 1~9 }
domain NumSame { number 1~9 }
```

### ValidMerges\domain-number.graphql+

```
domain Num { number }
domain Num { number }
```

### ValidMerges\domain-string-diff.graphql+

```
domain StrDiff { string /a+/ }
domain StrDiff { string }
```

### ValidMerges\domain-string-same.graphql+

```
domain StrSame { string /a+/ }
domain StrSame { string /a+/ }
```

### ValidMerges\domain-string.graphql+

```
domain Str { string }
domain Str { string }
```

### ValidMerges\enum-alias.graphql+

```
enum EnAlias [En1] { alias }
enum EnAlias [En2] { alias }
```

### ValidMerges\enum-diff.graphql+

```
enum EnDiff { one }
enum EnDiff { two }
```

### ValidMerges\enum-same-parent.graphql+

```
enum EnSameParent { :EnParent sameP }
enum EnSameParent { :EnParent sameP }
enum EnParent { parent }
```

### ValidMerges\enum-same.graphql+

```
enum EnSame { same }
enum EnSame { same }
```

### ValidMerges\enum-value-alias.graphql+

```
enum EnValAlias { value [val1] }
enum EnValAlias { value [val2] }
```

### ValidMerges\object-alias.graphql+

```
object ObjName [Obj1] { }
object ObjName [Obj2] { }
```

### ValidMerges\object-alt.graphql+

```
object ObjName { | ObjNameType }
object ObjName { | ObjNameType }
object ObjNameType { }
```

### ValidMerges\object-field-alias.graphql+

```
object ObjName { field [field1]: ObjNameFld }
object ObjName { field [field2]: ObjNameFld }
object ObjNameFld { }
```

### ValidMerges\object-field.graphql+

```
object ObjName { field: ObjNameFld }
object ObjName { field: ObjNameFld }
object ObjNameFld { }
```

### ValidMerges\object-param.graphql+

```
object ObjName<$test> { test: $test }
object ObjName<$type> { type: $type }
```

### ValidMerges\object-parent.graphql+

```
object ObjName { :ObjNameRef }
object ObjName { :ObjNameRef }
object ObjNameRef { }
```

### ValidMerges\object.graphql+

```
object ObjName { }
object ObjName { }
```

### ValidMerges\option-alias.graphql+

```
option Schema [Opt1] { }
option Schema [Opt2] { }
```

### ValidMerges\option-value.graphql+

```
option Schema { setting=true }
option Schema { setting=[0] }
```

### ValidMerges\option.graphql+

```
option Schema { }
option Schema { }
```

### ValidMerges\output-field-enum-alias.graphql+

```
output FieldEnumAlias { field [field1] = Boolean.true }
output FieldEnumAlias { field [field2] = true }
```

### ValidMerges\output-field-enum-value.graphql+

```
output FieldEnums { field = Boolean.true }
output FieldEnums { field = true }
```

### ValidMerges\output-field-param.graphql+

```
output FieldParam { field(FieldParam1): FieldParamFld }
output FieldParam { field(FieldParam2): FieldParamFld }
input FieldParam1 { }
input FieldParam2 { }
output FieldParamFld { }
```

### ValidMerges\union-diff.graphql+

```
union UnDiff { Boolean }
union UnDiff { Number }
```

### ValidMerges\union-same.graphql+

```
union UnSame { Boolean }
union UnSame { Boolean }
```

## ValidObjects

### ValidObjects\alt-dual.graphql+

```
object ObjName { | ObjDualName }
dual ObjDualName { alt: Number | String }
```

### ValidObjects\alt-mod-Boolean.graphql+

```
object ObjName { | ObjNameAlt[^] }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\alt-mod-param.graphql+

```
object ObjName<$mod> { | ObjNameAlt[$mod] }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\alt-simple.graphql+

```
object ObjName { | String }
```

### ValidObjects\alt.graphql+

```
object ObjName { | ObjNameAlt }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\field-dual.graphql+

```
object ObjName { field: ObjNameFld }
dual ObjNameFld { field: Number | String }
```

### ValidObjects\field-mod-Enum.graphql+

```
object ObjName { field: *[ObjEnumName] }
enum ObjEnumName { value }
```

### ValidObjects\field-mod-param.graphql+

```
object ObjName<$mod> { field: ObjNameFld[$mod] }
object ObjNameFld { field: Number | String }
```

### ValidObjects\field-object.graphql+

```
object ObjName { field: ObjNameFld }
object ObjNameFld { field: Number | String }
```

### ValidObjects\field-simple.graphql+

```
object ObjName { field: Number }
```

### ValidObjects\field.graphql+

```
object ObjName { field: * }
```

### ValidObjects\generic-alt-arg.graphql+

```
object ObjName<$type> { | ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-alt-dual.graphql+

```
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-alt-param.graphql+

```
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-alt-simple.graphql+

```
object ObjName { | ObjNameRef<String> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-alt.graphql+

```
object ObjName<$type> { | $type }
```

### ValidObjects\generic-dual.graphql+

```
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-field-arg.graphql+

```
object ObjName<$type> { field: ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-field-dual.graphql+

```
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-field-param.graphql+

```
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-field.graphql+

```
object ObjName<$type> { field: $type }
```

### ValidObjects\generic-param.graphql+

```
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-arg.graphql+

```
object ObjName<$type> { :ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-parent-dual-parent.graphql+

```
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-dual.graphql+

```
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-param-parent.graphql+

```
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-param.graphql+

```
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent.graphql+

```
object ObjName<$type> { :$type }
```

### ValidObjects\input-field-Enum.graphql+

```
input InFieldEnum { field: InEnumField = value }
enum InEnumField { value }
```

### ValidObjects\input-field-null.graphql+

```
input InFieldNull { field: InFieldNull? = null }
```

### ValidObjects\input-field-Number.graphql+

```
input InFieldNum { field: Number = 0 }
```

### ValidObjects\input-field-String.graphql+

```
input InFieldStr { field: String = '' }
```

### ValidObjects\output-field-enum-parent.graphql+

```
output OutFieldParent { field = OutEnumParented.outEnumParent }
enum OutEnumParented { :OutEnumParent outParent ed }
enum OutEnumParent { outEnumParent }
```

### ValidObjects\output-field-enum.graphql+

```
output OutFieldEnum { field = OutEnumField.outEnumField }
enum OutEnumField { outEnumField }
```

### ValidObjects\output-field-value.graphql+

```
output OutFieldValue { field = outEnumValue }
enum OutEnumValue { outEnumValue }
```

### ValidObjects\output-generic-enum.graphql+

```
output OutGenEnum { | OutGenEnumRef<OutEnumGen.outEnumGen> }
output OutGenEnumRef<$type> { field: $type }
enum OutEnumGen { outEnumGen }
```

### ValidObjects\output-generic-value.graphql+

```
output OutGenValue { | OutGenValueRef<outValueGen> }
output OutGenValueRef<$type> { field: $type }
enum OutValueGen { outValueGen }
```

### ValidObjects\output-param-mod-Domain.graphql+

```
output OutParamDomain { field(OutParamDomainIn[OutDomainParam]): OutDomainParam }
input OutParamDomainIn { param: Number | String }
domain OutDomainParam { number 1 ~ 10 }
```

### ValidObjects\output-param-mod-param.graphql+

```
output OutParamDomainParam<$mod> { field(OutParamDomainParamIn[$mod]): OutDomainsParam }
input OutParamDomainParamIn { param: Number | String }
domain OutDomainsParam { number 1 ~ 10 }
```

### ValidObjects\output-param.graphql+

```
output OutParam { field(OutParamIn): OutParam }
input OutParamIn { param: Number | String }
```

### ValidObjects\output-parent-generic.graphql+

```
output OutGenParent { | OutGenParentRef<OutParentGen.outGenParent> }
output OutGenParentRef<$type> { field: $type }
enum OutParentGen { :OutPrntendedGen outGenPrntended }
enum OutPrntendedGen { outGenParent }
```

### ValidObjects\output-parent-param.graphql+

```
output OutPrntParam { :OutParamParent field(OutPrntParamIn): OutPrntParam }
output OutParamParent { field(OutParamParentIn): OutPrntParam }
input OutPrntParamIn { param: Number | String }
input OutParamParentIn { parent: Number | String }
```

### ValidObjects\parent-alt.graphql+

```
object ObjName { :ObjNameRef | Number }
object ObjNameRef {  parent: Number | String }
```

### ValidObjects\parent-dual.graphql+

```
object ObjName { :ObjNameRef }
dual ObjNameRef { parent: Number | String }
```

### ValidObjects\parent-field.graphql+

```
object ObjName { :ObjNameRef field: Number }
object ObjNameRef { parent: Number | String }
```

### ValidObjects\parent-param-diff.graphql+

```
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$b> { | $b }
```

### ValidObjects\parent-param-same.graphql+

```
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$a> { | $a }
```

### ValidObjects\parent.graphql+

```
object ObjName { :ObjNameRef }
object ObjNameRef { parent: Number | String }
```

## ValidSimple

### ValidSimple\domain-enum-all-parent.graphql+

```
domain DomEnumAllParent { enum EnumDomAllParent.* }
enum EnumDomAllParent { :EnumDomParentAll dom_all_parent }
enum EnumDomParentAll { dom_enum_all_parent }
```

### ValidSimple\domain-enum-all.graphql+

```
domain DomEnumAll { enum EnumDomAll.* }
enum EnumDomAll { dom_all dom_enum_all }
```

### ValidSimple\domain-enum-member.graphql+

```
domain DomMember { enum dom_member }
enum MemberDom { dom_member }
```

### ValidSimple\domain-enum-parent.graphql+

```
domain DomEnumPrnt { :DomPrntEnum Enum both_enum }
domain DomPrntEnum { Enum both_parent }
enum EnumDomBoth { both_enum both_parent }
```

### ValidSimple\domain-enum-unique-parent.graphql+

```
enum EnumDomUniqueParent { :EnumDomParentUnique value }
enum EnumDomParentUnique { enum_dom_parent_dup }
enum EnumDomDupParent { enum_dom_parent_dup }
# domain DomEnumUniqueParent { enum EnumDomUniqueParent.* !EnumDomUniqueParent.enum_dom_parent_dup EnumDomDupParent.enum_dom_parent_dup }
```

### ValidSimple\domain-enum-unique.graphql+

```
enum EnumDomUnique { eum_dom_value eum_dom_dup }
enum EnumDomDup { eum_dom_dup }
# domain DomEnumUnique { enum EnumDomUnique.* !EnumDomUnique.eum_dom_dup EnumDomDup.eum_dom_dup }
```

### ValidSimple\domain-enum-value-parent.graphql+

```
domain DomEnumParent { Enum EnumDomParent.dom_enum_parent }
enum EnumDomParent { :EnumParentDom dom_parent_enum }
enum EnumParentDom { dom_enum_parent }
```

### ValidSimple\domain-enum-value.graphql+

```
domain DomEnum { Enum EnumDom.dom_enum }
enum EnumDom { dom_enum }
```

### ValidSimple\domain-number-parent.graphql+

```
domain DomNumPrnt { :DomPrntNum Number 2>}
domain DomPrntNum { Number <2 }
```

### ValidSimple\domain-parent.graphql+

```
domain DomPrntTest { :DomTestPrnt Boolean false }
domain DomTestPrnt { Boolean true }
```

### ValidSimple\domain-string-parent.graphql+

```
domain DomStrPrnt { :DomPrntStr String /a+/ }
domain DomPrntStr { String /b+/ }
```

### ValidSimple\enum-parent-alias.graphql+

```
enum EnPrntAlias { :EnAliasPrnt val_prnt_alias val_alias[alias_val] }
enum EnAliasPrnt { val_alias }
```

### ValidSimple\enum-parent-dup.graphql+

```
enum EnPrntDup { :EnDupPrnt val_prnt_dup  }
enum EnDupPrnt { val_dup[val_prnt_dup] }
```

### ValidSimple\enum-parent.graphql+

```
enum EnTestPrnt { :EnPrntTest val_prnt }
enum EnPrntTest { val_test }
```

### ValidSimple\union-parent.graphql+

```
union UnionPrnt { :PrntUnion String }
union PrntUnion { Number }
```
