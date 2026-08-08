# Introspection Samples

## Root

### introspection-categories.gql+

```gqlp
{_Schema{categories{name}}}
```

### introspection-complex.gql+

```gqlp
{_Schema{categories{name category{:_Named{name}}}directives{name}types{name}settings{name}}}
```

### introspection-directives.gql+

```gqlp
{_Schema{directives(_Filter:{names:["@skip" "@include"]}){name}}}
```

### introspection-settings.gql+

```gqlp
{_Schema{settings{name}}}
```

### introspection-types.gql+

```gqlp
{_Schema{types(_TypeFilter:{kinds:["Object" "Input"]}){name}}}
```

