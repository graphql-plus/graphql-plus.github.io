# Encoding and Decoding

GraphQL+ is decoded from and encoded into simple values using the following rules.

Simple values are either:

- a string, numeric or boolean value
- a list of simples values, possibly empty
- a map of strings (keys) to values, possibly empty

Simple values may also have a tag.

## Decoding GraphQL+ Requests

A GraphQL+ request must have a definition and may have a category, operation and parameters.
Category and operation are identifiers and parameters may have any type.

Simple GraphQL+ requests can have the category, operation, definition and parameter values set by side-channel means,
ie. HTTP Request Headers, URI path segments, URI parameters, filename sections, etc.

### Decoding the request body

- If the definition has been specified by side-channel means, the body of the request will treated as parameters.
- If the body of the request is empty, a boolean or a number, this is an error.
- If the body of the request is a string, it will be interpreted as the definition.
- If the body of the request is a list, the first string value will be interpreted as the definition,
  with the remaining values being interpreted as parameters.
- If the body of the request is a map, it must have the key `definition` which will be the definition
  and may have the keys `category`, `operation`, and `parameters` with the values being interpreted as above.

### Decoding request parameters

Parameters will be decoded from their input values into their expected GraphQL+ types differently
if they are Plain or Tagged values.

## Decoding simple values

A Plain value is one that is a list, doesn't have a tag, or has a tag that doesn't match any known type.
A warning is raised when a list has a tag or any tag doesn't match the known GraphQL+ type.

A Tagged value has a tag that matches a known GraphQL+ type.

### Decoding to Union Members or Object Alternate

If the expected type is a Union,
the value is attempted to be decoded to each of the Union's Members, in order of definition.

Similarly if the expected type is an Object type with Alternates,
first the value is attempted to be decoded to the Object's fields,
if that fails, the value is attempted to be decoded to each of the Alternates, in order of definition.

In both cases the first successful decoding is used.
All warnings raised during all the decoding attempts are also raised.
If none of the Members or Alternates can decode the value, an error is raised.

### Decoding to Type with a List modifier

If the expected type has a list modifier, and the input is **NOT** a list,
the value is decoded to the type and, successful, set to be the only value in the resulting list.

### Decoding a Tagged value

If the Tagged value's tag matches the expected type, the value is decoded as a Plain value of that type.
If the Tagged value's tag doesn't match the expected type, an error is raised.

### Decoding Plain scalar values

| Expected type | String               | Number                | Boolean               |
| ------------- | -------------------- | --------------------- | --------------------- |
| \_Set<T>, T[] | as T, [v]            | as T, [v]             | as T, [v]             |
| object, T[K]  | _Error_              | _Error_               | _Error_               |
| String        | _Used_               | _Text_                | _Text_                |
| Number        | Parse number         | _Used_                | true => 1, false => 0 |
| Boolean       | "true", "false"      | 1 => true, 0 => false | _Used_                |
| Enum          | Parse label or alias | n => label            | _Error_               |
| Domain        | See below            | See below             | See below             |

If the expected type is a matching Domain type, the value is decoded,
then if it is valid by the Domain constraints it is used.
Otherwise an error is raised.

In the various mapping cases (ie. x => y) above, if the input can be mapped into the expected type,
a warning is raised, otherwise an error is raised.

In the Parse cases above, if the Parsing fails, an error is raised.

### Decoding List values

If the expected type has a list modifier, each value in the list is decoded into the expected type.

If the expected type has an optional modifier, and the list has no values,
the result is `null` and a warning is raised.

If the expected type has a dictionary modifier, an error is raised.

If the expected type has no modifiers, and the list has one value, it is decoded into the expected type.
If the list has no values or more than one value, an error is raised.

If the expected type is a Set, duplicate values are removed. If any duplicates are removed, a warning is raised.

In all other cases an error is raised.

### Plain map values

If the expected type has a dictionary modifier, for each key / value pair,
the key is decoded to the key type and the value is decoded to the value type.
If all key value pairs are successfully decoded,
the result is a dictionary of the decoded key / decode value pairs.

If the expected type has an optional modifier, and the object has no keys,
the result is `null` and a warning is raised.

If the expected type is an Object type, all keys must match fields in the expected type and
all values must be successfully decoded to the respective field's type.
Also all fields in the expected type not matched by a key must either have a default value or have a modifier.

In all other cases an error is raised.

## Encoding GraphQL+ Responses

### Simple responses

Simple responses will have the category, operation and warnings returned by side-channel means,
ie. HTTP Response Headers, filename sections, etc.

The response value will either be the representation of the GraphQL+ response or a list of errors.

### Complex responses

Complex GraphQL+responses will be a map which will have `category` and `operation` keys
and include one or more of the keys `errors`, `warnings`, `request` and `response`.

The `category`, `request` and `operation` keys will be strings.
The `errors` and `warnings` keys will be lists of strings or error objects.
The `response` key will be the representation of the GraphQL+ response.

```yaml
category: Query
operation: All
request: "All { items { strings } alternates }"
warnings:
  - "Warning 1"
  - "Warning 2"
errors: []
response:
  items:
    - strings: ["one", "two", "three"]
  alternates: "test"
```

## Encoding GraphQL+ values

GraphQL+ values, except for plain values and lists, are always output with a tag of the name of the GraphQL+ Type.
Note that Type aliases should never appear in a response.

### Built-In values

Plain String, Number and Boolean values are output as plain values, without a tag.
Null, Unit and Void "values" are output as `null`, `_` and `~` respectively, with a tag.

Types with List or Dictionary modifiers are output as simple lists and dictionaries.
Dictionaries will have a tag.

```yaml
"test"
123
true
!Null null
!Unit _
!Void ~
[a,b]
!Map(String)
  a: a
  b: b
```

### Simple values

Domain values are output in the same fashion as the Domain base type but with the Domain name as the tag.

Enum values are output as the Label name with the Enum name as the tag.
Note that Label aliases should never appear in a response.

Union values are output as the specific type, with that type's tag.

```yaml
!EnumType Two
!DomainType 123
```

### Object values

Objects are either output as a dictionary with the keys being the field names or as the specific Alternate type.

```yaml
!Object
field1: value1
field2: value2
```
