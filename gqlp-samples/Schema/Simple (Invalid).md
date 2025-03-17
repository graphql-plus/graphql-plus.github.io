# Simple (Invalid) Schema Samples

### Simple\Invalid\domain-diff-kind.graphql+

```gqlp
domain Test { string }
domain Test { number }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged`
- `Group of Domain for 'Test' is not singular Domain['Number', 'String']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\domain-dup-alias.graphql+

```gqlp
domain Test [a] { Boolean }
domain Dup [a] { Boolean }
```

##### Expected Verify errors

- `Multiple Domains with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\domain-enum-none.graphql+

```gqlp
domain Test { Enum }
```

##### Expected Verify errors

- `Invalid Domain. Expected enum Members`

### Simple\Invalid\domain-enum-parent-unique.graphql+

```gqlp
domain Test { :Parent Enum Enum.value }
domain Parent { Enum Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items`
- `Group of DomainMember for 'value' is not singular Excludes~EnumType['False~Dup', 'False~Enum']`

### Simple\Invalid\domain-enum-undef-all.graphql+

```gqlp
domain Test { enum Undef.* }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Undef' not an Enum type`

### Simple\Invalid\domain-enum-undef-member.graphql+

```gqlp
domain Test { enum Enum.undef }
enum Enum { value }
```

##### Expected Verify errors

- `Invalid Domain Enum Value. 'undef' not a Value of 'Enum'`

### Simple\Invalid\domain-enum-undef-value.graphql+

```gqlp
domain Test { enum Undef.value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Undef' not an Enum type`

### Simple\Invalid\domain-enum-undef.graphql+

```gqlp
domain Test { enum undef }
```

##### Expected Verify errors

- `Invalid Domain Enum Member. Enum Value 'undef' not defined`

### Simple\Invalid\domain-enum-unique-all.graphql+

```gqlp
domain Test { enum Enum.* Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup`

### Simple\Invalid\domain-enum-unique-member.graphql+

```gqlp
domain Test { enum Enum.value Dup.* }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup`

### Simple\Invalid\domain-enum-unique.graphql+

```gqlp
domain Test { enum Enum.value Dup.value }
enum Enum { value }
enum Dup { value }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'value' duplicated from these Enums: Enum Dup`

### Simple\Invalid\domain-enum-wrong.graphql+

```gqlp
domain Test { enum Bad.value }
output Bad { }
```

##### Expected Verify errors

- `Invalid Domain Enum. 'Bad' not an Enum type`

### Simple\Invalid\domain-number-parent.graphql+

```gqlp
domain Test { :Parent number 1> }
domain Parent { number !1> }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items`
- `Group of DomainRange for '1 >' is not singular Range['False', 'True']`

