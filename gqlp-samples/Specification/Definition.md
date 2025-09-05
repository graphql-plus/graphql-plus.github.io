# Definition Specification Samples

### +Common.graphql+

```gqlp
enum Boolean [bool, ^] { false true }

enum Null [null] { null }

enum Unit [_] { _ }

"No valid value"enum Void { }

domain Number [int, 0] { Number }

domain String [str, *] { String }

union _Basic [Basic] { Boolean Number String Unit }

union _Internal [Internal] { Null Void }

union _Key [Key] { _Basic _Internal _Simple }

"%"
dual _Object [Object, obj, %] { }

"All user defined Domain types" union _Domain [Domain] { }
"All user defined Dual types" dual _Dual [Dual] { }
"All user defined Enum types" union _Enum [Enum] { }
"All user defined Input types" input _Input [Input] { }
"All user defined Output types" output _Output [Output] { }
"All user defined Union types" union _Union [Union] { }

union _Simple [Simple] { _Enum _Domain _Union }

```

### Built-In.graphql+

```gqlp
enum Boolean [bool, ^] { false true }

enum Null [null] { null }

enum Unit [_] { _ }

"No valid value"enum Void { }

domain Number [int, 0] { Number }

domain String [str, *] { String }

union _Basic [Basic] { Boolean Number String Unit }

union _Internal [Internal] { Null Void }

union _Key [Key] { _Basic _Internal _Simple }

"%"
dual _Object [Object, obj, %] { }

"All user defined Domain types" union _Domain [Domain] { }
"All user defined Dual types" dual _Dual [Dual] { }
"All user defined Enum types" union _Enum [Enum] { }
"All user defined Input types" input _Input [Input] { }
"All user defined Output types" output _Output [Output] { }
"All user defined Union types" union _Union [Union] { }

union _Simple [Simple] { _Enum _Domain _Union }

```

### Values.graphql+

```gqlp
dual _Value[Value] {
    | _ValueScalar
    | _ValueList
    | _ValueMap
    }

dual _ValueScalar {
    | _Basic
    | _Internal
    | _Simple
    }

dual _ValueList {
    | _Value[]
    }

dual _ValueMap {
    | _Value[_ValueBuiltIn]
    }

union _ValueBuiltIn { Boolean Number String Unit Null }

```
