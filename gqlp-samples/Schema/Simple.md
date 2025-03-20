# Simple Schema Samples

### domain-bool-descr.graphql+

```gqlp
domain DomBoolDescr { Boolean "DomBool" "Descr" true }
```

### domain-bool-parent.graphql+

```gqlp
domain DomBoolPrntTest { :DomBoolTestPrnt Boolean false }
domain DomBoolTestPrnt { Boolean true }
```

### domain-enum-all-descr.graphql+

```gqlp
domain DomEnumAll { enum "DomAll" "Descr" EnumDomAll.* }
enum EnumDomAll { dom_all dom_enum_all }
```

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

### domain-enum-descr.graphql+

```gqlp
domain DomEnumDescr { enum "DomEnum" "Descr" dom_label_desc }
enum EnumDomDescr { dom_label_desc }
```

### domain-enum-label.graphql+

```gqlp
domain DomLabel { enum dom_label }
enum LabelDom { dom_label }
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

### domain-number-descr.graphql+

```gqlp
domain DomNumDescr { Number "DomNumber" "Descr" <2 }
```

### domain-number-parent.graphql+

```gqlp
domain DomNumPrnt { :DomPrntNum Number 2>}
domain DomPrntNum { Number <2 }
```

### domain-string-descr.graphql+

```gqlp
domain DomStrDescr { String "DomString" "Descr" /a+/ }
```

### domain-string-parent.graphql+

```gqlp
domain DomStrPrnt { :DomPrntStr String /a+/ }
domain DomPrntStr { String /b+/ }
```

### enum-descr.graphql+

```gqlp
enum EnDescr { "Enum" "Descr" val_test }
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

### union-descr.graphql+

```gqlp
union UnionDescr { "Union" "Descr" Number }
```

### union-parent-dup.graphql+

```gqlp
union UnionPrnt { :PrntUnion Number }
union PrntUnion { Number }
```

### union-parent.graphql+

```gqlp
union UnionPrnt { :PrntUnion String }
union PrntUnion { Number }
```
