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
parameters.names = Dual
parameters.names = Input
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

### format-list-with-params.g+req

```
definition = Sample {user{id name email}}
parameters.userId = 42
```

### format-map-full.g+req

```
category = Sample
operation = getUser
definition = {user{id name}}
parameters.id = 123
```

### format-side-channel.g+req

```
category = Sample
definition = {id name email address{street city}}
```

### format-string-definition.g+req

```
{name email}
```

### request-tagged-values.g+req

```
definition = {id name}
parameters = data
```