### Simple\Invalid\domain-parent-self-more.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :More Boolean }
domain More { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test`
- `Invalid Domain. 'Recurse' cannot be a child of itself, even recursively via Parent`
- `Invalid Domain. 'More' cannot be a child of itself, even recursively via Recurse`

### Simple\Invalid\domain-parent-self-parent.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via Parent`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test`

### Simple\Invalid\domain-parent-self-recurse.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { :Recurse Boolean }
domain Recurse { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Domain. 'Parent' cannot be a child of itself, even recursively via Test`
- `Invalid Domain. 'Recurse' cannot be a child of itself, even recursively via Parent`

### Simple\Invalid\domain-parent-self.graphql+

```gqlp
domain Test { :Test Boolean }
```

##### Expected Verify errors

- `Invalid Domain. 'Test' cannot be a child of itself`

### Simple\Invalid\domain-parent-undef.graphql+

```gqlp
domain Test { :Parent Boolean }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' not defined`

### Simple\Invalid\domain-parent-wrong-kind.graphql+

```gqlp
domain Test { :Parent Boolean }
domain Parent { String }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' invalid domain. Found 'String'`

### Simple\Invalid\domain-parent-wrong-type.graphql+

```gqlp
domain Test { :Parent Boolean }
output Parent { }
```

##### Expected Verify errors

- `Invalid Domain Parent. 'Parent' invalid type. Found 'Output'`

### Simple\Invalid\domain-string-diff.graphql+

```gqlp
domain Test { string /a+/}
domain Test { string !/a+/ }
```

##### Expected Verify errors

- `Multiple Domains with name 'Test' can't be merged`
- `Group of DomainRegex for 'a+' is not singular Regex['False', 'True']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\domain-string-parent.graphql+

```gqlp
domain Test { :Parent string /a+/}
domain Parent { string !/a+/ }
```

##### Expected Verify errors

- `Invalid Domain Child. Can't merge Test items into Parent Parent items`
- `Group of DomainRegex for 'a+' is not singular Regex['False', 'True']`

### Simple\Invalid\enum-dup-alias.graphql+

```gqlp
enum Test [a] { test }
enum Dup [a] { dup }
```

##### Expected Verify errors

- `Multiple Enums with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\enum-parent-alias-dup.graphql+

```gqlp
enum Test { :Parent test[alias] }
enum Parent { parent[alias] }
```

##### Expected Verify errors

- `Invalid Enum Child. Can't merge Test into Parent Parent`
- `Aliases of EnumItem for 'alias' is not singular Name['parent', 'test']`

### Simple\Invalid\enum-parent-diff.graphql+

```gqlp
enum Test { :Parent test }
enum Test { test }
enum Parent { parent }
```

##### Expected Verify errors

- `Multiple Enums with name 'Test' can't be merged`
- `Group of Enum for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\enum-parent-undef.graphql+

```gqlp
enum Test { :Parent test }
```

##### Expected Verify errors

- `Invalid Enum Parent. 'Parent' not defined`

### Simple\Invalid\enum-parent-wrong.graphql+

```gqlp
enum Test { :Parent test }
output Parent { }
```

##### Expected Verify errors

- `Invalid Enum Parent. 'Parent' invalid type. Found 'Output'`

### Simple\Invalid\union-dup-alias.graphql+

```gqlp
union Test [a] { String }
union Dup [a] { Number }
```

##### Expected Verify errors

- `Multiple Unions with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\union-more-parent.graphql+

```gqlp
union Test { Recurse }
union Recurse { :Parent }
union Parent { More }
union More { :Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union. Expected at least one member`

### Simple\Invalid\union-more.graphql+

```gqlp
union Test { Bad }
union Bad { More }
union More { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`
- `Invalid Union Member. 'More' cannot refer to self, even recursively`

### Simple\Invalid\union-parent-diff.graphql+

```gqlp
union Test { :Parent Number }
union Test { Number }
union Parent { String }
```

##### Expected Verify errors

- `Multiple Unions with name 'Test' can't be merged`
- `Group of Union for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Simple\Invalid\union-parent-more.graphql+

```gqlp
union Test { :Parent String }
union Parent { More }
union More { :Bad String }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'More' cannot refer to self, even recursively`

### Simple\Invalid\union-parent-recurse.graphql+

```gqlp
union Test { :Parent String }
union Parent { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`

### Simple\Invalid\union-parent-undef.graphql+

```gqlp
union Test { :Parent Number }
```

##### Expected Verify errors

- `Invalid Union Parent. 'Parent' not defined`

### Simple\Invalid\union-parent-wrong.graphql+

```gqlp
union Test { :Parent Number }
output Parent { }
```

##### Expected Verify errors

- `Invalid Union Parent. 'Parent' invalid type. Found 'Output'`

### Simple\Invalid\union-parent.graphql+

```gqlp
union Test { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`

### Simple\Invalid\union-recurse-parent.graphql+

```gqlp
union Test { Bad }
union Bad { :Parent String }
union Parent { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`

### Simple\Invalid\union-recurse.graphql+

```gqlp
union Test { Bad }
union Bad { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self, even recursively`
- `Invalid Union Member. 'Bad' cannot refer to self, even recursively`

### Simple\Invalid\union-self.graphql+

```gqlp
union Test { Test }
```

##### Expected Verify errors

- `Invalid Union Member. 'Test' cannot refer to self`

### Simple\Invalid\union-undef.graphql+

```gqlp
union Test { Bad }
```

##### Expected Verify errors

- `Invalid Union. 'Bad' not defined`

### Simple\Invalid\union-wrong.graphql+

```gqlp
union Test { Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid union. Type kind mismatch for Bad. Found Input`

### Simple\Invalid\unique-type-alias.graphql+

```gqlp
enum Test [a] { Value }
output Dup [a] { }
```

##### Expected Verify errors

- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

### Simple\Invalid\unique-types.graphql+

```gqlp
enum Test { Value }
output Test { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`
- `Group of Type for 'Test' is not singular Type['Enum', 'Output']`
