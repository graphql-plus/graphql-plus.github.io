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

- `Invalid Output Alternate. '_DomainValue' not defined.`
- `Invalid Output Alternate. '_EnumValue' not defined.`
- `Invalid Output Field. '_TypeSimple' not defined.`
- `Invalid Output Alternate. '_DomainKind' not defined.`
- `Invalid Output Arg Enum. '_DomainKind' is not an Enum type.`

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
- `Invalid Output Parent. '_Aliased' not defined.`
- `Invalid Output Field. '_Type' not defined.`
- `Invalid Output Field. '_TypeRef' not defined.`
- `Invalid Output Field. '_Modifiers' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_TypeKind' not defined.`

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

- `Invalid Output Alternate. '_TypeDual' not defined.`
- `Invalid Output Alternate. '_TypeEnum' not defined.`
- `Invalid Output Alternate. '_TypeInput' not defined.`
- `Invalid Output Alternate. '_TypeOutput' not defined.`
- `Invalid Output Alternate. '_TypeDomain' not defined.`
- `Invalid Output Alternate. '_TypeUnion' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Parent. '_Identifier' not defined.`

### Intro_Complete.graphql+

```gqlp
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

```gqlp
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

##### Expected Verify errors

- `Invalid Output Parent. '_Named' not defined.`
- `Invalid Input Field. '_TypeKind' not defined.`
- `Invalid Input Field. '_Resolution' not defined.`
- `Invalid Output Field. '_Setting' not defined.`
- `Invalid Output Field. '_Type' not defined.`
- `Invalid Output Field. '_Directives' not defined.`
- `Invalid Output Field. '_Categories' not defined.`

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
- `Invalid Output Parent. '_Aliased' not defined.`
- `Invalid Output Field. '_Type' not defined.`
- `Invalid Output Field. '_InputParam' not defined.`

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

- `Invalid Output Parent. '_TypeRef' not defined.`
- `Invalid Output Parent. '_ParentType' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Field. '_EnumValue' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`

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

- `Invalid Output Parent. '_TypeObject' not defined.`
- `Invalid Output Parent. '_ObjBase' not defined.`
- `Invalid Output Parent. '_ObjDescribed' not defined.`
- `Invalid Output Parent. '_Field' not defined.`
- `Invalid Output Parent. '_Alternate' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Parent. '_TypeKind' not defined.`

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

- `Invalid Dual Parent. '_Aliased' not defined.`
- `Invalid Output Parent. '_ParentType' not defined.`
- `Invalid Output Parent. '_TypeRef' not defined.`
- `Invalid Dual Field. '_Identifier' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`

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
- `Invalid Output Parent. '_TypeObject' not defined.`
- `Invalid Output Parent. '_ObjBase' not defined.`
- `Invalid Output Parent. '_ObjDescribed' not defined.`
- `Invalid Output Parent. '_Field' not defined.`
- `Invalid Output Parent. '_Alternate' not defined.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Field. '_Constant' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Field. '_Modifiers' not defined.`

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

- `Invalid Output Alternate. '_BaseType' not defined.`
- `Invalid Output Alternate. '_TypeSimple' not defined.`
- `Invalid Output Parent. '_ChildType' not defined.`
- `Invalid Output Parent. '_TypeRef' not defined.`
- `Invalid Domain Parent. '_Identifier' not defined.`
- `Invalid Output Parent. '_Aliased' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Alternate. '_TypeKind' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Field. '_Modifiers' not defined.`
- `Invalid Output Field. '_Collections' not defined.`
- `Invalid Output Field. '_Described' not defined.`

### Intro_Option.graphql+

```gqlp
output _Setting {
    : _Described
        value: _Constant
}
```

##### Expected Verify errors

- `Invalid Output Parent. '_Described' not defined.`
- `Invalid Output Field. '_Constant' not defined.`

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
- `Invalid Output Parent. '_TypeObject' not defined.`
- `Invalid Output Parent. '_ObjBase' not defined.`
- `Invalid Output Parent. '_ObjDescribed' not defined.`
- `Invalid Output Parent. '_Field' not defined.`
- `Invalid Output Parent. '_Alternate' not defined.`
- `Invalid Output Parent. '_TypeRef' not defined.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Field. '_Identifier' not defined.`
- `Invalid Output Field. '_InputParam' not defined.`

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

- `Invalid Dual Parent. '_Named' not defined.`
- `Invalid Output Parent. '_ParentType' not defined.`
- `Invalid Dual Field. '_Identifier' not defined.`
- `Invalid Output Arg Enum. '_TypeKind' is not an Enum type.`
- `Invalid Output Parent. '_TypeKind' not defined.`
- `Invalid Output Parent. '_Named' not defined.`

## InvalidGlobals

### InvalidGlobals\bad-parse.graphql+

```gqlp

```

##### Expected Parse errors

- `Parse Error: Invalid Schema. Expected text.`

### InvalidGlobals\category-diff-mod.graphql+

```gqlp
category { Test }
category { Test? }
output Test { }
```

##### Expected Verify errors

- `Multiple Categories with name 'test' can't be merged.,`
- `Group of SchemaCategory for 'test' is not singular Output~Modifiers~Option['Test~System.Linq.Enumerable+WhereSelectArrayIterator`2[GqlPlus.Abstractions.IGqlpModifier,System.String]~Parallel', 'Test~System.String[]~Parallel']`

### InvalidGlobals\category-dup-alias.graphql+

```gqlp
category [a] { Test }
category [a] { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `Multiple Categories with alias 'a' found. Names 'test' 'output'`

### InvalidGlobals\category-duplicate.graphql+

```gqlp
category { Test }
category test { Output }
output Test { }
output Output { }
```

##### Expected Verify errors

- `Multiple Categories with name 'test' can't be merged.,`
- `Group of SchemaCategory for 'test' is not singular Output~Modifiers~Option['Output~System.String[]~Parallel', 'Test~System.String[]~Parallel']`

