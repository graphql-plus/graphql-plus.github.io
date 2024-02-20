# Schema language definition

> See [Definition](Definition.md) on how to read the definitions below.
>
> Including PEG definitions for Common and Constant terms.

## Schema

```PEG
Schema = Declaration+

Declaration = STRING? ( Category | Directive | Option | Type )
Type = Enum | Input | Output | Scalar

Aliases = '[' alias+ ']'
```

A Schema is one (or more) Declarations. Each declaration can be preceded by a documentation string.

Declarations have the following general form:

> `label name Parameters? Aliases? '{' ( '(' Option ')' )? Definition '}'`

Declarations are matched by label and name.
When merging Declarations, Options and Definitions will also be merged.

The following declarations are implied but can be specified explicitly:

- `category { Query }` and thus `output Query { }`
- `category { (sequential) Mutation }` and thus `output Mutation { }`
- `category { (single) Subscription }` and thus `output Subscription { }`
- `output _Schema { ... }` (see [Introspection](Introspection.md))

### Names and Aliases

Names beginning with an underscore (`_`) are reserved and such items are considered system items.

Within any list of named items, after merging all names must be unique.

Many named items can also have Aliases, which are a list of alternate ids for a given item.

Within any list of named items with Aliases, after merging all Aliases must be unique.
Any conflicts between names and Aliases will be resolved in the favour of the name,
ie. Any Aliases in a list of items that match any of the item's names will simply be removed.

### Merging (and De-duplicating)

Some item lists can be merged and thus de-duplicated.

Merging two (or more) lists will be done by some matching criteria.
If the items are named the default matching criteria is their names.

Unless otherwise specified, items are merged as follows:

- List components of any matching items will be merged. If a list component can't be merged, then the items can't be merged.
- Other (ie, not lists or part of the matching criteria) required components of any matching items must be the same.
- Optional components, if present, must be the same.
- If only present on some items before merging, optional components will be retained on the merged item.

De-duplicating two (or more) lists will be done by the matching criteria.
As order is significant in most lists, the first item of any duplicates will be kept, possibly updated by any merging.

It is an error if merging of duplicate items is not possible.

## Category declaration

```PEG
Category = 'category' category? Aliases? '{' ( '(' Cat_Option ')' )? output Modifiers? '}'
Cat_Option = 'parallel' | 'sequential' | 'single'
```

A Category is a set of fields defined by an Output type with zero or more Modifiers.
A Category's output type must not be a Generic type.

A Category's name defaults to the Output type name with the first character changed to lowercase.

By default an operation over a Category can specify multiple fields that are resolved in parallel
but this can be changed with the following Category Options:

| Option       | Description                                                                                     |
| ------------ | ----------------------------------------------------------------------------------------------- |
| `parallel`   | Multiple fields specified in an operation of this category will be resolved asynchronously.     |
| `sequential` | Multiple fields specified in an operation of this category will be resolved in the order given. |
| `single`     | One and only one field can be specified in an operation of this category.                       |

Categories can be merged if their Options and Modified Output Types match.

## Directive declaration

```PEG
Directive = 'directive' '@'directive InputParameters? Aliases? '{' Dir_Option? Dir_Location+ '}'
Dir_Option = '(' 'repeatable' ')'
Dir_Location = 'Operation' | 'Variable' | 'Field' | 'Inline' | 'Spread' | 'Fragment'
```

A Directive is defined with a set of Locations where it may appear in an Operation.
A Directive may have Input Parameters.

By default a Directive can only appear once at any Location, but this can be changed with the `repeatable` Directive option.

Directives can be merged if their Options match.

Locations will be merged by value.

## Option declaration

```PEG
Option = 'option' name Aliases? '{' Opt_Setting* '}'
Opt_Setting = STRING? setting Default
```

An Option defines valid options for the Schema as a whole, including the Schema name and Aliases.
A Schema must have only one name.

Option Settings are merged by name and values are merged in the same way as Constant Object values.

## Type declarations

Most declarations define a Type. A Type's Kind is defined as their Declaration label.

The names and Aliases of all Types must be unique across all kinds of Types within the Schema.
Merging of Types is only possible if their Kinds match.

All Types may specify another Type of the same Kind that they extend.
Child (Extending) Types merge in the definition of their Parent (Extended) Type.
A Type cannot extend itself, even recursively.

```PEG
Parent = ':' parent
```

### Built-In types

