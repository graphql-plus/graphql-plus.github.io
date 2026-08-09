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
Note that this includes fully typing the Request's Parameters.
Decoding will proceed recursively through the entirety of the Request and Parameters.

Any decoding errors will cause Handling to not be attempted for the field where Error was raised.

A Warning message will be output for each Parameter supplied that wasn't used in the Decoding of the Response.

### Operation Selections

To cope with the recursive nature of an Operation definition,
Selections are stored as a Map by Selection Path of Lists of Selection.

A Selection Path begins with the name of the fragment (the operation's fragment name is the empty string),
followed by a dot separated list of indexes into the List of Selections defined for that fragment.

eq

```gql+
&name :Name { first list |{ salutation } |{ middle } }
{ name { |name } emailAddress |{ address { street city country } } |:Customer { customerId } }
```

resolves to :

> ["name"] = first last | |<br>
> ["name.3"] = salutation<br>
> ["name.4"] = middle<br>
> [""] = name emailAddress | |:Customer<br>
> [".1"] = |name<br>
> [".3"] = address <br>
> [".3.1"] = street city country<br>
> [".4"] = customerId

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

dual _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

dual _ModifierKeyed<$modifierKind:_ModifierKind> {
    : _Modifier<$modifierKind>
        by: _Identifier
        isOptional: Boolean
    }

dual _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

dual _Modifier<$modifierKind:_ModifierKind> {
        modifierKind: $modifierKind
    }
```

### Operation

```gqlp
input _Operation {
        variables: _OpVariable[]
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
        selections: _OpSelection[][_Path]
    | "Parsed into above fields, plus Request category and operation" String
    }

domain _Path { String /(\$([A-Za-z]\w*)?|\.+)?\d+(\.\d+)*/ }

dual _OpDirectives {
        name: _Identifier
        description: String[]
        directives: _OpDirective[]

}
input _OpVariable {
    : _OpDirectives
        type: _Identifier? = null
        modifiers: _Modifiers[]
        defaultValue: Value?
    }

dual _OpDirective {
        name: _Identifier
        argument: _OpArgument?
    }

input _OpFragment {
    : _OpDirectives
        type: _Identifier? = null
    }

input _OpResult {
        domain: _Identifier? = null
        argument: _OpArgument?
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

### Selections

```gqlp
input _OpSelection {
    |   _OpField
    |   _OpSpread
    |   _OpInline
    }

input _OpField {
    : _OpDirectives
        fieldAlias: _Identifier? = null
        argument: _OpArgument?
        modifiers: _Modifiers[]
    }

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
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

dual _Collections {
    | _Modifier<_ModifierKind.List>
    | _ModifierKeyed<_ModifierKind.Dictionary>
    | _ModifierKeyed<_ModifierKind.TypeParam>
    }

dual _ModifierKeyed<$modifierKind:_ModifierKind> {
    : _Modifier<$modifierKind>
        by: _Identifier
        isOptional: Boolean
    }

dual _Modifiers {
    | _Modifier<_ModifierKind.Optional>
    | _Collections
    }

enum _ModifierKind { Opt[Optional] List Dict[Dictionary] Param[TypeParam] }

dual _Modifier<$modifierKind:_ModifierKind> {
        modifierKind: $modifierKind
    }

input _Operation {
        variables: _OpVariable[]
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
        selections: _OpSelection[][_Path]
    | "Parsed into above fields, plus Request category and operation" String
    }

domain _Path { String /(\$([A-Za-z]\w*)?|\.+)?\d+(\.\d+)*/ }

dual _OpDirectives {
        name: _Identifier
        description: String[]
        directives: _OpDirective[]

}
input _OpVariable {
    : _OpDirectives
        type: _Identifier? = null
        modifiers: _Modifiers[]
        defaultValue: Value?
    }

dual _OpDirective {
        name: _Identifier
        argument: _OpArgument?
    }

input _OpFragment {
    : _OpDirectives
        type: _Identifier? = null
    }

input _OpResult {
        domain: _Identifier? = null
        argument: _OpArgument?
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

input _OpSelection {
    |   _OpField
    |   _OpSpread
    |   _OpInline
    }

input _OpField {
    : _OpDirectives
        fieldAlias: _Identifier? = null
        argument: _OpArgument?
        modifiers: _Modifiers[]
    }

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
    }

dual _OpSpread {
        fragment: _Identifier
        directives: _OpDirective[]
    }

```