### InvalidGlobals\category-output-generic.graphql+

```gqlp
category { Test }
output Test<$a> { | $a }
```

##### Expected Verify errors

- `Invalid Category Output. 'Test' is a generic Output type.`

### InvalidGlobals\category-output-mod-param.graphql+

```gqlp
category { Test[$a] }
output Test { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined.`

### InvalidGlobals\category-output-undef.graphql+

```gqlp
category { Test }
```

##### Expected Verify errors

- `Invalid Category Output. 'Test' not defined or not an Output type.`

### InvalidGlobals\category-output-wrong.graphql+

```gqlp
category { Test }
input Test { }
```

##### Expected Verify errors

- `Invalid Category Output. 'Test' not defined or not an Output type.`

### InvalidGlobals\directive-diff-option.graphql+

```gqlp
directive @Test { all }
directive @Test { ( repeatable ) all }
```

##### Expected Verify errors

- `Multiple Directives with name 'Test' can't be merged.,`
- `Group of SchemaDirective for 'Test' is not singular Option['Repeatable', 'Unique']`

### InvalidGlobals\directive-diff-param.graphql+

```gqlp
directive @Test(Test) { all }
directive @Test(Test?) { all }
input Test { }
```

##### Expected Verify errors

- `Multiple Directives with name 'Test' can't be merged.,`
- `Group of InputParam for 'Test' is not singular Modifiers['', '?']`

### InvalidGlobals\directive-no-param.graphql+

```gqlp
directive @Test(Test) { all }
```

##### Expected Verify errors

- `Invalid Directive Param. '( I@017/0001 Test )' not defined.`

### InvalidGlobals\directive-param-mod-param.graphql+

```gqlp
directive @Test(TestIn[$a]) { all }
input TestIn { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined.`

### InvalidGlobals\option-diff-name.graphql+

```gqlp
option Test { }
option Schema { }
```

##### Expected Verify errors

- `Multiple Schema names (Options) found.`

## InvalidObjects

### InvalidObjects\alt-diff-mod.graphql+

```gqlp
object Test { | Test1 }
object Test { | Test1[] }
object Test1 { }
```

##### Expected Verify errors Ddual

