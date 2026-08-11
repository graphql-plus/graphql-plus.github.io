# Request Samples

## Root

### categories.g+req

```
Content-Type: text/plain

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
Content-Type: application/x-simple

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
Content-Type: application/x-simple

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

### format-list-with-params.g+req

```
Content-Type: application/json

[
    "Sample {user{id name email}}",
    {"userId": 42},
    "additional_param"
]
```

### format-map-full.g+req

```
Content-Type: application/json

{
  "category": "Sample",
  "definition": "{user{id name}}",
  "operation": "getUser",
  "parameters": {"id": 123}
}
```

### format-side-channel.g+req

```
GQL-Category: Sample

{id name email address{street city}}
```

### format-string-definition.g+req

```
{name email}
```

### request-tagged-values.g+req

```
Content-Type: application/yaml

- !String "{id name}"
- !String "data"
```

