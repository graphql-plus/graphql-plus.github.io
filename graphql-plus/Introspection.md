# Schema Introspection

The `_Schema` output type is automatically defined as followed and can be used to allow introspection either through a Category or an Output field.

## Schema

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[Identifier]
        directives(_Filter?): _Directives[Identifier]
        types(_TypeFilter?): _Type[Identifier]
        settings(_Filter?): _Setting[Identifier]
    }

scalar Identifier { String /[A-Za-z_]+/ }

input _Filter  {
        names: String[]
        includeReferencedTypes: Boolean = false
    | "Names" String[]
    }

input _CategoryFilter {
    : _Filter
        resolutions: _Resolution[]
    }

input _TypeFilter {
    : _Filter
        kinds: _TypeKind[]
    }

dual _Aliased {
    : _Described<_Named>
        aliases: Identifier[]
    }

dual _Described<$base> {
    : $base
        description: String?
    }

dual _Named {
        name: Identifier
    }
```

## Category

```gqlp
dual _Categories {
    | _Category
    | _Type
}

dual _Category {
    : _Aliased
        resolution: _Resolution
        output: _TypeRef<_TypeKind.Output>
        modifiers: _Modifiers[]
    }

enum _Resolution { Parallel Sequential Single }
```

## Directive

```gqlp
dual _Directives {
    | _Directive
    | _Type
}

dual _Directive {
    : _Aliased
        parameters: _Parameter[]
        repeatable: Boolean
        locations: _[_Location]
    }

enum _Location { Operation Variable Field Inline Spread Fragment }

```

## Setting

```gqlp
dual _Setting {
    : _Described<_Named>
        value: _Constant
}
```

## Types

```gqlp
dual _Type {
    | _BaseType<_TypeKind.Basic>
    | _BaseType<_TypeKind.Internal>
    | _ParentType<_TypeKind.Dual _DualBase _Field<_DualBase>>
    | _ParentType<_TypeKind.Enum _Aliased _EnumMember>
    | _TypeObject<_TypeKind.Input _InputBase _InputField>
    | _TypeObject<_TypeKind.Output _OutputBase _OutputField>
    | _TypeScalar
    | _ParentType<_TypeKind.Union _Named _UnionMember>
    }

dual _BaseType<$kind> {
    : _Aliased
        kind: $kind
    }

dual _ChildType<$kind $parent> {
    : _BaseType<$kind>
        parent: $parent
    }

dual _ParentType<$kind $item $allItem> {
    : _ChildType<$kind Identifier>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Scalar Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

dual _TypeRef<$kind> {
        kind: $kind
        name: Identifier
}

dual _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Scalar>
    | _TypeRef<_TypeKind.Union>
    }
```

## Common

```gqlp
dual _Constant {
    | _Simple
    | _ConstantList
    | _ConstantMap
    }

dual _Simple {
    | Boolean
    | _ScalarValue<_ScalarDomain.Number Number>
    | _ScalarValue<_ScalarDomain.String String>
    | _EnumValue
}

dual _ConstantList {
    | _Constant[]
    }

dual _ConstantMap {
    | _Constant[Simple]
    }

dual _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierDictionary
    }

dual _ModifierDictionary {
    : _Modifier<_ModifierKind.Dictionary>
        by: _TypeSimple
        optional: Boolean
    }

dual _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Optional List Dictionary }

dual _Modifier<$kind> {
        kind: $kind
    }
```

## Enum

```gqlp
dual _EnumMember {
    : _Aliased
        enum: Identifier
    }

dual _EnumValue {
    : _TypeRef<_TypeKind.Enum>
        value: Identifier
    }
```

## Scalar

```gqlp
enum _ScalarDomain { Boolean Enum Number String Union }

dual _TypeScalar {
    | _BaseScalar<_ScalarDomain.Boolean _ScalarTrueFalse>
    | _BaseScalar<_ScalarDomain.Enum _ScalarMember>
    | _BaseScalar<_ScalarDomain.Number _ScalarRange>
    | _BaseScalar<_ScalarDomain.String _ScalarRegex>
    }

dual _ScalarRef<$kind> {
    : _TypeRef<_TypeKind.Scalar>
        scalar: $kind
    }

dual _BaseScalar<$kind $item> {
    : _ParentType<_TypeKind.Scalar $item _ScalarItem<$item>>
        scalar: $kind
    }

dual _BaseScalarItem {
        exclude: Boolean
    }

dual _ScalarTrueFalse {
    : _BaseScalarItem
        value: Boolean
    }

