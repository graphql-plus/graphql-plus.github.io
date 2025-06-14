# Simple Schema Samples

### domain-bool-descr.graphql+

```gqlp
domain Name { Boolean "DomBool" "Descr" true }
```

### domain-bool-parent-descr.graphql+

```gqlp
domain Name { :"Parent comment"PrntName Boolean false }
domain PrntName { Boolean true }
```

### domain-bool-parent.graphql+

```gqlp
domain Name { :PrntName Boolean false }
domain PrntName { Boolean true }
```

### domain-enum-all-descr.graphql+

```gqlp
domain Name { enum "DomAll" "Descr" EnumName.* }
enum EnumName { name enum_name }
```

### domain-enum-all-parent.graphql+

```gqlp
domain Name { enum EnumName.* }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### domain-enum-all.graphql+

```gqlp
domain Name { enum EnumName.* }
enum EnumName { name enum_name }
```

### domain-enum-descr.graphql+

```gqlp
domain Name { enum "DomEnum" "Descr" name }
enum EnumName { name }
```

### domain-enum-label.graphql+

```gqlp
domain Name { enum name }
enum EnumName { name }
```

### domain-enum-parent-descr.graphql+

```gqlp
domain Name { :"Parent comment"PrntName Enum enum_name }
domain PrntName { Enum prnt_name }
enum EnumName { enum_name prnt_name }
```

### domain-enum-parent.graphql+

```gqlp
domain Name { :PrntName Enum enum_name }
domain PrntName { Enum prnt_name }
enum EnumName { enum_name prnt_name }
```

### domain-enum-unique-parent.graphql+

```gqlp
# domain Name { enum EnumName.* !PrntName.name DupName.name }
enum EnumName { :PrntName enum_name }
enum PrntName { name prnt_name }
enum DupName { name dup_name }
```

### domain-enum-unique.graphql+

```gqlp
# domain Name { enum EnumName.* !EnumName.name DupName.name }
enum EnumName { enum_name name }
enum EnumDomDup { name dup_name }
```

### domain-enum-value-parent.graphql+

```gqlp
domain Name { Enum EnumName.prnt_name }
enum EnumName { :PrntName name }
enum PrntName { prnt_name }
```

### domain-enum-value.graphql+

```gqlp
domain Name { Enum EnumName.name }
enum EnumName { name }
```

### domain-number-descr.graphql+

```gqlp
domain Name { Number "DomNumber" "Descr" <2 }
```

### domain-number-parent-descr.graphql+

```gqlp
domain Name { :"Parent comment"PrntName Number 2>}
domain PrntName { Number <2 }
```

### domain-number-parent.graphql+

```gqlp
domain Name { :PrntName Number 2>}
domain PrntName { Number <2 }
```

### domain-string-descr.graphql+

```gqlp
domain Name { String "DomString" "Descr" /a+/ }
```

### domain-string-parent-descr.graphql+

```gqlp
domain Name { :"Parent comment"PrntName String /a+/ }
domain PrntName { String /b+/ }
```

### domain-string-parent.graphql+

```gqlp
domain Name { :PrntName String /a+/ }
domain PrntName { String /b+/ }
```

### enum-descr.graphql+

```gqlp
enum Name { "Enum" "Descr" name }
```

### enum-parent-alias.graphql+

```gqlp
enum Name { :PrntName val_name prnt_name[name] }
enum PrntName { prnt_name }
```

### enum-parent-descr.graphql+

```gqlp
enum Name { : "Parent comment" PrntName name  }
enum PrntName { prnt_name }
```

### enum-parent-dup.graphql+

```gqlp
enum Name { :PrntName name  }
enum PrntName { prnt_name[name] }
```

### enum-parent.graphql+

```gqlp
enum Name { :PrntName name }
enum PrntName { prnt_name }
```

### union-descr.graphql+

```gqlp
union Name { "Union" "Descr" Number }
```

### union-parent-descr.graphql+

```gqlp
union Name { :"Parent comment"PrntName Number }
union PrntName { Number }
```

### union-parent-dup.graphql+

```gqlp
union Name { :PrntName Number }
union PrntName { Number }
```

### union-parent.graphql+

```gqlp
union Name { :PrntName String }
union PrntName { Number }
```
