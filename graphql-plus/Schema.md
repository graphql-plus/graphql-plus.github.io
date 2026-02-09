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
When merging Declarations, Options and Definitions are also merged.

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
ie. Any Aliases in a list of items that match any names of the items will be removed.

### Merging (and de-duplicating)

Some item lists can be merged and thus de-duplicated.

Merging two (or more) lists will be done by some matching criteria.
If the items are named the default matching criteria is their names.
Otherwise the matching criteria is specific to the items.

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
Category = 'category' category? Aliases? '{' ( '(' Cat_Option ')' )? Description? output Modifiers? '}'
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
All Parent items are considered to have been defined before any Child items.
A Type cannot extend itself, even recursively.

### Built-In types

The Common and Built-In types from [Definition](Definition.md) are available to Schemas.

Though the following redefinitions apply.

```PEG
Internal_ReDef = 'Null' | 'null' | 'Object' | '%' | 'Void' // Redefined Internal

Simple_ReDef = Basic | domain | enum | union // Redefined Simple

Collection_Key_ReDef = Simple | '$'typeParam // Redefined Collection_Key
```

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
Scal_NumRange = Scal_NumOrder NUMBER | NUMBER ( Scal_NumOrder NUMBER )? | NUMBER Scal_NumOrder
Scal_NumOrder = '<' | '>'
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
then an "All labels" inclusion for that Enum type is implied.

Enum domains must contain at least one Label after all exclusions are applied.

Labels can be merged if their Type and inclusion/exclusion matches.
Enum domains must contain only unique Labels after merging, irrelevant of the enum Type the Labels is defined for.

#### Number domain

Comprises only those numbers included in (or excluded from) a given Range or specific value.
If no included or excluded values are specified, a Number domain includes all values.

A Range may specify either or both of its upper or lower bounds and is inclusive of those bounds.
A Range may be defined in either direction, but is canonically shown as Lower? <? Upper?.

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
Obj_Object = ( ':' Obj_Base )? Obj_Field+
Obj_Field = Description? field ( Obj_FieldType | Obj_FieldEnum )
Obj_FieldType = fieldAlias* ':' Obj_Type Modifiers?
Obj_FieldEnum = fieldAlias* '=' Description? EnumValue

Obj_Alternate = '|' Obj_Type Collections? | '!' Description? EnumValue
Obj_Base = Description? ( '$'typeParam | object ( '<' ( Description? Obj_TypeArg )+ '>' )? )
Obj_Type = Obj_Base | Simple | Internal
Obj_TypeArg =  '$'typeParam | Obj_Constraint | Internal | EnumValue
Obj_TypeParams = '<' ( Description? '$'typeParam ':' Obj_Constraint )+ '>'
Obj_Constraint = Simple | object
```

An Object type is defined as:

- zero or more Type parameters
- an optional Parent Type reference
- zero or more object Fields
- zero or more Alternate Type references

An Object type must have either a Parent, a Field or an Alternate.

Object types can be merged if their parent Types match.

#### Type parameters

An Object type may have Type parameters.
Each Type parameter may be preceded by description strings.
Each Type parameter must have a Constraint specifying the Type any argument must be assignable to.
Constraints do not have Type Arguments.

An Object type with Type parameters is called a Generic type.

Type parameters are not merged between Parent and Child.

Type parameters can be merged if their Constraints match.

#### Type references

An object Base is a special Type reference that can only be a Type parameter
or the same object Type as the containing object.
If a Type reference is an object Type it may have Type arguments.
An Object's Parent must be an object Base.

A Type reference may be an Internal Type, Simple Type, Type parameter or an object Base.
Type arguments may be any Type or a Enum Label (or Value).

If a Type reference is a Type parameter then that parameter's Constraint
(and thus any corresponding Type argument) must be valid for that Type reference.

#### Type arguments

A reference to a Generic type must include the correct number of Type arguments.
Generic Type references match if all their Type arguments match.
Type arguments must be assignable to the Constraint of their corresponding Type parameter.

Generic type references CANNOT be used as Type arguments.

A Type argument is assignable to a Constraint if any of the following are true:

- The Constraint is the same type as the Type argument
- The Constraint is a parent (or grandparent etc) of the Type argument
- The Constraint is a Simple type and the Type argument is an equivalent Domain type
- The Constraint is a Enum type and the Type argument is parent of that type
- The Constraint is a Union type and the Type argument is assignable to a Union Member
- The Constraint is an Object type with Alternates and the Type argument is assignable to an Alternate
- The Constraint is a Enum type and the Type argument is Label of that type (or it's parent, grandparent etc)
  If there is a conflict between a bare Enum Label and a Type, the Type will have precedence.

While checking for assignability any Type parameters are presumed to be their Constraints.

#### Fields

A Field is defined as:

- optional field description strings
- a Field name
- zero or more Field Aliases
- optional type description strings
- a Field Type or an Enum Label (which will imply the Field's Type)

A Field Type is defined as:

- a Type reference
- zero or more Modifiers

Field names and Field Aliases must be unique within the object, including any parent.
Explicit Field names will override the same name being used as a Field Alias.

If a Field is defined with a Type parameter and the corresponding Type argument is an Enum Label,
any Modifiers will be ignored.

Fields can be merged if their Field Types or Enum Labels match.

#### Alternates

The order of Alternates is significant.
Alternates may include Collections, but not nullability.
An Alternate must not reference it's containing Type, even recursively.

An Alternate is defined as:

- optional description strings
- a Type parameter or object Type reference, the Alternate's Type
- zero or more Collections

or:

- optional description strings
- an Enum Label (which will imply the Alternate's Type)

If an Alternate is defined with a Type parameter and the corresponding Type argument is an Enum Label,
any Collections will be ignored.

Alternates are merged by Type or Enum Label and can be merged if their Collections match.

### Modifiers / Collections

Note that Schema Collections (and Modifiers) include Domain and Enum types as valid Dictionary keys (See Simple_ReDef).
And Object Collections (and Modifiers) also include Type parameters as valid Dictionary Keys.

<details>
<summary>Modifiers</summary>

<i>The following GraphQlPlus isn't strictly valid but ...</i>

Modifiers are equivalent to predefined generic Input and Output types as follows:

```gqlp
"$T?"
dual _Opt<$T:_Any> [Opt] { | $T | Null }

