# Requests Samples

## Root

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
