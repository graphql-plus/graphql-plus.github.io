# Language Definitions

All keywords and identifiers are case-sensitive.

Except where explicitly specified (in Constants), commas (`,`) are considered whitespace.

## Grammar

Language definitions are given in a modified PEG (Parsing Expression Grammar)

| Operator   | Example       | Description                                                                              |
| ---------- | ------------- | ---------------------------------------------------------------------------------------- |
| Grouping   | `(` exp `)`   | The expression is treated as a single term.                                              |
|            |
| Lookahead  |               | These two operators don't consume the input for the expression                           |
| Positive   | `&` exp       | The expression must match at this point.                                                 |
| Negative   | `!` exp       | The expression must NOT match at this point.                                             |
|            |
| Term       | `Operation`   | Defined elsewhere in the language definition. Terms are capitalized.                     |
| Word       | `category`    | A simple name defined by the regex `\[A-Za-z][A-Za-z0-9_.]+`                             |
| Prefix     | `'$'variable` | A String surrounded by quotes immediately followed by a Word.                            |
| Literal    | `'('`         | A String surrounded by quotes that must appear exactly as written.                       |
| Constant   | `NUMBER`      | An expression that matches a specific regex as defined below. Constants are in all-caps. |
|            |
| Repetition |
| Optional   | exp `?`       | The expression occurs zero or one times.                                                 |
| Some       | exp `*`       | The expression occurs zero or more times.                                                |
| Many       | exp `+`       | The expression occurs one or more times.                                                 |
|            |
| Sequence   | exp exp       | The expressions must occur in the given order.                                           |
|            |
| Alternate  | exp `\|` exp  | If the first expression doesn't match, try the second expression instead.                |

**Note:** The above are in descending order of precedence

## Constants

