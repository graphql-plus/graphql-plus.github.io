# Simple-Invalid Schema Samples

### domain-enum-none.graphql+

```gqlp
domain Test { Enum }
```

##### Expected Verify errors

- `Expected enum Labels`

### domain-enum-parent-unique.graphql+

```gqlp
domain Test { :Parent Enum Enum.value }
domain Parent { Enum Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Can't merge Test items into Parent Parent items`
- `Group of DomainLabel for 'value' not singular Excludes~EnumType['False~Dup', 'False~Enum']`

### domain-enum-undef-all.graphql+

```gqlp
domain Test { enum Undef.* }
```

##### Expected Verify errors

- `'Undef' not an Enum type`

### domain-enum-undef-member.graphql+

```gqlp
domain Test { enum Enum.undef }
enum Enum { value }
```

##### Expected Verify errors

- `'undef' not a Value of 'Enum'`

### domain-enum-undef-value.graphql+

```gqlp
domain Test { enum Undef.value }
```

##### Expected Verify errors

- `'Undef' not an Enum type`

### domain-enum-undef.graphql+

```gqlp
domain Test { enum undef }
```

##### Expected Verify errors

- `Enum Value 'undef' not defined`

### domain-enum-unique-all.graphql+

```gqlp
domain Test { enum Enum.* Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `'value' duplicated from these Enums: Enum Dup`

### domain-enum-unique-member.graphql+

```gqlp
domain Test { enum Enum.value Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `'value' duplicated from these Enums: Enum Dup`

### domain-enum-unique.graphql+

```gqlp
domain Test { enum Enum.value Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `'value' duplicated from these Enums: Enum Dup`

### domain-enum-wrong.graphql+

```gqlp
domain Test { enum Bad.value }
output Bad { }
```

##### Expected Verify errors

- `'Bad' not an Enum type`

### domain-number-parent.graphql+

```gqlp
domain Test { :Parent number 1> }
domain Parent { number !1> }
```

##### Expected Verify errors

- `Can't merge Test items into Parent Parent items`
- `Group of DomainRange for '1 >' not singular Range['False', 'True']`

### domain-parent-self-more.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :More Boolean }
domain More { :Test Boolean }
```

##### Expected Verify errors

- `'Test' cannot be a child of itself, even recursively via More`
- `'Parent' cannot be a child of itself, even recursively via Test`
- `'Recurse' cannot be a child of itself, even recursively via Parent`
- `'More' cannot be a child of itself, even recursively via Recurse`

### domain-parent-self-parent.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Test Boolean }
```

##### Expected Verify errors

- `'Test' cannot be a child of itself, even recursively via Parent`
- `'Parent' cannot be a child of itself, even recursively via Test`

### domain-parent-self-recurse.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :Test Boolean }
```

##### Expected Verify errors

- `'Test' cannot be a child of itself, even recursively via Recurse`
- `'Parent' cannot be a child of itself, even recursively via Test`
- `'Recurse' cannot be a child of itself, even recursively via Parent`

### domain-parent-self.graphql+

```gqlp
domain Test { :Test Boolean }
```

##### Expected Verify errors

- `'Test' cannot be a child of itself`

### domain-parent-undef.graphql+

```gqlp
domain Test { :Parent Boolean }
```

##### Expected Verify errors

- `'Parent' not defined`

### domain-parent-wrong-kind.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { String }
```

##### Expected Verify errors

- `'Parent' invalid domain. Found 'String'`

### domain-parent-wrong-type.graphql+

```gqlp
domain Test { :Parent Boolean }
output Parent { }
```

##### Expected Verify errors

- `'Parent' invalid type. Found 'Output'`

### domain-string-parent.graphql+

```gqlp
domain Test { :Parent string /a+/}
domain Parent { string !/a+/ }
```

##### Expected Verify errors

- `Can't merge Test items into Parent Parent items`
- `Group of DomainRegex for 'a+' not singular Regex['False', 'True']`

### enum-dup-alias.graphql+

```gqlp
enum Test [a] { test }
enum Dup [a] { dup }
```

##### Expected Verify errors

- `Multiple Enums with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### enum-parent-alias-dup.graphql+

```gqlp
enum Test { :Parent test[alias] }
enum Parent { parent[alias] }
```

##### Expected Verify errors

- `Can't merge Test into Parent Parent`
- `Aliases of EnumLabel for 'alias' not singular Name['parent', 'test']`

### enum-parent-undef.graphql+

```gqlp
enum Test { :Parent test }
```

##### Expected Verify errors

- `'Parent' not defined`

### enum-parent-wrong.graphql+

```gqlp
enum Test { :Parent test }
output Parent { }
```

##### Expected Verify errors

- `'Parent' invalid type. Found 'Output'`

### union-more-parent.graphql+

```gqlp
union Test { Recurse }
union Recurse { :Parent }
union Parent { More }
union More { :Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Expected at least one member`

### union-more.graphql+

```gqlp
union Test { Bad }
union Bad { More }
union More { Test }
```

##### Expected Verify errors

- `'Test' cannot refer to self, even recursively`
- `'Bad' cannot refer to self, even recursively`
- `'More' cannot refer to self, even recursively`

### union-parent-more.graphql+

```gqlp
union Test { :Parent String }
union Parent { More }
union More { :Bad String }
union Bad { Test }
```

##### Expected Verify errors

- `'Test' cannot refer to self, even recursively`
- `'More' cannot refer to self, even recursively`

### union-parent-recurse.graphql+

```gqlp
union Test { :Parent String }
union Parent { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `'Test' cannot refer to self, even recursively`
- `'Bad' cannot refer to self, even recursively`

### union-parent-undef.graphql+

```gqlp
union Test { :Parent Number }
```

##### Expected Verify errors

- `'Parent' not defined`

### union-parent-wrong.graphql+

```gqlp
union Test { :Parent Number }
output Parent { }
```

##### Expected Verify errors

- `'Parent' invalid type. Found 'Output'`

### union-parent.graphql+

```gqlp
union Test { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `'Test' cannot refer to self, even recursively`

### union-recurse-parent.graphql+

```gqlp
union Test { Bad }
union Bad { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `'Test' cannot refer to self, even recursively`
- `'Bad' cannot refer to self, even recursively`

### union-recurse.graphql+

```gqlp
union Test { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `'Test' cannot refer to self, even recursively`
- `'Bad' cannot refer to self, even recursively`

### union-self.graphql+

```gqlp
union Test { Test }
```

##### Expected Verify errors

- `'Test' cannot refer to self`

### union-undef.graphql+

```gqlp
union Test { Bad }
```

##### Expected Verify errors

- `'Bad' not defined`

### union-wrong.graphql+

```gqlp
union Test { Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### unique-type-alias.graphql+

```gqlp
enum Test [a] { Value }
output Dup [a] { }
```

##### Expected Verify errors

- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### unique-types.graphql+

```gqlp
enum Test { Value }
output Test { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`
- `Group of Type for 'Test' not singular Type['Enum', 'Output']`