dual _ScalarMember {
    : _BaseScalarItem
        member: _EnumValue
    }

dual _ScalarRange {
    : _BaseScalarItem
        from: Number?
        to: Number?
    }

dual _ScalarRegex {
    : _BaseScalarItem
        regex: String
    }

dual _ScalarItem<$item> {
    : $item
        scalar: Identifier
    }

dual _ScalarValue<$kind $value> {
    : _ScalarRef<$kind>
        value: $value
    }
```

## Union

```gqlp
dual _UnionMember {
    : _Named
        union: Identifier
    }
```

## Object

```gqlp
dual _TypeObject<$kind $base $field> {
    : _ChildType<$kind _Described<$base>>
        typeParameters: _Described<_Named>[]
        fields: $field[]
        alternates: _Alternate<$base>[]
        allFields: _Object<$field>[]
        allAlternates: _Object<_Alternate<$base>>[]
    }

dual _ObjRef<$base> {
    | _BaseType<_TypeKind.Internal>
    | _TypeSimple
    | $base
    }

dual _ObjBase<$arg> {
        arguments: $arg[]
    | "TypeParameter" Identifier
    }

dual _Alternate<$base> {
      type: _Described<_ObjRef<$base>>
      collections: _Collections[]
    }

dual _Object<$for> {
    : $for
        object: Identifier
    }

dual _Field<$base> {
    : _Aliased
      type: _Described<_ObjRef<$base>>
      modifiers: _Modifiers[]
    }

dual _Parameter {
    : _Alternate<_InputBase>
        default: _Constant?
    }
```

## Dual

```gqlp
dual _DualBase {
    : _ObjBase<_ObjRef<_DualBase>>
        dual: Identifier
    }
```

## Input

```gqlp
dual _InputBase {
    : _ObjBase<_ObjRef<_InputBase>>
        input: Identifier
    }

dual _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }
```

## Output

```gqlp
dual _OutputBase {
    : _ObjBase<_OutputArgument>
        output: Identifier
    }

dual _OutputField {
    : _Field<_OutputBase>
        parameter: _Parameter[]
    | _OutputEnum
    }

dual _OutputArgument {
    : _TypeRef<_TypeKind.Enum>
        value: Identifier
    | _ObjRef<_OutputBase>
    }

dual _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: Identifier
        value: Identifier
    }
```

## Complete Definition

```gqlp
output _Schema {
    : _Named
        categories(_CategoryFilter?): _Categories[Identifier]
        directives(_Filter?): _Directives[Identifier]
        types(_TypeFilter?): _Type[Identifier]
        settings(_Filter?): _Setting[Identifier]
    }

scalar Identifier { String /[A-Za-z_]+/ }

input _Filter  {
        names: String[]
        includeReferencedTypes: Boolean = false
    | "Names" String[]
    }

input _CategoryFilter {
    : _Filter
        resolutions: _Resolution[]
    }

input _TypeFilter {
    : _Filter
        kinds: _TypeKind[]
    }

dual _Aliased {
    : _Described<_Named>
        aliases: Identifier[]
    }

dual _Described<$base> {
    : $base
        description: String?
    }

dual _Named {
        name: Identifier
    }

dual _Categories {
    | _Category
    | _Type
}

dual _Category {
    : _Aliased
        resolution: _Resolution
        output: _TypeRef<_TypeKind.Output>
        modifiers: _Modifiers[]
    }

enum _Resolution { Parallel Sequential Single }

dual _Directives {
    | _Directive
    | _Type
}

dual _Directive {
    : _Aliased
        parameters: _Parameter[]
        repeatable: Boolean
        locations: _[_Location]
    }

enum _Location { Operation Variable Field Inline Spread Fragment }


dual _Setting {
    : _Described<_Named>
        value: _Constant
}

dual _Type {
    | _BaseType<_TypeKind.Basic>
    | _BaseType<_TypeKind.Internal>
    | _ParentType<_TypeKind.Dual _DualBase _Field<_DualBase>>
    | _ParentType<_TypeKind.Enum _Aliased _EnumMember>
    | _TypeObject<_TypeKind.Input _InputBase _InputField>
    | _TypeObject<_TypeKind.Output _OutputBase _OutputField>
    | _TypeScalar
    | _ParentType<_TypeKind.Union _Named _UnionMember>
    }

dual _BaseType<$kind> {
    : _Aliased
        kind: $kind
    }

dual _ChildType<$kind $parent> {
    : _BaseType<$kind>
        parent: $parent
    }

dual _ParentType<$kind $item $allItem> {
    : _ChildType<$kind Identifier>
        items: $item[]
        allItems: $allItem[]
    }

