# GraphQL+ Request

A GraphQL+ Request must have a Definition and may have a Category, Operation and Parameters.
Category and Operation are identifiers and Parameters may have any type.

## Processing a Request

A Request is processed against a Schema to generate a Response by the following steps:

### Input decoding

Starting with the raw input of the GraphQL+ request, that input is parsed into a Simple type
which is then transformed into an untyped Request.

This Request is matched with a Schema by Category to find the expected Output type of this Request.

This Request is then Decoded using the expected Output type to create a typed Request.
Note that this include fully typing the Request's Parameters.
Decoding will proceed recursively though the entirety of the Request and Parameters.

Any decoding errors will cause Handling to not be attempted for the field where Error was raised.

A Warning message will be output for each Parameter supplied that wasn't used in the Decoding of the Response.

### Handling

Each top level field in the Request results in a call to the appropriate Handling function,
passing in any Parameters specified, and returning a value of the expected type of that field.

### Output encoding

The value returned for each top level field is encoded into a Simple type and then
combined into a Map keyed by the top level field name.

This Simple type is then converted into the expected Response format and
this Response output to the Originator of the Request along with any Decoding or Handling messages generated.

If requested the fully Typed Request is returned as a part of the response.

## Validating a Request

A Request can be Validated instead of Processed, in which case the Input decoding step is run
and then the fully typed Request and any Decoding messages are output.

## Request Definition

A GraphQL+ Request is defined as follows.

### Full definition

```gqlp
input _Request {
        category: _Identifier? = null
        operation: _Identifier? = null
        definition: _Operation
        parameters: Any? = null
    |   "Parsed into definition" String
    }

domain _Identifier { String /[A-Za-z_][A-Za-z0-9_]*/ }
```

### Operation

```gqlp
input _Operation {
        variables: _OpVariable[]
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
    | "Parsed into above fields, plus Request category and operation" String
    }

input _OpVariable {
        name: _Identifier
        type: _Identifier? = null
        modifiers: _Modifier[]
        default: Value?
        directives: _OpDirective[]
    }

dual _OpDirective {
        name: _Identifier
        argument: _OpArgument?
    }

input _OpFragment {
        name: _Identifier
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

input _Modifier {
        modifierKind: _ModifierKind
        by: _Identifier?
        optional: Boolean?
    }

dual _OpArgument {
    |   _OpArgValue
    |   _OpArgList
    |   _OpArgMap
    }

dual _OpArgValue {
        variable: _Identifier
    |   Value
    }

dual _OpArgList {
    | _OpArgValue[]
    }

dual _OpArgMap {
        value: _OpArgValue
        byVariable: _Identifier
    | _OpArgValue[Scalar]
    }
```

### Result

```gqlp
input _OpResult {
        domain: _Identifier? = null
        argument: _OpArgument?
        body: _OpObject[]
    }

input _OpObject {
    |   _OpField
    |   _OpSpread
    |   _OpInline
    }

input _OpField {
        alias: _Identifier? = null
        field: _Identifier
        argument: _OpArgument?
        modifiers: _Modifier[]
        directives: _OpDirective[]
        "The body as a string as we can't have nested objects."
        body: String
    }

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
        "The body as a string as we can't have nested objects."
        body: String
    }

dual _OpSpread {
        fragment: _Identifier
        directives: _OpDirective[]
    }
```

## Complete Definition

```gqlp
input _Request {
        category: _Identifier? = null
        operation: _Identifier? = null
        definition: _Operation
        parameters: Any? = null
    |   "Parsed into definition" String
    }

domain _Identifier { String /[A-Za-z_][A-Za-z0-9_]*/ }

input _Operation {
        variables: _OpVariable[]
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
    | "Parsed into above fields, plus Request category and operation" String
    }

input _OpVariable {
        name: _Identifier
        type: _Identifier? = null
        modifiers: _Modifier[]
        default: Value?
        directives: _OpDirective[]
    }

dual _OpDirective {
        name: _Identifier
        argument: _OpArgument?
    }

input _OpFragment {
        name: _Identifier
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

input _Modifier {
        modifierKind: _ModifierKind
        by: _Identifier?
        optional: Boolean?
    }

dual _OpArgument {
    |   _OpArgValue
    |   _OpArgList
    |   _OpArgMap
    }

dual _OpArgValue {
        variable: _Identifier
    |   Value
    }

dual _OpArgList {
    | _OpArgValue[]
    }

dual _OpArgMap {
        value: _OpArgValue
        byVariable: _Identifier
    | _OpArgValue[Scalar]
    }

input _OpResult {
        domain: _Identifier? = null
        argument: _OpArgument?
        body: _OpObject[]
    }

input _OpObject {
    |   _OpField
    |   _OpSpread
    |   _OpInline
    }

input _OpField {
        alias: _Identifier? = null
        field: _Identifier
        argument: _OpArgument?
        modifiers: _Modifier[]
        directives: _OpDirective[]
        "The body as a string as we can't have nested objects."
        body: String
    }

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
        "The body as a string as we can't have nested objects."
        body: String
    }

dual _OpSpread {
        fragment: _Identifier
        directives: _OpDirective[]
    }

```
