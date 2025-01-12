# ValidSimple Schema Samples

### domain-enum-all-parent.graphql+

```gqlp
domain DomEnumAllParent { enum EnumDomAllParent.* }
enum EnumDomAllParent { :EnumDomParentAll dom_all_parent }
enum EnumDomParentAll { dom_enum_all_parent }
```

### domain-enum-all.graphql+

```gqlp
domain DomEnumAll { enum EnumDomAll.* }
enum EnumDomAll { dom_all dom_enum_all }
```

### domain-enum-member.graphql+

```gqlp
domain DomMember { enum dom_member }
enum MemberDom { dom_member }
```

### domain-enum-parent.graphql+

```gqlp
domain DomEnumPrnt { :DomPrntEnum Enum both_enum }
domain DomPrntEnum { Enum both_parent }
enum EnumDomBoth { both_enum both_parent }
```

### domain-enum-unique-parent.graphql+

```gqlp
enum EnumDomUniqueParent { :EnumDomParentUnique value }
enum EnumDomParentUnique { enum_dom_parent_dup }
enum EnumDomDupParent { enum_dom_parent_dup }
# domain DomEnumUniqueParent { enum EnumDomUniqueParent.* !EnumDomUniqueParent.enum_dom_parent_dup EnumDomDupParent.enum_dom_parent_dup }
```

### domain-enum-unique.graphql+

```gqlp
enum EnumDomUnique { eum_dom_value eum_dom_dup }
enum EnumDomDup { eum_dom_dup }
# domain DomEnumUnique { enum EnumDomUnique.* !EnumDomUnique.eum_dom_dup EnumDomDup.eum_dom_dup }
```

### domain-enum-value-parent.graphql+

```gqlp
domain DomEnumParent { Enum EnumDomParent.dom_enum_parent }
enum EnumDomParent { :EnumParentDom dom_parent_enum }
enum EnumParentDom { dom_enum_parent }
```

### domain-enum-value.graphql+

```gqlp
domain DomEnum { Enum EnumDom.dom_enum }
enum EnumDom { dom_enum }
```

### domain-number-parent.graphql+

```gqlp
domain DomNumPrnt { :DomPrntNum Number 2>}
domain DomPrntNum { Number <2 }
```

### domain-parent.graphql+

```gqlp
domain DomPrntTest { :DomTestPrnt Boolean false }
domain DomTestPrnt { Boolean true }
```

### domain-string-parent.graphql+

```gqlp
domain DomStrPrnt { :DomPrntStr String /a+/ }
domain DomPrntStr { String /b+/ }
```

### enum-parent-alias.graphql+

```gqlp
enum EnPrntAlias { :EnAliasPrnt val_prnt_alias val_alias[alias_val] }
enum EnAliasPrnt { val_alias }
```

### enum-parent-dup.graphql+

```gqlp
enum EnPrntDup { :EnDupPrnt val_prnt_dup  }
enum EnDupPrnt { val_dup[val_prnt_dup] }
```

### enum-parent.graphql+

```gqlp
enum EnTestPrnt { :EnPrntTest val_prnt }
enum EnPrntTest { val_test }
```

### union-parent.graphql+

```gqlp
union UnionPrnt { :PrntUnion String }
union PrntUnion { Number }
```
