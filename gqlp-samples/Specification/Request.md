# Request Specification Samples

### +Request.graphql+

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
        default: _Value?
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

input _OpArgument {
    |   _OpArgScalar
    |   _OpArgList
    |   _OpArgObject
    }

input _OpArgScalar {
        variable: _Identifier
    |   _Value
    }

input _OpArgList {
    | _OpArgument[]
    }

input _OpArgObject {
    | _OpArgument[_OpArgScalar]
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
        body: _OpObject[]
    }

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
    }

dual _OpSpread {
        fragment: _Identifier
        directives: _OpDirective[]
    }

```

### Full.graphql+

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

##### Expected Verify errors

- `'_Operation' not defined`

### Operation.graphql+

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
        default: _Value?
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

input _OpArgument {
    |   _OpArgScalar
    |   _OpArgList
    |   _OpArgObject
    }

input _OpArgScalar {
        variable: _Identifier
    |   _Value
    }

input _OpArgList {
    | _OpArgument[]
    }

input _OpArgObject {
    | _OpArgument[_OpArgScalar]
    }

```

##### Expected Verify errors

- `'_Identifier' not defined`

### Result.graphql+

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
        body: _OpObject[]
    }

input _OpInline {
        type: _Identifier? = null
        directives: _OpDirective[]
        body: _OpObject[]
    }

dual _OpSpread {
        fragment: _Identifier
        directives: _OpDirective[]
    }

```