```PEG
Internal_ReDef = 'Null' | 'null' | 'Object' | '%' | 'Void' // Redefined Internal

Simple_ReDef = Basic | scalar | enum  // Redefined Simple
```

The above types from [Definition](Definition.md) are redefined for Schemas

<details>
<summary>Built-In types</summary>

<i>The following GraphQlPlus isn't strictly valid but ...</i>

Boolean, Null, Unit and Void are effectively enum types as follows:

```gqlp
enum Boolean [bool, ^] { true false }

enum Null [null] { null }

enum Unit [_] { _ }

enum Void { }  // no valid value
```

Number and String are effectively scalar types as follows:

```gqlp
scalar Number [int, 0] { Number }

scalar String [str, *] { String }
```

Object is a general Dictionary as follows:

```gqlp
"%"
input|output _Object [Object, obj, %] { :_Map<Any> } // recursive

input|output _Most<$T> [Most] { $T | Object | _Most<$T>? | _Most<$T>[] | _Most<$T>[Simple] | _Most<$T>[Simple?] } // recursive! not in _Input or _Output

input _Any [Any] { :_Most<_Input> } // not in _Input
output _Any [Any] { :_Most<_Output> } // not in _Output
scalar _Any [Any] { Union | Basic | Internal | _Enum | _Scalar } // not in _Scalar
```

The internal types `_Scalar [Scalar]`, `_Output [Output]`, `_Input [Input]` and `_Enum [Enum]` are automatically defined to be a union of all user defined Scalar, Output, Input and Enum types respectively, as follows:

```gqlp
scalar _Scalar [Scalar] { Union } // All user defined Scalar types
scalar _Enum [Enum] { Union } // All user defined Enum types
input _Input [Input] { } // All user defined Input types
output _Output [Output] { } // All user defined Output types
```

</details>

## Enum type

```PEG
Enum = 'enum' enum Aliases? '{' Parent? En_Member+ '}'
En_Member = STRING? member Aliases?
```

An Enum is a Type defined with one or more Members.

Each Member can be preceded by a documentation string and may have one or more Aliases.

Enums can be merged if their Parents, including lack thereof, match.

## Scalar type

Scalar type definitions are of the following general form:

> `Kind Parent? Item*`

```PEG
Scalar = 'scalar' scalar Aliases? '{' Parent? ScalarDefinition '}'
ScalarDefinition = Scal_Boolean | Scal_Enum | Scal_Number | Scal_String | Scal_Union

Scal_Boolean = 'Boolean' Scal_TrueFalse*
Scal_Enum = 'Enum' Scal_Member*
Scal_Number = 'Number' Scal_Num*
Scal_String = 'String' Scal_Regex*
Scal_Union = 'Union' Scal_Reference+

Scal_TrueFalse = '!'? Boolean
Scal_Member = '!'? EnumValue | enum '.' '*'
Scal_Num = '!'? Scal_NumRange
Scal_NumRange = '<' NUMBER | NUMBER ( '~' NUMBER )? | NUMBER '>'
Scal_Regex = '!'? REGEX
Scal_Reference = '|' Simple
```

Scalar types define specific domains of the following Sorts, each with different Item definitions:

> Boolean, Enum, Number, String, Union

Item exclusions (where defined) take precedence over inclusions.

Scalar declarations can be merged if their Sorts and Parents match.

### Boolean scalar

Comprises only those Boolean values explicitly included (or excluded).
If no included or excluded values are specified, a Boolean scalar includes both values, ie. true and false.

Boolean values can only be merged if their inclusion/exclusion matches.

### Enum scalar

Comprises only those enum Values explicitly included (or excluded).

All enum Members of an enum Type can also be included.

Enum Values can be merged if their Type and inclusion/exclusion matches.
Enum scalars must contain only unique Members after merging, irrelevant of the enum Type the Member is defined for.

### Number scalar

Comprises only those numbers included in (or excluded from) a given Range or specific value.

A Range may specify either or both of its upper or lower bounds and is inclusive of those bounds.

Ranges are merged by their bounds, but can only be merged if their inclusion/exclusion matches.

### String scalar

