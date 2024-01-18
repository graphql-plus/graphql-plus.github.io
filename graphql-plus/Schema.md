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

> `label name Parameters? Aliases? '{' ( '(' Options ')' )? Definition '}'`

Multiple Declarations with the same label and name are permitted if their Options and Definitions can be merged.
When merging Declarations, Parameters and Aliases will be merged.

The following declarations are implied but can be specified explicitly:

- `category { Query }` and thus `output Query { }`
- `category { (sequential) Mutation }` and thus `output Mutation { }`
- `category { (single) Subscription }` and thus `output Subscription { }`
- `output _Schema { ... }` (see [Introspection](Introspection.md))

### Names and Aliases

Many named items can also have Aliases, which are a list of alternate ids for a given item.

Within any list of named items with Aliases, after merging, Aliases must be unique.
Any conflicts between names and Aliases will be resolved in the favour of the name,
ie. Any Aliases in a list of items that match any of the item's names will simply be removed.

### Merging (and De-duplicating)

Some item lists can be merged and thus de-duplicated.

Merging two (or more) lists will be done by some matching criteria.
If the items are named the default matching criteria is by name.

- List components of any matching items will be merged.
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

A Category is a set of fields defined by an Output type.

A Category has a default name of the Output type name with the first character changed to lowercase.

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
Directive = 'directive' '@'directive InputParameters? Aliases? '{' Dir_Repeatable? Dir_Location+ '}'
Dir_Repeatable = '(' 'repeatable' ')'
Dir_Location = 'Operation' | 'Variable' | 'Field' | 'Inline' | 'Spread' | 'Fragment'
```

A Directive is defined with a set of Locations where it may appear in an Operation.
A Directive may have Input Parameters.

By default a Directive can only appear once at any Location, but this can be changed with the `repeatable` Directive option.

Directives can be merged if their Options match and their Parameters can be merged.

Locations will be merged by value.

## Option declaration

```PEG
Option = 'option' name Aliases? '{' Opt_Setting* '}'
Opt_Setting = STRING? setting Default
```

An Option defines valid options for the Schema as a whole, including the Schema name and Aliases.
A Schema must have only one name.

Options can be merged only if Option Settings can be merged.
Option Settings are merged by name and values are merged in the same way as Constant Object values.

## Type declarations

Most declarations define a Type.

The names and Aliases of all Types must be unique across all kinds of Types within the Schema.
Merging of Types is only possible if the kinds match.

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
input|output _Object [Object,%] { : _Map<Any> } // recursive

input|output _Most<$T> [Most] { $T | Object | _Most<$T>? | _Most<$T>[] | _Most<$T>[Simple] | _Most<$T>[Simple?] } // recursive! not in _Input or _Output

input _Any [Any] { : _Most<_Input> } // not in _Input
output _Any [Any] { : _Most<_Output> } // not in _Output
scalar _Any [Any] { | Basic | Internal | _Enum | _Scalar } // not in _Scalar
```

The internal types `_Scalar`, `_Output`, `_Input` and `_Enum` are automatically defined to be a union of all Scalar, Output, Input and Enum types respectively.

</details>

## Enum type

```PEG
Enum = 'enum' enum Aliases? '{' ( ':' enum )? En_Member+ '}'
En_Member = STRING? member Aliases?
```

An Enum is a Type defined with one or more Members.

Each Member can be preceded by a documentation string and may have one or more Aliases.

An Enum can extend another Enum, and it's Members are merged into the extended Enum's Members.
An Enum cannot extend itself, even recursively.

Enums can be merged if their extended Enums match and their Members can be merged.

## Scalar type

```PEG
Scalar = 'scalar' scalar Aliases? '{' ScalarDefinition '}'
ScalarDefinition = Scal_Boolean | Scal_Enum | Scal_Number | Scal_String | Scal_Union

Scal_Boolean = 'Boolean' ( ':' scalar )?
Scal_Enum = 'Enum' ( ':' scalar )? enum Scal_Member*
Scal_Number = 'Number' ( ':' scalar )? Scal_Num*
Scal_String = 'String' ( ':' scalar )? Scal_Regex*
Scal_Union = 'Union' ( ':' scalar )? Scal_Reference+

Scal_Member = '!'? Scal_MemberRange
Scal_MemberRange = '~' member | member ( '~' ( member )? )?
Scal_Num = '!'? Scal_NumRange
Scal_NumRange = '~' NUMBER | NUMBER ( '~' ( NUMBER )? )?
Scal_Regex = '!'? REGEX
Scal_Reference = '|' Simple
```

Scalar types define specific domains of the following kinds:

- Enum, which is based on a specific Enum type, but limited to only those members in (or out) of a given range or specific value. Ranges may be upper and/or lower bounded and are inclusive of those bounds.
- Number, comprising only those numbers in (or out) of a given range or specific value. Ranges may be upper and/or lower bounded and are inclusive of those bounds.
- Strings, comprising only those strings that match (or don't match) one or more regular expressions.
- Union of one or more Simple types. A Scalar Union must not include itself, recursively.

A Scalar can extend another Scalar of the same Kind and it's Ranges or Regexes are merged into the extended Scalars ones.

Scalar declarations can be merged if their Kinds, extended Scalars and, if of the Enum Kind, base Enums match and their Ranges or Regexes can be merged.

## Object Union types

Input and Output types are both Object Union types.

```PEG
// base definition
Object = 'object' object TypeParameters? Aliases? '{' Obj_Definition '}'
Obj_Definition = Obj_Object? Obj_Alternate*
Obj_Object = ( ':' STRING? Obj_Base )? Obj_Field+
Obj_Field = STRING? field Aliases? ':' Obj_Type Modifiers?

Obj_Type = STRING? Obj_Reference
Obj_Alternate = '|' Obj_Type Collections?
Obj_Reference = Internal | Simple | Obj_Base
Obj_Base = '$'typeParameter | object ( '<' Obj_Argument+ '>' )?
Obj_Argument = STRING? Obj_Reference

TypeParameters = '<' ( STRING? '$'typeParameter )+ '>'
```

Type parameters can be defined on Object union types. Each parameter can be preceded by a documentation string.

An Object Union type is defined as either:

- an object definition followed by zero or more Alternate object Type references, or
- one or more Alternate object Type references

The order of Alternates is significant.
An Alternate must not include itself, recursively.
Alternates may include Collections, but not nullability.

An object Type reference may be an Internal, Simple or another object Type.
If an object Type it may have Type Arguments of object Type references.

An object is defined with an optional extended Type and has one or more Fields.
An object can not extend itself, even recursively.

A Field is defined with at least:

- an optional documentation string,
- a Field name
- zero or more Field Aliases
- a type parameter or object type references, the Field's Type
- zero or more Modifiers

Field names and Field Aliases must be unique within the object, including any extended object.
Explicit Field names will override the same name being used as a Field Alias.

Object Unions can be merged if their extended Types match and their Fields and Alternates can both be merged.

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

An Input type is defined as an object union type with the following alterations.

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

Out_Argument = Out_Reference | EnumValue
```

Output types define the result values for Categories and Output fields.

An Output type is defined as an object union type with the following alterations.

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

Directive = 'directive' '@'directive InputParameters? Aliases? '{' Dir_Repeatable? Dir_Location+ '}'
Dir_Repeatable = '(' 'repeatable' ')'
Dir_Location = 'Operation' | 'Variable' | 'Field' | 'Inline' | 'Spread' | 'Fragment'

Option = 'option' name Aliases? '{' Opt_Setting* '}'
Opt_Setting = STRING? setting Default

Internal_ReDef = 'Null' | 'null' | 'Object' | '%' | 'Void' // Redefined Internal

Simple_ReDef = Basic | scalar | enum  // Redefined Simple

Enum = 'enum' enum Aliases? '{' ( ':' enum )? En_Member+ '}'
En_Member = STRING? member Aliases?

Scalar = 'scalar' scalar Aliases? '{' ScalarDefinition '}'
ScalarDefinition = Scal_Boolean | Scal_Enum | Scal_Number | Scal_String | Scal_Union

Scal_Boolean = 'Boolean' ( ':' scalar )?
Scal_Enum = 'Enum' ( ':' scalar )? enum Scal_Member*
Scal_Number = 'Number' ( ':' scalar )? Scal_Num*
Scal_String = 'String' ( ':' scalar )? Scal_Regex*
Scal_Union = 'Union' ( ':' scalar )? Scal_Reference+

Scal_Member = '!'? Scal_MemberRange
Scal_MemberRange = '~' member | member ( '~' ( member )? )?
Scal_Num = '!'? Scal_NumRange
Scal_NumRange = '~' NUMBER | NUMBER ( '~' ( NUMBER )? )?
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
Obj_Base = '$'typeParameter | object ( '<' Obj_Argument+ '>' )?
Obj_Argument = STRING? Obj_Reference

TypeParameters = '<' ( STRING? '$'typeParameter )+ '>'

InputParameters = '(' In_TypeDefault+ ')'

In_Field = STRING? field fieldAlias* ':' In_TypeDefault
In_TypeDefault = In_Type Modifiers? Default?

Out_Field = STRING? field ( Out_TypeField | Out_EnumField )
Out_TypeField = InputParameters? fieldAlias* ':' Out_Type Modifiers?
Out_EnumField = fieldAlias* '=' STRING? EnumValue

Out_Argument = Out_Reference | EnumValue

```