dual _List<$T:_Any> [List] { | $T[] }

dual _Dict<$K:_Key $T:_Any> [Dict] { | $T[$K] }
```

The following GraphQlPlus idioms have equivalent generic Input and Output types.

```gqlp
dual _Map<$T:_Any> [Map] { | $T[*] }

dual _Array<$T:_Any> [Array] { | $T[0] }

dual _IfElse<$T:_Any> [IfElse] { | $T[^] }

dual _Set<$K:_Key> [Set] { | _[$K] }

dual _Mask<$K:_Key> [Mask] { | ^[$K] }
```

Definitions to support the above idioms

```gqlp
union _Key { }
dual _Any { }
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
In_FieldType = In_Type Modifiers? Default?

InputParams = '(' In_FieldType+ ')'
```

Input types define the Input Parameters of Directives or Output fields.

An Input type is defined as an object type with the following alterations.

An Input Field redefines an object Field as follows:

- an optional description string
- a Field name
- zero or more Field Aliases
- a type parameter or Input type reference
- zero or more Modifiers
- an optional Default value

A Default of `null` is only allowed on Optional fields.
The Default must be compatible with the Modified Type of the field.

Default values are merged as Constant values.

Input Parameters define one or more Alternate Input, Dual or Simple types,
possibly with a description string, Modifiers and/or a Default.
On Output Fields they could also include an Type parameter.

### Output type

An Output type is an Object type with the following Term differences,
after replacing "object" with "output" and "Obj" with "Out".

```PEG
Out_FieldType = InputParams? fieldAlias* ':' Out_Type Modifiers?
```

Output types define the result values for Categories.

An Output type is defined as an object type with the following alterations.

An Output Field redefines an object Field as follows:

- optional field description strings
- a Field name
- optional Input Parameters
- zero or more Field Aliases
- optional type description strings
- a type parameter or an Output type reference
- zero or more type Modifiers

## Complete Grammar

```PEG
Schema = Declaration+

Declaration = Description? ( Category | Directive | Option | Type )
Type = Dual | Enum | Input | Output | Domain | Union
Description = STRING+

Aliases = '[' alias+ ']'

Category = 'category' category? Aliases? '{' ( '(' Cat_Option ')' )? Description? output Modifiers? '}'
Cat_Option = 'parallel' | 'sequential' | 'single'

Directive = 'directive' '@'directive InputParams? Aliases? '{' Dir_Option? Dir_Location+ '}'
Dir_Option = '(' 'repeatable' ')'
Dir_Location = 'Operation' | 'Variable' | 'Field' | 'Inline' | 'Spread' | 'Fragment'

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
Scal_NumRange = Scal_NumOrder NUMBER | NUMBER ( Scal_NumOrder NUMBER )? | NUMBER Scal_NumOrder
Scal_NumOrder = '<' | '>'
Scal_Regex = Description? '!'? REGEX

Enum = 'enum' enum Aliases? '{' Parent? En_Label+ '}'
En_Label = Description? label Aliases?

Union = 'union' union Aliases? '{' Parent? Un_Member+ '}'
Un_Member = Description? Simple

// base definition
Object = 'object' object Obj_TypeParams? Aliases? '{' Obj_Definition '}'
Obj_Definition = Obj_Object? Obj_Alternate*
Obj_Object = ( ':' Obj_Base )? Obj_Field+
Obj_Field = Description? field ( Obj_FieldType | Obj_FieldEnum )
Obj_FieldType = fieldAlias* ':' Obj_Type Modifiers?
Obj_FieldEnum = fieldAlias* '=' Description? EnumValue

Obj_Alternate = '|' Obj_Type Collections? | '!' Description? EnumValue
Obj_Base = Description? ( '$'typeParam | object ( '<' ( Description? Obj_TypeArg )+ '>' )? )
Obj_Type = Obj_Base | Simple | Internal
Obj_TypeArg =  '$'typeParam | Obj_Constraint | Internal | EnumValue
Obj_TypeParams = '<' ( Description? '$'typeParam ':' Obj_Constraint )+ '>'
Obj_Constraint = Simple | object

In_FieldType = In_Type Modifiers? Default?

InputParams = '(' In_FieldType+ ')'

Out_FieldType = InputParams? fieldAlias* ':' Out_Type Modifiers?

```

## Complete Definition

```gqlp
"$T?"
dual _Opt<$T:_Any> [Opt] { | $T | Null }

dual _List<$T:_Any> [List] { | $T[] }

dual _Dict<$K:_Key $T:_Any> [Dict] { | $T[$K] }

dual _Map<$T:_Any> [Map] { | $T[*] }

dual _Array<$T:_Any> [Array] { | $T[0] }

dual _IfElse<$T:_Any> [IfElse] { | $T[^] }

dual _Set<$K:_Key> [Set] { | _[$K] }

dual _Mask<$K:_Key> [Mask] { | ^[$K] }

union _Key { }
dual _Any { }

```