Comprises only those strings that match (or don't match) one or more Regular expressions.

Regular expressions can only be merged if their inclusion/exclusion matches.

### Union scalar

Comprises one or more Simple types.

A Scalar Union must not include itself, even recursively.

## Object types

Input and Output types are both Object types.

```PEG
// base definition
Object = 'object' object TypeParameters? Aliases? '{' Obj_Definition '}'
Obj_Definition = Obj_Object? Obj_Alternate*
Obj_Object = ( ':' STRING? Obj_Base )? Obj_Field+
Obj_Field = STRING? field Aliases? ':' Obj_Type Modifiers?

Obj_Type = STRING? Obj_Reference
Obj_Alternate = '|' Obj_Type Collections?
Obj_Reference = Internal | Simple | Obj_Base
Obj_Base = '$'typeParameter | object ( '<' Obj_TypeArgument+ '>' )?
Obj_TypeArgument = STRING? Obj_Reference

TypeParameters = '<' ( STRING? '$'typeParameter )+ '>'
```

An Object type may have Type parameters.
Each Type parameter can be preceded by a documentation string.
An Object type with Type parameters is called a Generic type.
A reference to a Generic type must include the correct number of Type arguments.
Generic Type references match if all their Type arguments match, recursively.

An Object type is defined as either:

- an object definition followed by zero or more Alternate object Type references, or
- one or more Alternate object Type references

The order of Alternates is significant.
Alternates may include Collections, but not nullability.
An Alternate must not reference itself, without Collections, even recursively.

An object Type reference may be an Internal, Simple or another object Type.
If an object Type it may have Type Arguments of object Type references.

A object is defined with an optional Parent Type and one or more Fields.

A Field is defined with at least:

- an optional documentation string,
- a Field name
- zero or more Field Aliases
- a type parameter or object type references, the Field's Type
- zero or more Modifiers

Field names and Field Aliases must be unique within the object, including any parent.
Explicit Field names will override the same name being used as a Field Alias.

Object Unions can be merged if their parent Types match.

Type parameters are considered part of the Object Parent definition and thus not merged between Parent and child.

Fields can be merged if their Modified Types match.

Alternates are merged by Type and can be merged if their Collections match.

### Parameter

```PEG
InputParameters = '(' In_TypeDefault+ ')'
```

Input Parameters define one or more Alternate Input type references, possibly with a documentation string, Modifiers and/or a Default.

The order of Alternates is significant.
Alternates are merged by their Input type and can be merged if their Modifiers match.
Default values are merged as Constant values.

### Modifiers / Collections

Note that Schema Collections include Scalar and Enum types as valid Dictionary keys.

<details>
<summary>Modifiers</summary>

<i>The following GraphQlPlus isn't strictly valid but ...</i>

Modifiers are equivalent to predefined generic Input and Output types as follows:

```gqlp
"$T?"
input|output _Opt<$T> [Opt] { $T | Null }

"$T[]"
input|output _List<$T> [List] { $T[] }

"$T[$K]"
input|output _Dict<$K $T> [Dict] { $K: $T }
```

The following GraphQlPlus idioms have equivalent generic Input and Output types.

```gqlp
"$T[*]"
input|output _Map<$T> [Map] { _Dict<String $T> }

"$T[0]"
input|output _Array<$T> [Array] { _Dict<Number $T> }

"$T[~]"
input|output _IfElse<$T> [IfElse] { _Dict<Boolean $T> }

"_[$K]"
input|output _Set<$K> [Set] { _Dict<$K Unit> }

"~[$K]"
input|output _Mask<$K> [Mask] { _Dict<$K Boolean> }
```

These Generic types are the Input types if `$T` is an Input type and Output types if `$T` is an Output type.

`Set`, `Object` and `Mask` are both Input and Output types.

</details>

| Syntax                     | Generic type                             |
| -------------------------- | ---------------------------------------- |
| `String?`                  | Opt<String>                              |
| `String[]`                 | List<String>                             |
| `String[]?`                | Opt<List<String>>                        |
| `String[Number?]`          | Dict<Opt<Number> String>                 |
| `String[][Number][Unit?]?` | Opt<Dict<Opt<Unit> Array<List<String>>>> |

## Input type

An Input type is an Object type with the following Term differences,
after replacing "object" with "input" and "Obj" with "In".

```PEG
In_Field = STRING? field fieldAlias* ':' In_TypeDefault
In_TypeDefault = In_Type Modifiers? Default?
```

Input types define the type of Output field's Argument.

An Input type is defined as an object type with the following alterations.

An Input Field redefines an object Field as follows:

- an optional documentation string,
- a Field name
- zero or more Field Aliases
- a type parameter or Input type references
- zero or more type Modifiers
- an optional Default value

A Default of `null` is only allowed on Optional fields. The Default must be compatible with the Modified Type of the field.

## Output type

An Input type is an Object type with the following Term differences,
after replacing "object" with "output" and "Obj" with "Out".

```PEG
Out_Field = STRING? field ( Out_TypeField | Out_EnumField )
Out_TypeField = InputParameters? fieldAlias* ':' Out_Type Modifiers?
Out_EnumField = fieldAlias* '=' STRING? EnumValue

Out_TypeArgument = Out_Reference | EnumValue
```

Output types define the result values for Categories and Output fields.

An Output type is defined as an object type with the following alterations.

An Output type reference may have Type Arguments of Output type references and/or Enum Values.
If there is a conflict between a bare Enum Value and a Type, the Type will have precedence.

An Output Field redefines an object Field as follows:

- an optional documentation string,
- a Field name
- optional Input Parameters
- zero or more Field Aliases
- a type parameter or an Output type reference
- zero or more type Modifiers

or:

- an optional documentation string,
- a Field name
- zero or more Field Aliases
- an Enum Value (which will imply the field Type)

## Complete Grammar

```PEG
Schema = Declaration+

Declaration = STRING? ( Category | Directive | Option | Type )
Type = Enum | Input | Output | Scalar

Aliases = '[' alias+ ']'

Category = 'category' category? Aliases? '{' ( '(' Cat_Option ')' )? output Modifiers? '}'
Cat_Option = 'parallel' | 'sequential' | 'single'

Directive = 'directive' '@'directive InputParameters? Aliases? '{' Dir_Option? Dir_Location+ '}'
Dir_Option = '(' 'repeatable' ')'
Dir_Location = 'Operation' | 'Variable' | 'Field' | 'Inline' | 'Spread' | 'Fragment'

Option = 'option' name Aliases? '{' Opt_Setting* '}'
Opt_Setting = STRING? setting Default

Parent = ':' parent

Internal_ReDef = 'Null' | 'null' | 'Object' | '%' | 'Void' // Redefined Internal

Simple_ReDef = Basic | scalar | enum  // Redefined Simple

Enum = 'enum' enum Aliases? '{' Parent? En_Member+ '}'
En_Member = STRING? member Aliases?

Scalar = 'scalar' scalar Aliases? '{' Parent? ScalarDefinition '}'
ScalarDefinition = Scal_Boolean | Scal_Enum | Scal_Number | Scal_String | Scal_Union

Scal_Boolean = 'Boolean' Scal_TrueFalse*
Scal_Enum = 'Enum' Scal_Member*
Scal_Number = 'Number' Scal_Num*
Scal_String = 'String' Scal_Regex*
Scal_Union = 'Union' Scal_Reference+

Scal_TrueFalse = '!'? Boolean
Scal_Member = '!'? EnumValue | enum '.' '*'
Scal_Num = '!'? Scal_NumRange
Scal_NumRange = '<' NUMBER | NUMBER ( '~' NUMBER )? | NUMBER '>'
Scal_Regex = '!'? REGEX
Scal_Reference = '|' Simple

// base definition
Object = 'object' object TypeParameters? Aliases? '{' Obj_Definition '}'
Obj_Definition = Obj_Object? Obj_Alternate*
Obj_Object = ( ':' STRING? Obj_Base )? Obj_Field+
Obj_Field = STRING? field Aliases? ':' Obj_Type Modifiers?

Obj_Type = STRING? Obj_Reference
Obj_Alternate = '|' Obj_Type Collections?
Obj_Reference = Internal | Simple | Obj_Base
Obj_Base = '$'typeParameter | object ( '<' Obj_TypeArgument+ '>' )?
Obj_TypeArgument = STRING? Obj_Reference

TypeParameters = '<' ( STRING? '$'typeParameter )+ '>'

InputParameters = '(' In_TypeDefault+ ')'

In_Field = STRING? field fieldAlias* ':' In_TypeDefault
In_TypeDefault = In_Type Modifiers? Default?

Out_Field = STRING? field ( Out_TypeField | Out_EnumField )
Out_TypeField = InputParameters? fieldAlias* ':' Out_Type Modifiers?
Out_EnumField = fieldAlias* '=' STRING? EnumValue

Out_TypeArgument = Out_Reference | EnumValue

```
