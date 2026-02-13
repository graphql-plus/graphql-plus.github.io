# Request Samples

## Root

### categories.g+req

```
_Schema { categories { name } }
```

##### Expected response categories.resp

```
types:
  _TypeInput:
    name: _TypeInput
    typeKind: Input
    parent:
      name: _TypeObject
```

### categories.resp

```
types:
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
  _TypeInput:
    name: _TypeInput
    typeKind: Input
    parent:
      name: _TypeObject
```

### enum-types.resp

```
types:
  _TypeInput:
    name: _TypeInput
    typeKind: Input
    parent:
      name: _TypeObject
```