| Constant | RegEx                                | Description                                                                                                                          | Examples                                              |
| -------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------- |
| NUMBER   | `[-+]?[0-9_]+(\.[0-9_]+)?`           | A number, possibly signed and/or with a fractional portion. An underscore (`_`) can be used to separate digit groups                 | 1 2.3 45 67.89 0.10 -11 +12 -13.14 +15.16 17_18.19_20 |
| STRING   | `"([^"]\|\\.)*"` or `'([^']\|\\.)*'` | A string delimited by either single (`'`) or double (`"`) quotes and with any characters in the string escaped by a backslash (`\`). | "" "a" "b\\"c" "d'e" <br/> '' 'f' 'g"h' 'i\\'j'       |
| REGEX    | `/.*/`                               | A regex delimited by slashes (`/`) conforming to POSIX ERE                                                                           | /.\*/                                                 |

**Note:** Both STRING and REGEX constants can include end-of-line and other control characters.

## Common

```PEG
Default = '=' Value

EnumValue = ( enum '.' )? label

FieldKey = EnumValue | NUMBER | STRING

Boolean = 'false' | 'true'

Simple = Basic | enum
Basic = 'Boolean' | '^' | 'Number' | '0' | 'String' | '*' | 'Unit' | '_'

Internal = 'Void' | 'Null' | 'null'
```

Defaults must match the Modifiers/Collections Type of the item the Default is on.

An Enum Value may drop the Enum portion if the Label is unique.
Enum Value includes (`Boolean.`)`false`, (`Boolean.`)`true`, (`Null.`)`null` and (`Unit.`)`_`.

`Boolean`, `Null`, `Unit` and `Void` are all Enum types.
`Number` and `String` are Domain types.

### Modifiers / Collections

```PEG
Modifiers = Collections? '?'?
Collections = '[]' Collections? | '[' Collection_Key '?'? ']' Collections?
Collection_Key = Simple // Redefined in Schema
```

Collections are any combination of Lists and/or Dictionaries.
Modifiers are zero or more Collections optionally followed by Optionality (also know as Nullability).

| Modifier   | Syntax           | Notes                                                                                                                         | Description                   |
| ---------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| Optional   | `?`              | An Optional Result may have the value of `null`. <br/> The `Null` type is effectively the same as `Void?` and so is `Null?`.  | Optional _type_               |
| List       | `[]`             | A List Result will be an array with zero or more entries.                                                                     | List of _type_                |
| Dictionary | `[`Simple`?`?`]` | A Dictionary Result will be an object with the given Simple type as the Key. <br/> The Key may be Optional.                   | Dictionary by _key_ of _type_ |
| Dictionary | `[$`param`?`?`]` | In Schema Objects, a Type parameter may be used to set the Key type. It is an error if the Type Argument is not a Simple type |

Multiple Modifiers from left to right are from outside to inside finishing with the initial type.

| Syntax                     | Description                                                                          | Example                     |
| -------------------------- | ------------------------------------------------------------------------------------ | --------------------------- |
| `String?`                  | Optional String                                                                      | `""`                        |
| `String[]`                 | List of String                                                                       | `[ "", "a" ]`               |
| `String[]?`                | List of Optional String                                                              | `[ "", null ]`              |
| `String[Number?]`          | Dictionary by Optional Number of String                                              | `{ 1:"", null:"a", 2:"B" }` |
| `String[][Number][Unit?]?` | List of Dictionary by Number of <br/> Dictionary by Optional Unit of Optional String | _See Example 1 below_       |

<details>
<summary>Example 1</summary>

```js
[
  {
    0: { _: null, null: "a" },
    1: { _: "" },
  },
  {
    2: { null: "b" },
  },
];
```

</details>

### Built-In types

<i>The following GraphQlPlus isn't strictly valid but ...</i>

Boolean, Null, Unit and Void are effectively enum types as follows:

```gqlp
enum Boolean [bool, ^] { false true }

enum Null [null] { null }

enum Unit [_] { _ }

enum Void { }  // no valid value
```

Number and String are effectively domain types as follows:

```gqlp
domain Number [int, 0] { Number }

domain String [str, *] { String }
```

Basic, Internal and \_Key are effectively unions of the following types:

```gqlp
union _Basic [Basic] { Boolean Number String Unit }

union _Internal [Internal] { Null Void }

union _Key [Key] { _Basic _Internal _Simple }
```

Object is a general Dictionary as follows:

```gqlp
"%"
dual _Object [Object, obj, %] { :_Map<Any> } // recursive!

dual _Most<$T:_Any> [Most] { $T | Object | _Most<$T>? | _MostList<$T> | _MostDictionary<$T> } // recursive!
dual _MostList<$T:_Any> { _Most<$T>[] } // recursive!
dual _MostDictionary<$T:_Any> { _Most<$T>[_Key?] } // recursive!

dual _Any [Any] { :_Most<_Dual> }
input _Any [Any] { :_Most<_Input> }
output _Any [Any] { :_Most<_Output> }
union _Any [Any] { _Basic _Internal _Simple }
```

The internal types `_Union [Union]`, `_Output [Output]`, `_Input [Input]`, `_Enum [Enum]`, `_Dual [Dual]`
and `_Domain [Domain]` are automatically defined to be a union of all user defined Union, Domain, Output, Input,
Enum and Dual types respectively, as follows:

```gqlp
union _Domain [Domain] { } // All user defined Domain types
dual _Dual [Dual] { } // All user defined Dual types
union _Enum [Enum] { } // All user defined Enum types
input _Input [Input] { } // All user defined Input types
output _Output [Output] { } // All user defined Output types
union _Union [Union] { } // All user defined Union types

union _Simple [Simple] { _Enum _Domain _Union }
```

## Values

```PEG
Value = Value_List | Value_Object | Value_Scalar
Value_Scalar = NUMBER | STRING | Boolean | 'null' | '_' | EnumValue
Value_List = '[' Value_Scalar* ']'
Value_Values = Value ',' Value_Scalar | Value

Value_Object = '{' Value_Fields* '}'
Value_Fields = Value_Field ',' Value_Fields | Value_Field
Value_Field = FieldKey ':' Value_Scalar
```

A Value is a single value. Commas (`,`) can be used to separate list values and object fields.

If a Value Object FieldKey appears more than once, all the values will be merged as follows:

> A merged with B results as follows:
>
> |                         | B Value `b` |       B List `[b1,b2]` | B Object `{k:b3,b4:b5}` |
> | ----------------------: | ----------: | ---------------------: | ----------------------: |
> |             A Value `a` |         `b` |            `[a,b1,b2]` |          `{k:b3,b4:b5}` |
> |        A List `[a1,a2]` | `[a1,a2,b]` |        `[a1,a2,b1,b2]` |  `[a1,a2,{k:b3,b4:b5}]` |
> | A Object `{k:a3,a4:a5}` |         `b` | `[{k:a3,a4:a5},b1,b2]` |    `{k:b3,a4:a5,b4:b5}` |
>
> ie:
>
> 1. If either value is a List, the merged value is a List with the A value(s) first then the B value(s)
> 2. If both values are Objects, the keys are combined and any common keys value's are merged.
> 3. Otherwise the B value is used.

## Complete Grammar

```PEG
Default = '=' Value

EnumValue = ( enum '.' )? label

FieldKey = EnumValue | NUMBER | STRING

Boolean = 'false' | 'true'

Simple = Basic | enum
Basic = 'Boolean' | '^' | 'Number' | '0' | 'String' | '*' | 'Unit' | '_'

Internal = 'Void' | 'Null' | 'null'

Modifiers = Collections? '?'?
Collections = '[]' Collections? | '[' Collection_Key '?'? ']' Collections?
Collection_Key = Simple // Redefined in Schema

Value = Value_List | Value_Object | Value_Scalar
Value_Scalar = NUMBER | STRING | Boolean | 'null' | '_' | EnumValue
Value_List = '[' Value_Scalar* ']'
Value_Values = Value ',' Value_Scalar | Value

Value_Object = '{' Value_Fields* '}'
Value_Fields = Value_Field ',' Value_Fields | Value_Field
Value_Field = FieldKey ':' Value_Scalar

```
