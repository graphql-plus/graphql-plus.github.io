# Schema Samples

## Root

### all.graphql+

```gqlp
category { All }
directive @all { All }
enum One { Two Three }
input Param { afterId: Guid? beforeId: Guid | String }
output All { items(Param?): String[] | String }
domain Guid { String /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/ }
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
enum None [] {}
input Empty {}
output NoParams<> {}
domain Other { Enum }
```

##### Expected Parse errors

- `Invalid Category. Expected output type.`
- `Invalid Schema. Expected no more text.`

##### Expected Verify errors

- `Invalid Category Output. '' not defined or not an Output type.`

### Intro_Built-In.graphql+

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

- `Invalid Output Alternate. '_DomainKind' not defined.`
- `Invalid Output Alternate. '_DomainValue' not defined.`
- `Invalid Output Alternate. '_EnumValue' not defined.`
- `Invalid Output Arg Enum. '_DomainKind' is not an Enum type.`
- `Invalid Output Field. '_TypeSimple' not defined.`

### Intro_Category.graphql+

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

- `Invalid Output Alternate. '_Type' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Modifiers' not defined.`
- `Invalid Output Field. '_Type' not defined.`
- `Invalid Output Field. '_TypeKind' not defined.`
- `Invalid Output Field. '_TypeRef' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`

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

##### Expected Verify errors

- `Invalid Output Alternate. '_TypeDomain' not defined.`
- `Invalid Output Alternate. '_TypeDual' not defined.`
- `Invalid Output Alternate. '_TypeEnum' not defined.`
- `Invalid Output Alternate. '_TypeInput' not defined.`
- `Invalid Output Alternate. '_TypeOutput' not defined.`
- `Invalid Output Alternate. '_TypeUnion' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`
- `Invalid Output Parent. '_Identifier' not defined.`

### Intro_Complete.graphql+

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
        type: _ObjType<_InputBase>
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
        type: _ObjType<_OutputBase>
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

##### Expected Verify errors

- `Invalid Input Field. '_Resolution' not defined.`
- `Invalid Input Field. '_TypeKind' not defined.`
- `Invalid Output Field. '_Categories' not defined.`
- `Invalid Output Field. '_Directives' not defined.`
- `Invalid Output Field. '_Operations' not defined.`
- `Invalid Output Field. '_Setting' not defined.`
- `Invalid Output Field. '_Type' not defined.`
- `Invalid Output Parent. '_Named' not defined.`

### Intro_Directive.graphql+

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

- `Invalid Output Alternate. '_Type' not defined.`
- `Invalid Output Field. '_InputParam' not defined.`
- `Invalid Output Field. '_Type' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`

### Intro_Domain.graphql+

```gqlp
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

##### Expected Verify errors

- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_EnumValue' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Parent. '_ParentType' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Parent. '_TypeRef' not defined.`

### Intro_Dual.graphql+

```gqlp
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

##### Expected Verify errors

- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Parent. '_Alternate' not defined.`
- `Invalid Output Parent. '_Field' not defined.`
- `Invalid Output Parent. '_ObjBase' not defined.`
- `Invalid Output Parent. '_ObjDescribed' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Parent. '_TypeObject' not defined.`

### Intro_Enum.graphql+

```gqlp
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

##### Expected Verify errors

- `Invalid Dual Field. '_Identifier' not defined.`
- `Invalid Dual Parent. '_Aliased' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`
- `Invalid Output Parent. '_ParentType' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Parent. '_TypeRef' not defined.`

### Intro_Input.graphql+

```gqlp
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

##### Expected Verify errors

- `Invalid Output Alternate. '_DualBase' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Constant' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Field. '_Modifiers' not defined.`
- `Invalid Output Parent. '_Alternate' not defined.`
- `Invalid Output Parent. '_Field' not defined.`
- `Invalid Output Parent. '_ObjBase' not defined.`
- `Invalid Output Parent. '_ObjDescribed' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Parent. '_TypeObject' not defined.`

### Intro_Names.graphql+

```gqlp
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

##### Expected Verify errors

- `Invalid Dual Field. '_Identifier' not defined.`

### Intro_Object.graphql+

```gqlp
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

##### Expected Verify errors

- `Invalid Domain Parent. '_Identifier' not defined.`
- `Invalid Output Alternate. '_BaseType' not defined.`
- `Invalid Output Alternate. '_TypeKind' not defined.`
- `Invalid Output Alternate. '_TypeSimple' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Collections' not defined.`
- `Invalid Output Field. '_Described' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Field. '_Modifiers' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`
- `Invalid Output Parent. '_ChildType' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Parent. '_TypeRef' not defined.`

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
        type: _ObjType<_InputBase>
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
        type: _ObjType<_OutputBase>
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

### Intro_Option.graphql+

```gqlp
output _Setting {
    : _Described
        value: _Constant
}
```

##### Expected Verify errors

- `Invalid Output Field. '_Constant' not defined.`
- `Invalid Output Parent. '_Described' not defined.`

### Intro_Output.graphql+

```gqlp
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

##### Expected Verify errors

- `Invalid Output Alternate. '_DualBase' not defined.`
- `Invalid Output Alternate. '_TypeParam' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Field. '_InputParam' not defined.`
- `Invalid Output Parent. '_Alternate' not defined.`
- `Invalid Output Parent. '_Field' not defined.`
- `Invalid Output Parent. '_ObjBase' not defined.`
- `Invalid Output Parent. '_ObjDescribed' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Parent. '_TypeObject' not defined.`
- `Invalid Output Parent. '_TypeRef' not defined.`

### Intro_Union.graphql+

```gqlp
output _TypeUnion {
    : _ParentType<_TypeKind.Union _Named _UnionMember>
    }

dual _UnionMember {
    : _Named
        union: _Identifier
    }
```

##### Expected Verify errors

- `Invalid Dual Field. '_Identifier' not defined.`
- `Invalid Dual Parent. '_Named' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Parent. '_Named' not defined.`
- `Invalid Output Parent. '_ParentType' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
