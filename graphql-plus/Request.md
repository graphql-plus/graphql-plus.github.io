# Request Definition

A GraphQL+ Request is defined as follows.

## Request

```gqlp
input Request {
        category: _Identifier? = null
        operation: _Identifier? = null
        definition: _Operation
        parameters: Any? = null
    |   String
}

domain _Identifier { String /[A-Za-z_][A-Za-z0-9_]*/ }
```

## Operation

```gqlp
input _Operation {
        variables: _OpVariable[]
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
    | String // Parsed into above fields
}

input _OpVariable {
        name: _Identifier
        type: _Identifier? = null
        modifiers: _Modifiers[]
        default: String? # Todo: _OpDefault
        directives: _OpDirective[]
}

dual _OpDirective {
        name: _Identifier
        argument: String? # Todo: _OpArgument
}

input _OpFragment {
        name: _Identifier
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
}

input _OpResult {
        domain: _Identifier? = null
        argument: String? # Todo: _OpArgument
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
        argument: String? # Todo: _OpArgument
        modifiers: _Modifiers
        directives: _OpDirective[]
        body: _OpObject[]
}

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
}

dual _OpSpread {
        fragment: _Identifier
        directives: _OpDirective[]}
```

## Complete Definition

```gqlp
input Request {
        category: _Identifier? = null
        operation: _Identifier? = null
        definition: _Operation
        parameters: Any? = null
    |   String
}

domain _Identifier { String /[A-Za-z_][A-Za-z0-9_]*/ }

input _Operation {
        variables: _OpVariable[]
        directives: _OpDirective[]
        fragments: _OpFragment[]
        result: _OpResult
    | String // Parsed into above fields
}

input _OpVariable {
        name: _Identifier
        type: _Identifier? = null
        modifiers: _Modifiers[]
        default: String? # Todo: _OpDefault
        directives: _OpDirective[]
}

dual _OpDirective {
        name: _Identifier
        argument: String? # Todo: _OpArgument
}

input _OpFragment {
        name: _Identifier
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
}

input _OpResult {
        domain: _Identifier? = null
        argument: String? # Todo: _OpArgument
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
        argument: String? # Todo: _OpArgument
        modifiers: _Modifiers
        directives: _OpDirective[]
        body: _OpObject[]
}

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
}

dual _OpSpread {
        fragment: _Identifier
        directives: _OpDirective[]}

```
