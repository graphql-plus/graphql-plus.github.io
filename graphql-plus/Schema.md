# Schema language definition

> See [Definition](Definition.md) on how to read the definitions below
> and the definition of a number of Terms used these definitions.
>
> Including PEG definitions for Common and Constant terms.

## Schema

```PEG
Schema = Declaration+

Declaration = Description? ( Category | Directive | Option | Type )
Type = Dual | Enum | Input | Output | Domain | Union
Description = STRING+

Aliases = '[' alias+ ']'
```

A Schema is one (or more) Declarations. Each declaration may be preceded by description strings.

### Declarations

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

### Merging (and de-duplicating)

Some item lists can be merged and thus de-duplicated.

Merging two (or more) lists will be done by some matching criteria.
If the items are named the default matching criteria is their names.

Unless otherwise specified, items are merged as follows:

- List components of any matching items will be merged.
  If a list component can't be merged, then the items can't be merged.
- Other (ie, not lists or part of the matching criteria) required components of any matching items must be the same.
- Optional components, if present, must be the same.
- If only present on some items before merging, optional components will be retained on the merged item.

De-duplicating two (or more) lists will be done by the matching criteria.
As order is significant in most lists, the first item of any duplicates will be kept, possibly updated by any merging.

It is an error if merging of duplicate items is not possible.

## Global declarations

Global declarations define specific capabilities that cover the entirety of the Schema.

### Category declaration

```PEG
Category = 'category' category? Aliases? '{' ( '(' Cat_Option ')' )? Out_Type Modifiers? '}'
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

### Directive declaration

```PEG
Directive = 'directive' '@'directive InputParams? Aliases? '{' Dir_Option? Dir_Location+ '}'
Dir_Option = '(' 'repeatable' ')'
Dir_Location = 'Operation' | 'Variable' | 'Field' | 'Inline' | 'Spread' | 'Fragment'
```

A Directive is defined with a set of Locations where it may appear in an Operation.
A Directive may have Input Parameters.

By default a Directive can only appear once at any Location,
but this can be changed with the `repeatable` Directive option.

Directives can be merged if their Options match.

Locations will be merged by value.

### Operation declaration

```PEG
Operation = 'operation' name Aliases? '{' Oper_Definition '}'
Oper_Definition = category Oper_Variables? Oper_Directive* Oper_Fragment* Oper_Result
```

An Operation declaration defines a named Operation for the Schema as a whole.
The definition is essentially the same as in [Operation](Operation.md)
but the Term's names are prefixed with `Oper_` and the following are redefined.

```PEG
Oper_TypeCondition = ':' type
```

Note the `category` is required, the name is specified outside definition and
most of the GraphQl compatibility options are dropped.
Specifically trailing Fragment definitions and the alternate `on` keyword for Type Conditions.

Operations can only be merged if their Categories match.

### Option declaration

```PEG
Option = 'option' name Aliases? '{' Opt_Setting* '}'
Opt_Setting = Description? setting Default
```

An Option defines valid options for the Schema as a whole, including the Schema name and Aliases.
A Schema must have only one name.

An Option Setting comprises of a name and a constant value. A Setting may be preceded by description strings.

Option Settings are merged by name and values are merged in the same way as Constant Object values.

## Type declarations

Most declarations define a Type. A Type's Kind is defined as their Declaration label.

The names and Aliases of all Types must be unique across all kinds of Types within the Schema.
Merging of Types is only possible if their Kinds match.

### Common

All Types may specify another Type of the same Kind that they extend.
Child (Extending) Types merge in the definition of their Parent (Extended) Type.
A Type cannot extend itself, even recursively.

### Built-In types

The Common and Built-In types from [Definition](Definition.md) are available to Schemas.

Though the following redefinitions apply.

```PEG
Internal_ReDef = 'Null' | 'null' | 'Object' | '%' | 'Void' // Redefined Internal

Simple_ReDef = Basic | domain | enum | union // Redefined Simple

Collection_Key_ReDef = Simple | '$'typeParam // Redefined Collection_Key
```

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

Number and String are effectively domain types as follows:

```gqlp
domain Number [int, 0] { Number }

domain String [str, *] { String }
```

Object is a general Dictionary as follows:

```gqlp
"%"
dual _Object [Object, obj, %] { :_Map<Any> } // recursive

dual _Most<$T> [Most] { $T | Object | _Most<$T>? | _MostList<$T> | _MostDictionary<$T> } // recursive! not in _Dual, _Input or _Output
dual _MostList<$T> { _Most<$T>[] } // recursive! not in _Dual, _Input or _Output
dual _MostDictionary<$T> { _Most<$T>[Simple?] } // recursive! not in _Dual, _Input or _Output