enum _SimpleKind { Basic Enum Internal Scalar Union }

enum _TypeKind { :_SimpleKind Dual Input Output }

dual _TypeRef<$kind> {
        kind: $kind
        name: Identifier
}

dual _TypeSimple {
    | _TypeRef<_TypeKind.Basic>
    | _TypeRef<_TypeKind.Enum>
    | _TypeRef<_TypeKind.Scalar>
    | _TypeRef<_TypeKind.Union>
    }

dual _Constant {
    | _Simple
    | _ConstantList
    | _ConstantMap
    }

dual _Simple {
    | Boolean
    | _ScalarValue<_ScalarDomain.Number Number>
    | _ScalarValue<_ScalarDomain.String String>
    | _EnumValue
}

dual _ConstantList {
    | _Constant[]
    }

dual _ConstantMap {
    | _Constant[Simple]
    }

dual _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierDictionary
    }

dual _ModifierDictionary {
    : _Modifier<_ModifierKind.Dictionary>
        by: _TypeSimple
        optional: Boolean
    }

dual _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Optional List Dictionary }

dual _Modifier<$kind> {
        kind: $kind
    }

dual _EnumMember {
    : _Aliased
        enum: Identifier
    }

dual _EnumValue {
    : _TypeRef<_TypeKind.Enum>
        value: Identifier
    }

enum _ScalarDomain { Boolean Enum Number String Union }

dual _TypeScalar {
    | _BaseScalar<_ScalarDomain.Boolean _ScalarTrueFalse>
    | _BaseScalar<_ScalarDomain.Enum _ScalarMember>
    | _BaseScalar<_ScalarDomain.Number _ScalarRange>
    | _BaseScalar<_ScalarDomain.String _ScalarRegex>
    }

dual _ScalarRef<$kind> {
    : _TypeRef<_TypeKind.Scalar>
        scalar: $kind
    }

dual _BaseScalar<$kind $item> {
    : _ParentType<_TypeKind.Scalar $item _ScalarItem<$item>>
        scalar: $kind
    }

dual _BaseScalarItem {
        exclude: Boolean
    }

dual _ScalarTrueFalse {
    : _BaseScalarItem
        value: Boolean
    }

dual _ScalarMember {
    : _BaseScalarItem
        member: _EnumValue
    }

dual _ScalarRange {
    : _BaseScalarItem
        from: Number?
        to: Number?
    }

dual _ScalarRegex {
    : _BaseScalarItem
        regex: String
    }

dual _ScalarItem<$item> {
    : $item
        scalar: Identifier
    }

dual _ScalarValue<$kind $value> {
    : _ScalarRef<$kind>
        value: $value
    }

dual _UnionMember {
    : _Named
        union: Identifier
    }

dual _TypeObject<$kind $base $field> {
    : _ChildType<$kind _Described<$base>>
        typeParameters: _Described<_Named>[]
        fields: $field[]
        alternates: _Alternate<$base>[]
        allFields: _Object<$field>[]
        allAlternates: _Object<_Alternate<$base>>[]
    }

dual _ObjRef<$base> {
    | _BaseType<_TypeKind.Internal>
    | _TypeSimple
    | $base
    }

dual _ObjBase<$arg> {
        arguments: $arg[]
    | "TypeParameter" Identifier
    }

dual _Alternate<$base> {
      type: _Described<_ObjRef<$base>>
      collections: _Collections[]
    }

dual _Object<$for> {
    : $for
        object: Identifier
    }

dual _Field<$base> {
    : _Aliased
      type: _Described<_ObjRef<$base>>
      modifiers: _Modifiers[]
    }

dual _Parameter {
    : _Alternate<_InputBase>
        default: _Constant?
    }

dual _DualBase {
    : _ObjBase<_ObjRef<_DualBase>>
        dual: Identifier
    }

dual _InputBase {
    : _ObjBase<_ObjRef<_InputBase>>
        input: Identifier
    }

dual _InputField {
    : _Field<_InputBase>
        default: _Constant?
    }

dual _OutputBase {
    : _ObjBase<_OutputArgument>
        output: Identifier
    }

dual _OutputField {
    : _Field<_OutputBase>
        parameter: _Parameter[]
    | _OutputEnum
    }

dual _OutputArgument {
    : _TypeRef<_TypeKind.Enum>
        value: Identifier
    | _ObjRef<_OutputBase>
    }

dual _OutputEnum {
    : _TypeRef<_TypeKind.Enum>
        field: Identifier
        value: Identifier
    }

```
