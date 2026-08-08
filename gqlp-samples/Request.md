# Request Samples

## Root

### categories.g+req

```
_Schema { categories { name } }
```

##### Expected response categories.resp

```
categories:
  _TypeInput:
    name: _TypeInput
    typeKind: Input
    parent:
      name: _TypeObject
```

### categories.resp

```
categories:
  _TypeInput:
    name: _TypeInput
    typeKind: Input
    parent:
      name: _TypeObject
```

### dual-input-types.g+req

```
category = _Schema
definition = ($names[]) { types($names) { name typeKind parent { name } } }
parameters.names = *Dual*
parameters.names = *Input*
```

##### Expected response dual-input-types.resp

```
types:
  _TypeInput:
    name: _TypeInput
    typeKind: Input
    parent:
      name: _TypeObject
```

### dual-input-types.resp

```
types:
  _TypeInput:
    name: _TypeInput
    typeKind: Input
    parent:
      name: _TypeObject
```

### enum-types.g+req

```
category = _Schema
definition = ($filter) { types($filter) { name typeKind parent { name } } }
parameters.filter.kinds = Enum
```

##### Expected response enum-types.resp

```
types:
  _TypeEnum:
    name: _TypeEnum
    typeKind: Enum
```

### enum-types.resp

```
types:
  _TypeEnum:
    name: _TypeEnum
    typeKind: Enum
```

### format-list-with-params.gql+

```gqlp
["{user{id name email}}", {"userId": 42}, "additional_param"]
```

### format-map-full.gql+

```gqlp
{
  "definition": "{user{id name}}",
  "category": "query",
  "operation": "getUser",
  "parameters": {"id": 123}
}
```

### format-side-channel.gql+

```gqlp
{id name email address{street city}}
```

### format-string-definition.gql+

```gqlp
{name email}
```

### request-tagged-values.gql+

```gqlp
[!String "{id name}", !String "data"]
```