dual _Any [Any] { :_Most<_Dual> } // not in _Dual
input _Any [Any] { :_Most<_Input> } // not in _Input
output _Any [Any] { :_Most<_Output> } // not in _Output
union _Any [Any] { Basic Internal _Enum _Domain _Union } // not in _Union
```

The internal types `_Union [Union]`, `_Domain [Domain]`, `_Output [Output]`, `_Input [Input]`, `_Enum [Enum]`
and `_Dual [Dual]` are automatically defined to be a union of all user defined Union, Domain, Output, Input,
Enum and Dual types respectively, as follows:

```gqlp
dual _Dual [Dual] { } // All user defined Dual types
union _Enum [Enum] { } // All user defined Enum types
input _Input [Input] { } // All user defined Input types
output _Output [Output] { } // All user defined Output types
union _Domain [Domain] { } // All user defined Domain types
union _Union [Union] { } // All user defined Union types
```

</details>

## Simple types

Domain, Enum and Union are Simple types.
Simple types have a parent of the same type and some items.

Simple types specify their parent by just their name.

```PEG
Parent = ':' Description? parent
```

### Domain type

Domain type definitions are of the following general form:

> `Parent? Kind Item*`

```PEG
Domain = 'domain' domain Aliases? '{' Parent? DomainDefinition '}'
DomainDefinition = Scal_Boolean | Scal_Enum | Scal_Number | Scal_String

Scal_Boolean = 'Boolean' Scal_TrueFalse*
Scal_Enum = 'Enum' Scal_Label+
Scal_Number = 'Number' Scal_Num*
Scal_String = 'String' Scal_Regex*

Scal_TrueFalse = Description? '!'? Boolean
Scal_Label = Description? ( '!'? EnumValue | enum '.' '*' )
Scal_Num = Description? '!'? Scal_NumRange
Scal_NumRange = '<' NUMBER | NUMBER ( '~' NUMBER )? | NUMBER '>'
Scal_Regex = Description? '!'? REGEX
```

Domain types define specific sub-domains of the following Domains, each with different Item definitions:

> Boolean, Enum, Number, String

A Domain type without a Parent is considered to extend it's base Domain.

Each Item may be preceded by description strings.

Item exclusions (where defined) take precedence over inclusions.

Domain declarations can be merged if their Domains and Parents match.

#### Boolean domain

Comprises only those Boolean values explicitly included (or excluded).
If no included or excluded values are specified, a Boolean domain includes both values, ie. true and false.

Boolean values can only be merged if their inclusion/exclusion matches.

#### Enum domain

Comprises only those Labels explicitly included (or excluded).
An Enum domain must specify at least one inclusion (or exclusion).

All Labels of an Enum type can also be included (or excluded).

If exclusion Items are specified for an Enum type,
but but no "All Labels" inclusion is specified for that Enum type or any of it's children,
then and "All labels" inclusion is implied.

Labels can be merged if their Type and inclusion/exclusion matches.
Enum domains must contain only unique Labels after merging, irrelevant of the enum Type the Labels is defined for.

#### Number domain

Comprises only those numbers included in (or excluded from) a given Range or specific value.
If no included or excluded values are specified, a Number domain includes all values.

A Range may specify either or both of its upper or lower bounds and is inclusive of those bounds.

Ranges are merged by their bounds, but can only be merged if their inclusion/exclusion matches.

#### String domain

Comprises only those strings that match (or don't match) one or more Regular expressions.
If no included or excluded values are specified, a String domain includes all values.

Regular expressions can only be merged if their inclusion/exclusion matches.

### Enum type

```PEG
Enum = 'enum' enum Aliases? '{' Parent? En_Label+ '}'
En_Label = Description? label Aliases?
```

An Enum is a Type defined with one or more Labels.

Each Label may be preceded by description strings and may have one or more Aliases.

Enums can be merged if their Parents, including lack thereof, match.

### Union type

```PEG
Union = 'union' union Aliases? '{' Parent? Un_Member+ '}'
Un_Member = Description? Simple
```

A Union type is defined as a specific combination of one or more Member Simple types.

Each Member may be preceded by description strings.

A Union type must not include itself, as either Parent or Member, even recursively.

Union declarations can be merged if their Parents match.

## Object types

Dual, Input and Output types are all Object types.

### Object Commonalities

```PEG
// base definition
Object = 'object' object Obj_TypeParams? Aliases? '{' Obj_Definition '}'
Obj_Definition = Obj_Object? Obj_Alternate*
Obj_Object = ( ':' Obj_Type )? Obj_Field+
Obj_Field = Description? field Aliases? ':' Obj_Type Modifiers?