- `Multiple Duals with name 'Test' can't be merged.,`
- `Group of DualAlternate for 'Test1' is not singular Modifiers['', '[]'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Multiple Inputs with name 'Test' can't be merged.,`
- `Group of InputAlternate for 'Test1' is not singular Modifiers['', '[]'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of OutputAlternate for 'Test1' is not singular Modifiers['', '[]'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\alt-mod-undef-param.graphql+

```gqlp
object Test { | Alt[$a] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'a' not defined.`

### InvalidObjects\alt-mod-undef.graphql+

```gqlp
object Test { | Alt[Domain] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Domain' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Domain' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Domain' not defined.`

### InvalidObjects\alt-mod-wrong.graphql+

```gqlp
object Test { | Alt[Test] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Test' invalid type.`

### InvalidObjects\alt-more.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | More }
object More { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via More.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Recurse.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via More.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Recurse.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via More.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Recurse.`

### InvalidObjects\alt-recurse.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test.`

### InvalidObjects\alt-self.graphql+

```gqlp
object Test { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself.`

### InvalidObjects\alt-simple-param.graphql+

```gqlp
object Test { | Number<String> }
```

##### Expected Verify errors Ddual

- `Invalid Dual Alternate. Args invalid on Number, given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Alternate. Args invalid on Number, given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Alternate. Args invalid on Number, given 1.`

### InvalidObjects\dual-alt-input.graphql+

```gqlp
dual Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input.`

### InvalidObjects\dual-alt-output.graphql+

```gqlp
dual Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output.`

### InvalidObjects\dual-alt-param-input.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input.`

### InvalidObjects\dual-alt-param-output.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output.`

### InvalidObjects\dual-field-input.graphql+

```gqlp
dual Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input.`

### InvalidObjects\dual-field-output.graphql+

```gqlp
dual Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output.`

### InvalidObjects\dual-field-param-input.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input.`

### InvalidObjects\dual-field-param-output.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output.`

### InvalidObjects\dual-parent-input.graphql+

```gqlp
dual Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Input'.`

### InvalidObjects\dual-parent-output.graphql+

```gqlp
dual Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Output'.`

### InvalidObjects\dual-parent-param-input.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Input.`

### InvalidObjects\dual-parent-param-output.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Output.`

### InvalidObjects\field-alias.graphql+

```gqlp
object Test { field1 [alias]: Test }
object Test { field2 [alias]: Test[] }
```

##### Expected Verify errors Ddual

- `Multiple Duals with name 'Test' can't be merged.,`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Multiple Inputs with name 'Test' can't be merged.,`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\field-diff-mod.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test[] }
```

##### Expected Verify errors Ddual

- `Multiple Duals with name 'Test' can't be merged.,`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Multiple Inputs with name 'Test' can't be merged.,`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\field-diff-type.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test1 }
object Test1 { }
```

##### Expected Verify errors Ddual

- `Multiple Duals with name 'Test' can't be merged.,`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test1'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Multiple Inputs with name 'Test' can't be merged.,`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test1'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test1'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\field-mod-undef-param.graphql+

```gqlp
object Test { field: Test[$a] }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'a' not defined.`

### InvalidObjects\field-mod-undef.graphql+

```gqlp
object Test { field: Test[Random] }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Random' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Random' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Random' not defined.`

### InvalidObjects\field-mod-wrong.graphql+

```gqlp
object Test { field: Test[Test] }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Test' invalid type.`

### InvalidObjects\field-simple-param.graphql+

```gqlp
object Test { field: String<0> }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. Args invalid on String, given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Field. Args invalid on String, given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. Args invalid on String, given 1.`

### InvalidObjects\generic-alt-undef.graphql+

```gqlp
object Test { | $type }
```

##### Expected Verify errors Ddual

- `Invalid Dual Alternate. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Alternate. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Alternate. '$type' not defined.`

### InvalidObjects\generic-arg-less.graphql+

```gqlp
object Test { field: Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Iinput

- `Invalid Input Field. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. Args mismatch, expected 1 given 0.`

### InvalidObjects\generic-arg-more.graphql+

```gqlp
object Test<$type> { field: Ref<$type> }
object Ref { }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Field. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. Args mismatch, expected 0 given 1.`

### InvalidObjects\generic-arg-undef.graphql+

```gqlp
object Test { field: Ref<$type> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Field. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. '$type' not defined.`

### InvalidObjects\generic-field-undef.graphql+

```gqlp
object Test { field: $type }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Field. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. '$type' not defined.`

### InvalidObjects\generic-param-undef.graphql+

```gqlp
object Test { field: Ref<Test1> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. 'Test1' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Field. 'Test1' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. 'Test1' not defined.`

### InvalidObjects\generic-parent-less.graphql+

```gqlp
object Test { :Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. Args mismatch, expected 1 given 0.`

### InvalidObjects\generic-parent-more.graphql+

```gqlp
object Test { :Ref<Number> }
object Ref { }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. Args mismatch, expected 0 given 1.`

### InvalidObjects\generic-parent-undef.graphql+

```gqlp
object Test { :$type }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. '$type' not defined.`

### InvalidObjects\generic-unused.graphql+

```gqlp
object Test<$type> { }
```

##### Expected Verify errors Ddual

- `Invalid Dual. '$type' not used.`

##### Expected Verify errors Iinput

- `Invalid Input. '$type' not used.`

##### Expected Verify errors Ooutput

- `Invalid Output. '$type' not used.`

### InvalidObjects\input-alt-output.graphql+

```gqlp
input Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Alternate. Type kind mismatch for Bad. Found Output.`

### InvalidObjects\input-field-null.graphql+

```gqlp
input Test { field: Test = null }
```

##### Expected Verify errors

- `Invalid Input Field Default. 'null' default requires Optional type, not 'Test'.`

### InvalidObjects\input-field-output.graphql+

```gqlp
input Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Field. Type kind mismatch for Bad. Found Output.`

### InvalidObjects\input-parent-output.graphql+

```gqlp
input Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Parent. 'Bad' invalid type. Found 'Output'.`

### InvalidObjects\output-alt-input.graphql+

```gqlp
output Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Alternate. Type kind mismatch for Bad. Found Input.`

### InvalidObjects\output-enum-bad.graphql+

```gqlp
output Test { field = unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum. Enum Value 'unknown' not defined.,`
- `Invalid Output Field. '' not defined.`

### InvalidObjects\output-enum-diff.graphql+

```gqlp
output Test { field = true }
output Test { field = false }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of OutputField for 'field' is not singular ModifiedType['Boolean.false', 'Boolean.true'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\output-enumValue-bad.graphql+

```gqlp
output Test { field = Boolean.unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum Value. 'unknown' not a Value of 'Boolean'.`

### InvalidObjects\output-enumValue-wrong.graphql+

```gqlp
output Test { field = Wrong.unknown }
input Wrong { }
```

##### Expected Verify errors

- `Invalid Output Field Enum. 'Wrong' is not an Enum type.,`
- `Invalid Output Field. Type kind mismatch for Wrong. Found Input.`

### InvalidObjects\output-field-input.graphql+

```gqlp
output Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Field. Type kind mismatch for Bad. Found Input.`

### InvalidObjects\output-generic-enum-bad.graphql+

```gqlp
output Test { | Ref<Boolean.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `Invalid Output Arg Enum Value. 'unknown' not a Value of 'Boolean'.`

### InvalidObjects\output-generic-enum-wrong.graphql+

```gqlp
output Test { | Ref<Wrong.unknown> }
output Ref<$type> { field: $type }
output Wrong { }
```

##### Expected Verify errors

- `Invalid Output Arg Enum. 'Wrong' is not an Enum type.`

### InvalidObjects\output-param-diff.graphql+

```gqlp
output Test { field(Param): Test }
output Test { field(Param?): Test }
input Param { }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of InputParam for 'Param' is not singular Modifiers['', '?'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\output-param-mod-undef-param.graphql+

```gqlp
output Test { field(Param[$a]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined.`

### InvalidObjects\output-param-mod-undef.graphql+

```gqlp
output Test { field(Param[Domain]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Domain' not defined.`

### InvalidObjects\output-param-mod-wrong.graphql+

```gqlp
output Test { field(Param[Test]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Test' invalid type.`

### InvalidObjects\output-param-undef.graphql+

```gqlp
output Test { field(Param): Test }
```

##### Expected Verify errors

- `Invalid Input Param. 'Param' not defined.`

### InvalidObjects\output-parent-input.graphql+

```gqlp
output Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Parent. 'Bad' invalid type. Found 'Input'.`

### InvalidObjects\parent-alt-mod.graphql+

```gqlp
object Test { :Parent }
object Test { | Alt }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Multiple Duals with name 'Test' can't be merged.,`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Multiple Inputs with name 'Test' can't be merged.,`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\parent-alt-more.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :More }
object More { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates.,`
- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Iinput

- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates.,`
- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Ooutput

- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates.,`
- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`

### InvalidObjects\parent-alt-recurse.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates.,`
- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Iinput

- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates.,`
- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Ooutput

- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates.,`
- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`

### InvalidObjects\parent-alt-self-more.graphql+

```gqlp
object Test { :Alt }
object Alt { | More }
object More { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More.`

### InvalidObjects\parent-alt-self-recurse.graphql+

```gqlp
object Test { :Alt }
object Alt { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`

### InvalidObjects\parent-alt-self.graphql+

```gqlp
object Test { :Alt }
object Alt { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.`

### InvalidObjects\parent-field-alias-more.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Ddual

- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Iinput

- `Invalid Input Child. Can't merge Test into Parent Recurse.,`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Ooutput

- `Invalid Output Child. Can't merge Test into Parent Recurse.,`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`

### InvalidObjects\parent-field-alias-recurse.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Ddual

- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Iinput

- `Invalid Input Child. Can't merge Test into Parent Recurse.,`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Ooutput

- `Invalid Output Child. Can't merge Test into Parent Recurse.,`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`

### InvalidObjects\parent-field-alias.graphql+

```gqlp
object Test { :Parent }
object Test { field1 [alias]: Test }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Ddual

- `Multiple Duals with name 'Test' can't be merged.,`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Multiple Inputs with name 'Test' can't be merged.,`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\parent-field-mod-more.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Ddual

- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Iinput

- `Invalid Input Child. Can't merge Test into Parent Recurse.,`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Ooutput

- `Invalid Output Child. Can't merge Test into Parent Recurse.,`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`

### InvalidObjects\parent-field-mod-recurse.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Ddual

- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Iinput

- `Invalid Input Child. Can't merge Test into Parent Recurse.,`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Ooutput

- `Invalid Output Child. Can't merge Test into Parent Recurse.,`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`

### InvalidObjects\parent-field-mod.graphql+

```gqlp
object Test { :Parent }
object Test { field: Test }
object Parent { field: Test[] }
```

##### Expected Verify errors Ddual

- `Multiple Duals with name 'Test' can't be merged.,`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Multiple Inputs with name 'Test' can't be merged.,`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Multiple Outputs with name 'Test' can't be merged.,`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidObjects\parent-more.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :More }
object More { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via More.,`
- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test.,`
- `Invalid Dual. 'More' cannot be a child of itself, even recursively via Recurse.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be a child of itself, even recursively via More.,`
- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test.,`
- `Invalid Input. 'More' cannot be a child of itself, even recursively via Recurse.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be a child of itself, even recursively via More.,`
- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test.,`
- `Invalid Output. 'More' cannot be a child of itself, even recursively via Recurse.`

### InvalidObjects\parent-recurse.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via Recurse.,`
- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be a child of itself, even recursively via Recurse.,`
- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be a child of itself, even recursively via Recurse.,`
- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test.`

### InvalidObjects\parent-self-alt-more.graphql+

```gqlp
object Test { | Alt }
object Alt { :More }
object More { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More.`

### InvalidObjects\parent-self-alt-recurse.graphql+

```gqlp
object Test { | Alt }
object Alt { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`

### InvalidObjects\parent-self-alt.graphql+

```gqlp
object Test { | Alt }
object Alt { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.`

### InvalidObjects\parent-self.graphql+

```gqlp
object Test { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be a child of itself.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be a child of itself.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be a child of itself.`

### InvalidObjects\parent-simple.graphql+

```gqlp
object Test { :String }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. 'String' invalid type. Found 'Domain'.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. 'String' invalid type. Found 'Domain'.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. 'String' invalid type. Found 'Domain'.`

### InvalidObjects\parent-undef.graphql+

```gqlp
object Test { :Parent }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. 'Parent' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. 'Parent' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. 'Parent' not defined.`

### InvalidObjects\unique-alias.graphql+

```gqlp
object Test [a] { }
object Dup [a] { }
```

##### Expected Verify errors Ddual

- `Multiple Duals with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Iinput

- `Multiple Inputs with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Ooutput

- `Multiple Outputs with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

## InvalidSimple

### InvalidSimple\domain-diff-kind.graphql+

```gqlp
domain Test { string }
domain Test { number }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged.,`
- `Group of Domain for 'Test' is not singular Domain['Number', 'String'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidSimple\domain-dup-alias.graphql+

```gqlp
domain Test [a] { Boolean }
domain Dup [a] { Boolean }
```

##### Expected Verify errors

- `Multiple Domains with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### InvalidSimple\domain-enum-none.graphql+

```gqlp
domain Test { Enum }
```

##### Expected Verify errors

- `Invalid Domain. Expected enum Members.`

### InvalidSimple\domain-enum-parent-unique.graphql+

```gqlp
domain Test { :Parent Enum Enum.value }
domain Parent { Enum Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items.,`
- `Group of DomainMember for 'value' is not singular Excludes~EnumType['False~Dup', 'False~Enum']`

### InvalidSimple\domain-enum-undef-all.graphql+

```gqlp
domain Test { enum Undef.* }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Undef' not an Enum type.`

### InvalidSimple\domain-enum-undef-member.graphql+

```gqlp
domain Test { enum Enum.undef }
enum Enum { value }
```

##### Expected Verify errors

- `Invalid Domain Enum Value. 'undef' not a Value of 'Enum'.`

### InvalidSimple\domain-enum-undef-value.graphql+

```gqlp
domain Test { enum Undef.value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Undef' not an Enum type.`

### InvalidSimple\domain-enum-undef.graphql+

```gqlp
domain Test { enum undef }
```

##### Expected Verify errors

- `Invalid Domain Enum Member. Enum Value 'undef' not defined.`

### InvalidSimple\domain-enum-unique-all.graphql+

```gqlp
domain Test { enum Enum.* Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup.`

### InvalidSimple\domain-enum-unique-member.graphql+

```gqlp
domain Test { enum Enum.value Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup.`

### InvalidSimple\domain-enum-unique.graphql+

```gqlp
domain Test { enum Enum.value Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup.`

### InvalidSimple\domain-enum-wrong.graphql+

```gqlp
domain Test { enum Bad.value }
output Bad { }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Bad' not an Enum type.`

### InvalidSimple\domain-number-parent.graphql+

```gqlp
domain Test { :Parent number 1> }
domain Parent { number !1> }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items.,`
- `Group of DomainRange for '1 >' is not singular Range['False', 'True']`

### InvalidSimple\domain-parent-self-more.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :More Boolean }
domain More { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via More.,`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test.,`
- `Invalid Domain. 'Recurse' cannot be a child of itself, even recursively via Parent.,`
- `Invalid Domain. 'More' cannot be a child of itself, even recursively via Recurse.`

### InvalidSimple\domain-parent-self-parent.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via Parent.,`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test.`

### InvalidSimple\domain-parent-self-recurse.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via Recurse.,`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test.,`
- `Invalid Domain. 'Recurse' cannot be a child of itself, even recursively via Parent.`

### InvalidSimple\domain-parent-self.graphql+

```gqlp
domain Test { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself.`

### InvalidSimple\domain-parent-undef.graphql+

```gqlp
domain Test { :Parent Boolean }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' not defined.`

### InvalidSimple\domain-parent-wrong-kind.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { String }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' invalid domain. Found 'String'.`

### InvalidSimple\domain-parent-wrong-type.graphql+

```gqlp
domain Test { :Parent Boolean }
output Parent { }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' invalid type. Found 'Output'.`

### InvalidSimple\domain-string-diff.graphql+

```gqlp
domain Test { string /a+/}
domain Test { string !/a+/ }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged.,`
- `Group of DomainRegex for 'a+' is not singular Regex['False', 'True'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidSimple\domain-string-parent.graphql+

```gqlp
domain Test { :Parent string /a+/}
domain Parent { string !/a+/ }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items.,`
- `Group of DomainRegex for 'a+' is not singular Regex['False', 'True']`

### InvalidSimple\enum-dup-alias.graphql+

```gqlp
enum Test [a] { test }
enum Dup [a] { dup }
```

##### Expected Verify errors

- `Multiple Enums with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### InvalidSimple\enum-parent-alias-dup.graphql+

```gqlp
enum Test { :Parent test[alias] }
enum Parent { parent[alias] }
```

##### Expected Verify errors

- `Invalid Enum Child. Can't merge Test into Parent Parent.,`
- `Aliases of EnumItem for 'alias' is not singular Name['parent', 'test']`

### InvalidSimple\enum-parent-diff.graphql+

```gqlp
enum Test { :Parent test }
enum Test { test }
enum Parent { parent }
```

##### Expected Verify errors

- `Multiple Enums with name 'Test' can't be merged.,`
- `Group of Enum for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidSimple\enum-parent-undef.graphql+

```gqlp
enum Test { :Parent test }
```

##### Expected Verify errors

- `Invalid Enum Parent. 'Parent' not defined.`

### InvalidSimple\enum-parent-wrong.graphql+

```gqlp
enum Test { :Parent test }
output Parent { }
```

##### Expected Verify errors

- `Invalid Enum Parent. 'Parent' invalid type. Found 'Output'.`

### InvalidSimple\union-dup-alias.graphql+

```gqlp
union Test [a] { Bad }
union Dup [a] { Test }
```

##### Expected Verify errors

- `Multiple Unions with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### InvalidSimple\union-more-parent.graphql+

```gqlp
union Test { Recurse }
union Recurse { :Parent }
union Parent { More }
union More { :Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union. Expected at least one member.,`
- `Invalid Union. Expected at least one member.`

### InvalidSimple\union-more.graphql+

```gqlp
union Test { Bad }
union Bad { More }
union More { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively.,`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively.,`
- `Invalid Union Member. 'More' cannot refer to self, even recursively.`

### InvalidSimple\union-parent-diff.graphql+

```gqlp
union Test { :Parent Number }
union Test { Number }
union Parent { String }
```

##### Expected Verify errors

- `Multiple Unions with name 'Test' can't be merged.,`
- `Group of Union for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Types with name 'Test' can't be merged.`

### InvalidSimple\union-parent-more.graphql+

```gqlp
union Test { :Parent String }
union Parent { More }
union More { :Bad String }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union. Expected at least one member.,`
- `Invalid Union. Expected at least one member.`

### InvalidSimple\union-parent-recurse.graphql+

```gqlp
union Test { :Parent String }
union Parent { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union. Expected at least one member.`

### InvalidSimple\union-parent-undef.graphql+

```gqlp
union Test { :Parent Number }
```

##### Expected Verify errors

- `Invalid Union Parent. 'Parent' not defined.`

### InvalidSimple\union-parent-wrong.graphql+

```gqlp
union Test { :Parent Number }
output Parent { }
```

##### Expected Verify errors

- `Invalid Union Parent. 'Parent' invalid type. Found 'Output'.`

### InvalidSimple\union-parent.graphql+

```gqlp
union Test { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `Invalid Union. Expected at least one member.`

### InvalidSimple\union-recurse-parent.graphql+

```gqlp
union Test { Bad }
union Bad { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `Invalid Union. Expected at least one member.`

### InvalidSimple\union-recurse.graphql+

```gqlp
union Test { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively.,`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively.`

### InvalidSimple\union-self.graphql+

```gqlp
union Test { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self.`

### InvalidSimple\union-undef.graphql+

```gqlp
union Test { Bad }
```

##### Expected Verify errors

- `Invalid Union. 'Bad' not defined.`

### InvalidSimple\union-wrong.graphql+

```gqlp
union Test { Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid union. Type kind mismatch for Bad. Found Input.`

### InvalidSimple\unique-type-alias.graphql+

```gqlp
enum Test [a] { Value }
output Dup [a] { }
```

##### Expected Verify errors

- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### InvalidSimple\unique-types.graphql+

```gqlp
enum Test { Value }
output Test { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged.,`
- `Group of Type for 'Test' is not singular Type['Enum', 'Output']`

## ValidGlobals

### ValidGlobals\category-output-dict.graphql+

```gqlp
category { CatDict[*] }
output CatDict { }
```

### ValidGlobals\category-output-list.graphql+

```gqlp
category { CatList[] }
output CatList { }
```

### ValidGlobals\category-output-optional.graphql+

```gqlp
category { CatOpt? }
output CatOpt { }
```

### ValidGlobals\category-output.graphql+

```gqlp
category { Cat }
output Cat { }
```

### ValidGlobals\description-backslash.graphql+

```gqlp
'A backslash ("\\") description'
output DescrBackslash { }
```

### ValidGlobals\description-between.graphql+

```gqlp
category { DescrBetween }
"A description between"
output DescrBetween { }
```

### ValidGlobals\description-complex.graphql+

```gqlp
"A \"more\" 'Complicated' \\ description"
output DescrComplex { }
```

### ValidGlobals\description-double.graphql+

```gqlp
"A 'double-quoted' description"
output DescrDouble { }
```

### ValidGlobals\description-single.graphql+

```gqlp
'A "single-quoted" description'
output DescrSingle { }
```

### ValidGlobals\description.graphql+

```gqlp
"A simple description"
output Descr { }
```

### ValidGlobals\directive-param-dict.graphql+

```gqlp
directive @DirParamDict(DirParamIn[String]) { all }
input DirParamIn { }
```

### ValidGlobals\directive-param-in.graphql+

```gqlp
directive @DirParam(DirParamIn) { all }
input DirParamIn { }
```

### ValidGlobals\directive-param-list.graphql+

```gqlp
directive @DirParamList(DirParamIn[]) { all }
input DirParamIn { }
```

### ValidGlobals\directive-param-opt.graphql+

```gqlp
directive @DirParamOpt(DirParamIn?) { all }
input DirParamIn { }
```

### ValidGlobals\option-setting.graphql+

```gqlp
option Schema { setting = true }
```

## ValidMerges

### ValidMerges\category-alias.graphql+

```gqlp
category [CatA1] { CatAlias }
category [CatA2] { CatAlias }
output CatAlias { }
```

### ValidMerges\category-mod.graphql+

```gqlp
category [CatM1] { CatMods? }
category [CatM2] { CatMods? }
output CatMods { }
```

### ValidMerges\category.graphql+

```gqlp
category { Category }
category category { Category }
output Category { }
```

### ValidMerges\directive-alias.graphql+

```gqlp
directive @DirAlias [DirA1] { variable }
directive @DirAlias [DirA2] { field }
```

### ValidMerges\directive-param.graphql+

```gqlp
directive @DirParam(DirParamIn) { operation }
directive @DirParam { fragment }
input DirParamIn { }
```

### ValidMerges\directive.graphql+

```gqlp
directive @Dir { inline }
directive @Dir { spread }
```

### ValidMerges\domain-alias.graphql+

```gqlp
domain NumAlias [Num1] { number }
domain NumAlias [Num2] { number }
```

### ValidMerges\domain-boolean-diff.graphql+

```gqlp
domain BoolDiff { boolean true }
domain BoolDiff { boolean false }
```

### ValidMerges\domain-boolean-same.graphql+

```gqlp
domain BoolSame { boolean true }
domain BoolSame { boolean true }
```

### ValidMerges\domain-boolean.graphql+

```gqlp
domain Bool { boolean }
domain Bool { boolean }
```

### ValidMerges\domain-enum-diff.graphql+

```gqlp
domain EnumDiff { enum true }
domain EnumDiff { enum false }
```

### ValidMerges\domain-enum-same.graphql+

```gqlp
domain EnumSame { enum true }
domain EnumSame { enum true }
```

### ValidMerges\domain-number-diff.graphql+

```gqlp
domain NumDiff { number 1~9 }
domain NumDiff { number }
```

### ValidMerges\domain-number-same.graphql+

```gqlp
domain NumSame { number 1~9 }
domain NumSame { number 1~9 }
```

### ValidMerges\domain-number.graphql+

```gqlp
domain Num { number }
domain Num { number }
```

### ValidMerges\domain-string-diff.graphql+

```gqlp
domain StrDiff { string /a+/ }
domain StrDiff { string }
```

### ValidMerges\domain-string-same.graphql+

```gqlp
domain StrSame { string /a+/ }
domain StrSame { string /a+/ }
```

### ValidMerges\domain-string.graphql+

```gqlp
domain Str { string }
domain Str { string }
```

### ValidMerges\enum-alias.graphql+

```gqlp
enum EnAlias [En1] { alias }
enum EnAlias [En2] { alias }
```

### ValidMerges\enum-diff.graphql+

```gqlp
enum EnDiff { one }
enum EnDiff { two }
```

### ValidMerges\enum-same-parent.graphql+

```gqlp
enum EnSameParent { :EnParent sameP }
enum EnSameParent { :EnParent sameP }
enum EnParent { parent }
```

### ValidMerges\enum-same.graphql+

```gqlp
enum EnSame { same }
enum EnSame { same }
```

### ValidMerges\enum-value-alias.graphql+

```gqlp
enum EnValAlias { value [val1] }
enum EnValAlias { value [val2] }
```

### ValidMerges\object-alias.graphql+

```gqlp
object ObjName [Obj1] { }
object ObjName [Obj2] { }
```

### ValidMerges\object-alt.graphql+

```gqlp
object ObjName { | ObjNameType }
object ObjName { | ObjNameType }
object ObjNameType { }
```

### ValidMerges\object-field-alias.graphql+

```gqlp
object ObjName { field [field1]: ObjNameFld }
object ObjName { field [field2]: ObjNameFld }
object ObjNameFld { }
```

### ValidMerges\object-field.graphql+

```gqlp
object ObjName { field: ObjNameFld }
object ObjName { field: ObjNameFld }
object ObjNameFld { }
```

### ValidMerges\object-param.graphql+

```gqlp
object ObjName<$test> { test: $test }
object ObjName<$type> { type: $type }
```

### ValidMerges\object-parent.graphql+

```gqlp
object ObjName { :ObjNameRef }
object ObjName { :ObjNameRef }
object ObjNameRef { }
```

### ValidMerges\object.graphql+

```gqlp
object ObjName { }
object ObjName { }
```

### ValidMerges\option-alias.graphql+

```gqlp
option Schema [Opt1] { }
option Schema [Opt2] { }
```

### ValidMerges\option-value.graphql+

```gqlp
option Schema { setting=true }
option Schema { setting=[0] }
```

### ValidMerges\option.graphql+

```gqlp
option Schema { }
option Schema { }
```

### ValidMerges\output-field-enum-alias.graphql+

```gqlp
output FieldEnumAlias { field [field1] = Boolean.true }
output FieldEnumAlias { field [field2] = true }
```

### ValidMerges\output-field-enum-value.graphql+

```gqlp
output FieldEnums { field = Boolean.true }
output FieldEnums { field = true }
```

### ValidMerges\output-field-param.graphql+

```gqlp
output FieldParam { field(FieldParam1): FieldParamFld }
output FieldParam { field(FieldParam2): FieldParamFld }
input FieldParam1 { }
input FieldParam2 { }
output FieldParamFld { }
```

### ValidMerges\union-alias.graphql+

```gqlp
union UnDiff [UnA1] { Boolean }
union UnDiff [UnA2] { Number }
```

### ValidMerges\union-diff.graphql+

```gqlp
union UnDiff { Boolean }
union UnDiff { Number }
```

### ValidMerges\union-same-parent.graphql+

```gqlp
union UnSameParent { :UnParent Boolean }
union UnSameParent { :UnParent Boolean }
union UnParent { String }
```

### ValidMerges\union-same.graphql+

```gqlp
union UnSame { Boolean }
union UnSame { Boolean }
```

## ValidObjects

### ValidObjects\alt-dual.graphql+

```gqlp
object ObjName { | ObjDualName }
dual ObjDualName { alt: Number | String }
```

### ValidObjects\alt-mod-Boolean.graphql+

```gqlp
object ObjName { | ObjNameAlt[^] }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\alt-mod-param.graphql+

```gqlp
object ObjName<$mod> { | ObjNameAlt[$mod] }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\alt-simple.graphql+

```gqlp
object ObjName { | String }
```

### ValidObjects\alt.graphql+

```gqlp
object ObjName { | ObjNameAlt }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\field-dual.graphql+

```gqlp
object ObjName { field: ObjNameFld }
dual ObjNameFld { field: Number | String }
```

### ValidObjects\field-mod-Enum.graphql+

```gqlp
object ObjName { field: *[ObjEnumName] }
enum ObjEnumName { value }
```

### ValidObjects\field-mod-param.graphql+

```gqlp
object ObjName<$mod> { field: ObjNameFld[$mod] }
object ObjNameFld { field: Number | String }
```

### ValidObjects\field-object.graphql+

```gqlp
object ObjName { field: ObjNameFld }
object ObjNameFld { field: Number | String }
```

### ValidObjects\field-simple.graphql+

```gqlp
object ObjName { field: Number }
```

### ValidObjects\field.graphql+

```gqlp
object ObjName { field: * }
```

### ValidObjects\generic-alt-arg.graphql+

```gqlp
object ObjName<$type> { | ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-alt-dual.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-alt-param.graphql+

```gqlp
object ObjName { | ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-alt-simple.graphql+

```gqlp
object ObjName { | ObjNameRef<String> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-alt.graphql+

```gqlp
object ObjName<$type> { | $type }
```

### ValidObjects\generic-dual.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-field-arg.graphql+

```gqlp
object ObjName<$type> { field: ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-field-dual.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-field-param.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-field.graphql+

```gqlp
object ObjName<$type> { field: $type }
```

### ValidObjects\generic-param.graphql+

```gqlp
object ObjName { field: ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-arg.graphql+

```gqlp
object ObjName<$type> { :ObjNameRef<$type> }
object ObjNameRef<$ref> { | $ref }
```

### ValidObjects\generic-parent-dual-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-dual.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
dual ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-param-parent.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { :$ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent-param.graphql+

```gqlp
object ObjName { :ObjNameRef<ObjNameAlt> }
object ObjNameRef<$ref> { | $ref }
object ObjNameAlt { alt: Number | String }
```

### ValidObjects\generic-parent.graphql+

```gqlp
object ObjName<$type> { :$type }
```

### ValidObjects\input-field-Enum.graphql+

```gqlp
input InFieldEnum { field: InEnumField = value }
enum InEnumField { value }
```

### ValidObjects\input-field-null.graphql+

```gqlp
input InFieldNull { field: InFieldNull? = null }
```

### ValidObjects\input-field-Number.graphql+

```gqlp
input InFieldNum { field: Number = 0 }
```

### ValidObjects\input-field-String.graphql+

```gqlp
input InFieldStr { field: String = '' }
```

### ValidObjects\output-field-enum-parent.graphql+

```gqlp
output OutFieldParent { field = OutEnumParented.outEnumParent }
enum OutEnumParented { :OutEnumParent outParent ed }
enum OutEnumParent { outEnumParent }
```

### ValidObjects\output-field-enum.graphql+

```gqlp
output OutFieldEnum { field = OutEnumField.outEnumField }
enum OutEnumField { outEnumField }
```

### ValidObjects\output-field-value.graphql+

```gqlp
output OutFieldValue { field = outEnumValue }
enum OutEnumValue { outEnumValue }
```

### ValidObjects\output-generic-enum.graphql+

```gqlp
output OutGenEnum { | OutGenEnumRef<OutEnumGen.outEnumGen> }
output OutGenEnumRef<$type> { field: $type }
enum OutEnumGen { outEnumGen }
```

### ValidObjects\output-generic-value.graphql+

```gqlp
output OutGenValue { | OutGenValueRef<outValueGen> }
output OutGenValueRef<$type> { field: $type }
enum OutValueGen { outValueGen }
```

### ValidObjects\output-param-mod-Domain.graphql+

```gqlp
output OutParamDomain { field(OutParamDomainIn[OutDomainParam]): OutDomainParam }
input OutParamDomainIn { param: Number | String }
domain OutDomainParam { number 1 ~ 10 }
```

### ValidObjects\output-param-mod-param.graphql+

```gqlp
output OutParamDomainParam<$mod> { field(OutParamDomainParamIn[$mod]): OutDomainsParam }
input OutParamDomainParamIn { param: Number | String }
domain OutDomainsParam { number 1 ~ 10 }
```

### ValidObjects\output-param.graphql+

```gqlp
output OutParam { field(OutParamIn): OutParam }
input OutParamIn { param: Number | String }
```

### ValidObjects\output-parent-generic.graphql+

```gqlp
output OutGenParent { | OutGenParentRef<OutParentGen.outGenParent> }
output OutGenParentRef<$type> { field: $type }
enum OutParentGen { :OutPrntendedGen outGenPrntended }
enum OutPrntendedGen { outGenParent }
```

### ValidObjects\output-parent-param.graphql+

```gqlp
output OutPrntParam { :OutParamParent field(OutPrntParamIn): OutPrntParam }
output OutParamParent { field(OutParamParentIn): OutPrntParam }
input OutPrntParamIn { param: Number | String }
input OutParamParentIn { parent: Number | String }
```

### ValidObjects\parent-alt.graphql+

```gqlp
object ObjName { :ObjNameRef | Number }
object ObjNameRef {  parent: Number | String }
```

### ValidObjects\parent-dual.graphql+

```gqlp
object ObjName { :ObjNameRef }
dual ObjNameRef { parent: Number | String }
```

### ValidObjects\parent-field.graphql+

```gqlp
object ObjName { :ObjNameRef field: Number }
object ObjNameRef { parent: Number | String }
```

### ValidObjects\parent-param-diff.graphql+

```gqlp
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$b> { | $b }
```

### ValidObjects\parent-param-same.graphql+

```gqlp
object ObjName<$a> { :ObjNameRef<$a> field: $a }
object ObjNameRef<$a> { | $a }
```

### ValidObjects\parent.graphql+

```gqlp
object ObjName { :ObjNameRef }
object ObjNameRef { parent: Number | String }
```

## ValidSimple

### ValidSimple\domain-enum-all-parent.graphql+

```gqlp
domain DomEnumAllParent { enum EnumDomAllParent.* }
enum EnumDomAllParent { :EnumDomParentAll dom_all_parent }
enum EnumDomParentAll { dom_enum_all_parent }
```

### ValidSimple\domain-enum-all.graphql+

```gqlp
domain DomEnumAll { enum EnumDomAll.* }
enum EnumDomAll { dom_all dom_enum_all }
```

### ValidSimple\domain-enum-member.graphql+

```gqlp
domain DomMember { enum dom_member }
enum MemberDom { dom_member }
```

### ValidSimple\domain-enum-parent.graphql+

```gqlp
domain DomEnumPrnt { :DomPrntEnum Enum both_enum }
domain DomPrntEnum { Enum both_parent }
enum EnumDomBoth { both_enum both_parent }
```

### ValidSimple\domain-enum-unique-parent.graphql+

```gqlp
enum EnumDomUniqueParent { :EnumDomParentUnique value }
enum EnumDomParentUnique { enum_dom_parent_dup }
enum EnumDomDupParent { enum_dom_parent_dup }
# domain DomEnumUniqueParent { enum EnumDomUniqueParent.* !EnumDomUniqueParent.enum_dom_parent_dup EnumDomDupParent.enum_dom_parent_dup }
```

### ValidSimple\domain-enum-unique.graphql+

```gqlp
enum EnumDomUnique { eum_dom_value eum_dom_dup }
enum EnumDomDup { eum_dom_dup }
# domain DomEnumUnique { enum EnumDomUnique.* !EnumDomUnique.eum_dom_dup EnumDomDup.eum_dom_dup }
```

### ValidSimple\domain-enum-value-parent.graphql+

```gqlp
domain DomEnumParent { Enum EnumDomParent.dom_enum_parent }
enum EnumDomParent { :EnumParentDom dom_parent_enum }
enum EnumParentDom { dom_enum_parent }
```

### ValidSimple\domain-enum-value.graphql+

```gqlp
domain DomEnum { Enum EnumDom.dom_enum }
enum EnumDom { dom_enum }
```

### ValidSimple\domain-number-parent.graphql+

```gqlp
domain DomNumPrnt { :DomPrntNum Number 2>}
domain DomPrntNum { Number <2 }
```

### ValidSimple\domain-parent.graphql+

```gqlp
domain DomPrntTest { :DomTestPrnt Boolean false }
domain DomTestPrnt { Boolean true }
```

### ValidSimple\domain-string-parent.graphql+

```gqlp
domain DomStrPrnt { :DomPrntStr String /a+/ }
domain DomPrntStr { String /b+/ }
```

### ValidSimple\enum-parent-alias.graphql+

```gqlp
enum EnPrntAlias { :EnAliasPrnt val_prnt_alias val_alias[alias_val] }
enum EnAliasPrnt { val_alias }
```

### ValidSimple\enum-parent-dup.graphql+

```gqlp
enum EnPrntDup { :EnDupPrnt val_prnt_dup  }
enum EnDupPrnt { val_dup[val_prnt_dup] }
```

### ValidSimple\enum-parent.graphql+

```gqlp
enum EnTestPrnt { :EnPrntTest val_prnt }
enum EnPrntTest { val_test }
```

### ValidSimple\union-parent-dup.graphql+

```gqlp
union UnionPrnt { :PrntUnion Number }
union PrntUnion { Number }
```

### ValidSimple\union-parent.graphql+

```gqlp
union UnionPrnt { :PrntUnion String }
union PrntUnion { Number }
```