Obj_Alternate = '|' Obj_Type Collections?
Obj_Type = Description? ( '$'typeParam | Obj_Base )
Obj_Base = Internal | Simple | object ( '<' ( Description? Obj_TypeArg )+ '>' )?
Obj_TypeArg =  '$'typeParam | Internal | Simple | object

Obj_TypeParams = '<' ( Description? '$'typeParam )+ '>'
```

An Object type is defined as either:

- an object definition followed by zero or more Alternate object Type references, or
- one or more Alternate object Type references

Object types can be merged if their parent Types match.

Type parameters are considered part of the Object Parent definition and thus not merged between Parent and child.

#### Type parameters and Type arguments

An Object type may have Type parameters.
Each Type parameter may be preceded by description strings.

An Object type with Type parameters is called a Generic type.
A reference to a Generic type must include the correct number of Type arguments.
Generic Type references match if all their Type arguments match.
Note that Generic types CANNOT be used as Type arguments.

#### Object definition and Fields

A object is defined with an optional Parent Type and one or more Fields.

A Field is defined as:

- optional field description strings
- a Field name
- zero or more Field Aliases
- optional type description strings
- a type parameter or object type reference, the Field's Type
- zero or more Modifiers

Field names and Field Aliases must be unique within the object, including any parent.
Explicit Field names will override the same name being used as a Field Alias.

Fields can be merged if their Modified Types match.

#### Object Alternates

The order of Alternates is significant.
Alternates may include Collections, but not nullability.
An Alternate must not reference itself, even recursively.

An object Type reference may be an Internal Type, Simple Type, Type parameter or the same object Type as the reference.
If a reference is an object Type it may have Type Arguments.
Type arguments may be an Internal Type, Simple Type, Type parameter or the same object Type as the reference.
If a Type argument is an object Type it may NOT have Type Arguments.

An Alternate is defined as:

- optional description strings
- a type parameter or object type reference, the Alternate's Type
- zero or more Collections

Alternates are merged by Type and can be merged if their Collections match.

### Modifiers / Collections

Note that Schema Collections (and Modifiers) include Domain and Enum types as valid Dictionary keys (See Simple_ReDef).
And Object Collections (and Modifiers) also include Type parameters as valid Dictionary Keys.

<details>
<summary>Modifiers</summary>

<i>The following GraphQlPlus isn't strictly valid but ...</i>

Modifiers are equivalent to predefined generic Input and Output types as follows:

```gqlp
"$T?"
dual _Opt<$T> [Opt] { $T | Null }

"$T[]"
dual _List<$T> [List] { $T[] }

"$T[$K]"
dual _Dict<$K $T> [Dict] { $K: $T }
```

The following GraphQlPlus idioms have equivalent generic Input and Output types.

```gqlp
"$T[String] or $T[*]"
dual _Map<$T> [Map] { _Dict<* $T> }

"$T[Number] or $T[0]"
dual _Array<$T> [Array] { _Dict<0 $T> }

"$T[Boolean] or $T[^]"
dual _IfElse<$T> [IfElse] { _Dict<^ $T> }

"Unit[$K] or _[$K]"
dual _Set<$K> [Set] { _Dict<$K _> }

"Boolean[$K] or ^[$K]"
dual _Mask<$K> [Mask] { _Dict<$K ^> }
```

These Generic types are the Input types if `$T` is an Input type and Output types if `$T` is an Output type.

`Set`, `Object` and `Mask` are both Input and Output types.

</details>

| Syntax        | Generic type                             |
| ------------- | ---------------------------------------- |
| `String?`     | Opt<String>                              |
| `*[]`         | List<String>                             |
| `String[]?`   | Opt<List<String>>                        |
| `*[Number?]`  | Dict<Opt<Number> String>                 |
| `*[][0][_?]?` | Opt<Dict<Opt<Unit> Array<List<String>>>> |

### Dual type

A Dual type can be used as either an Input type or an Output type.

A Dual type is defined as an object type with no Term differences,
after replacing "object" with "dual" and "Obj" with "Dual".

### Input type

An Input type is an Object type with the following Term differences,
after replacing "object" with "input" and "Obj" with "In".

```PEG
In_Field = Description? field fieldAlias* ':' In_TypeDefault
In_TypeDefault = In_Type Modifiers? Default?

InputParams = '(' In_TypeDefault+ ')'
```

Input types define the type of Arguments, used on Directives or Output fields.

An Input type is defined as an object type with the following alterations.

An Input Field redefines an object Field as follows:

- an optional description string
- a Field name
- zero or more Field Aliases
- a type parameter or Input type references
- zero or more type Modifiers
- an optional Default value

A Default of `null` is only allowed on Optional fields.
The Default must be compatible with the Modified Type of the field.

Input Parameters define one or more Alternate Input, Dual or Simple types,
possibly with a description string, Modifiers and/or a Default.

The order of Alternates is significant.
Alternates are merged by their type and can be merged if their Modifiers match.

Default values are merged as Constant values.

### Output type

An Output type is an Object type with the following Term differences,
after replacing "object" with "output" and "Obj" with "Out".

```PEG
Out_Field = Description? field ( Out_TypeField | Out_EnumField )
Out_TypeField = InputParams? fieldAlias* ':' Out_Type Modifiers?
Out_EnumField = fieldAlias* '=' Description? EnumValue

Out_TypeArg = '$'typeParam | Internal | Simple | object | EnumValue
```

Output types define the result values for Categories.

An Output type is defined as an object type with the following alterations.

An Output type reference may have Type Arguments of Output type references, without arguments, and/or Enum Labels.
If there is a conflict between a bare Enum Label and a Type, the Type will have precedence.

An Output Field redefines an object Field as follows:

- optional field description strings
- a Field name
- optional Input Parameters
- zero or more Field Aliases
- optional type description strings
- a type parameter or an Output type reference
- zero or more type Modifiers

or:

- optional field description strings
- a Field name
- zero or more Field Aliases
- optional type description strings
- an Enum Label (which will imply the field Type)

## Complete Grammar

```PEG
Schema = Declaration+

Declaration = Description? ( Category | Directive | Option | Type )
Type = Dual | Enum | Input | Output | Domain | Union
Description = STRING+

Aliases = '[' alias+ ']'

Category = 'category' category? Aliases? '{' ( '(' Cat_Option ')' )? Out_Type Modifiers? '}'
Cat_Option = 'parallel' | 'sequential' | 'single'

Directive = 'directive' '@'directive InputParams? Aliases? '{' Dir_Option? Dir_Location+ '}'
Dir_Option = '(' 'repeatable' ')'
Dir_Location = 'Operation' | 'Variable' | 'Field' | 'Inline' | 'Spread' | 'Fragment'

Operation = 'operation' name Aliases? '{' Oper_Definition '}'
Oper_Definition = category Oper_Variables? Oper_Directive* Oper_Fragment* Oper_Result

Oper_TypeCondition = ':' type

Option = 'option' name Aliases? '{' Opt_Setting* '}'
Opt_Setting = Description? setting Default

Internal_ReDef = 'Null' | 'null' | 'Object' | '%' | 'Void' // Redefined Internal

Simple_ReDef = Basic | domain | enum | union // Redefined Simple

Collection_Key_ReDef = Simple | '$'typeParam // Redefined Collection_Key

Parent = ':' Description? parent

Domain = 'domain' domain Aliases? '{' Parent? DomainDefinition '}'
DomainDefinition = Scal_Boolean | Scal_Enum | Scal_Number | Scal_String

Scal_Boolean = 'Boolean' Scal_TrueFalse*
Scal_Enum = 'Enum' Scal_Label+
Scal_Number = 'Number' Scal_Num*
Scal_String = 'String' Scal_Regex*

Scal_TrueFalse = Description? '!'? Boolean
Scal_Label = Description? ( '!'? EnumValue | enum '.' '*' )
Scal_Num = Description? '!'? Scal_NumRange
Scal_NumRange = '<' NUMBER | NUMBER ( '~' NUMBER )? | NUMBER '>'
Scal_Regex = Description? '!'? REGEX

Enum = 'enum' enum Aliases? '{' Parent? En_Label+ '}'
En_Label = Description? label Aliases?

Union = 'union' union Aliases? '{' Parent? Un_Member+ '}'
Un_Member = Description? Simple

// base definition
Object = 'object' object Obj_TypeParams? Aliases? '{' Obj_Definition '}'
Obj_Definition = Obj_Object? Obj_Alternate*
Obj_Object = ( ':' Obj_Type )? Obj_Field+
Obj_Field = Description? field Aliases? ':' Obj_Type Modifiers?

Obj_Alternate = '|' Obj_Type Collections?
Obj_Type = Description? ( '$'typeParam | Obj_Base )
Obj_Base = Internal | Simple | object ( '<' ( Description? Obj_TypeArg )+ '>' )?
Obj_TypeArg =  '$'typeParam | Internal | Simple | object

Obj_TypeParams = '<' ( Description? '$'typeParam )+ '>'

In_Field = Description? field fieldAlias* ':' In_TypeDefault
In_TypeDefault = In_Type Modifiers? Default?

InputParams = '(' In_TypeDefault+ ')'

Out_Field = Description? field ( Out_TypeField | Out_EnumField )
Out_TypeField = InputParams? fieldAlias* ':' Out_Type Modifiers?
Out_EnumField = fieldAlias* '=' Description? EnumValue

Out_TypeArg = '$'typeParam | Internal | Simple | object | EnumValue

```
