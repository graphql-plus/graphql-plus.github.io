# Objects (Invalid) Schema Samples

### Objects\Invalid\alt-diff-mod.graphql+

```gqlp
object Test { | Test1 }
object Test { | Test1[] }
object Test1 { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualAlternate for 'Test1' is not singular Modifiers['', '[]']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputAlternate for 'Test1' is not singular Modifiers['', '[]']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputAlternate for 'Test1' is not singular Modifiers['', '[]']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\alt-mod-undef-param.graphql+

```gqlp
object Test { | Alt[$a] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'a' not defined`

### Objects\Invalid\alt-mod-undef.graphql+

```gqlp
object Test { | Alt[Domain] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Domain' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'Domain' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'Domain' not defined`

### Objects\Invalid\alt-mod-wrong.graphql+

```gqlp
object Test { | Alt[Test] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Input

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Output

- `Invalid Modifier. 'Test' invalid type`

### Objects\Invalid\alt-more.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | More }
object More { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via More`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Recurse`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via More`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Recurse`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via More`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Recurse`

### Objects\Invalid\alt-recurse.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test`

### Objects\Invalid\alt-self.graphql+

```gqlp
object Test { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself`

### Objects\Invalid\alt-simple-param.graphql+

```gqlp
object Test { | Number<String> }
```

##### Expected Verify errors Dual

- `Invalid Dual Alternate. Args invalid on Number, given 1`

##### Expected Verify errors Input

- `Invalid Input Alternate. Args invalid on Number, given 1`

##### Expected Verify errors Output

- `Invalid Output Alternate. Args invalid on Number, given 1`

### Objects\Invalid\dual-alt-input.graphql+

```gqlp
dual Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-alt-output.graphql+

```gqlp
dual Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-alt-param-input.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-alt-param-output.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-field-input.graphql+

```gqlp
dual Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-field-output.graphql+

```gqlp
dual Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-field-param-input.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-field-param-output.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\dual-parent-input.graphql+

```gqlp
dual Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Input'`

### Objects\Invalid\dual-parent-output.graphql+

```gqlp
dual Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Output'`

### Objects\Invalid\dual-parent-param-input.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\dual-parent-param-output.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\field-alias.graphql+

```gqlp
object Test { field1 [alias]: Test }
object Test { field2 [alias]: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\field-diff-mod.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\field-diff-type.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test1 }
object Test1 { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\field-mod-undef-param.graphql+

```gqlp
object Test { field: Test[$a] }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'a' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'a' not defined`

### Objects\Invalid\field-mod-undef.graphql+

```gqlp
object Test { field: Test[Random] }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Random' not defined`

##### Expected Verify errors Input

- `Invalid Modifier. 'Random' not defined`

##### Expected Verify errors Output

- `Invalid Modifier. 'Random' not defined`

### Objects\Invalid\field-mod-wrong.graphql+

```gqlp
object Test { field: Test[Test] }
```

##### Expected Verify errors Dual

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Input

- `Invalid Modifier. 'Test' invalid type`

##### Expected Verify errors Output

- `Invalid Modifier. 'Test' invalid type`

### Objects\Invalid\field-simple-param.graphql+

```gqlp
object Test { field: String<0> }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. Args invalid on String, given 1`

##### Expected Verify errors Input

- `Invalid Input Field. Args invalid on String, given 1`

##### Expected Verify errors Output

- `Invalid Output Field. Args invalid on String, given 1`

### Objects\Invalid\generic-alt-undef.graphql+

```gqlp
object Test { | $type }
```

##### Expected Verify errors Dual

- `Invalid Dual Alternate. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Alternate. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Alternate. '$type' not defined`

### Objects\Invalid\generic-arg-less.graphql+

```gqlp
object Test { field: Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. Args mismatch, expected 1 given 0`

##### Expected Verify errors Input

- `Invalid Input Field. Args mismatch, expected 1 given 0`

##### Expected Verify errors Output

- `Invalid Output Field. Args mismatch, expected 1 given 0`

### Objects\Invalid\generic-arg-more.graphql+

```gqlp
object Test<$type> { field: Ref<$type> }
object Ref { }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. Args mismatch, expected 0 given 1`

##### Expected Verify errors Input

- `Invalid Input Field. Args mismatch, expected 0 given 1`

##### Expected Verify errors Output

- `Invalid Output Field. Args mismatch, expected 0 given 1`

### Objects\Invalid\generic-arg-undef.graphql+

```gqlp
object Test { field: Ref<$type> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Field. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Field. '$type' not defined`

### Objects\Invalid\generic-field-undef.graphql+

```gqlp
object Test { field: $type }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Field. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Field. '$type' not defined`

### Objects\Invalid\generic-param-undef.graphql+

```gqlp
object Test { field: Ref<Test1> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Field. 'Test1' not defined`

##### Expected Verify errors Input

- `Invalid Input Field. 'Test1' not defined`

##### Expected Verify errors Output

- `Invalid Output Field. 'Test1' not defined`

### Objects\Invalid\generic-parent-less.graphql+

```gqlp
object Test { :Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. Args mismatch, expected 1 given 0`

##### Expected Verify errors Input

- `Invalid Input Parent. Args mismatch, expected 1 given 0`

##### Expected Verify errors Output

- `Invalid Output Parent. Args mismatch, expected 1 given 0`

### Objects\Invalid\generic-parent-more.graphql+

```gqlp
object Test { :Ref<Number> }
object Ref { }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. Args mismatch, expected 0 given 1`

##### Expected Verify errors Input

- `Invalid Input Parent. Args mismatch, expected 0 given 1`

##### Expected Verify errors Output

- `Invalid Output Parent. Args mismatch, expected 0 given 1`

### Objects\Invalid\generic-parent-undef.graphql+

```gqlp
object Test { :$type }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. '$type' not defined`

##### Expected Verify errors Input

- `Invalid Input Parent. '$type' not defined`

##### Expected Verify errors Output

- `Invalid Output Parent. '$type' not defined`

### Objects\Invalid\generic-unused.graphql+

```gqlp
object Test<$type> { }
```

##### Expected Verify errors Dual

- `Invalid Dual. '$type' not used`

##### Expected Verify errors Input

- `Invalid Input. '$type' not used`

##### Expected Verify errors Output

- `Invalid Output. '$type' not used`

### Objects\Invalid\input-alt-output.graphql+

```gqlp
input Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Alternate. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\input-field-null.graphql+

```gqlp
input Test { field: Test = null }
```

##### Expected Verify errors

- `Invalid Input Field Default. 'null' default requires Optional type, not 'Test'`

### Objects\Invalid\input-field-output.graphql+

```gqlp
input Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Field. Type kind mismatch for Bad. Found Output`

### Objects\Invalid\input-parent-output.graphql+

```gqlp
input Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Parent. 'Bad' invalid type. Found 'Output'`

### Objects\Invalid\output-alt-input.graphql+

```gqlp
output Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Alternate. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\output-enum-bad.graphql+

```gqlp
output Test { field = unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum. Enum Value 'unknown' not defined`
- `Invalid Output Field. '' not defined`

### Objects\Invalid\output-enum-diff.graphql+

```gqlp
output Test { field = true }
output Test { field = false }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' is not singular ModifiedType['Boolean.false', 'Boolean.true']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\output-enumValue-bad.graphql+

```gqlp
output Test { field = Boolean.unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum Value. 'unknown' not a Value of 'Boolean'`

### Objects\Invalid\output-enumValue-wrong.graphql+

```gqlp
output Test { field = Wrong.unknown }
input Wrong { }
```

##### Expected Verify errors

- `Invalid Output Field Enum. 'Wrong' is not an Enum type`
- `Invalid Output Field. Type kind mismatch for Wrong. Found Input`

### Objects\Invalid\output-field-input.graphql+

```gqlp
output Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Field. Type kind mismatch for Bad. Found Input`

### Objects\Invalid\output-generic-arg-enum-wrong.graphql+

```gqlp
output Test<$arg> { | Ref<$arg.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `Invalid Output. '$arg' not used`
- `Invalid Output Arg. Expected Enum value not allowed after Type parameter`
- `Invalid Schema. Expected declaration selector. 'unknown' unknown`
- `Invalid Schema. Expected no more text`

### Objects\Invalid\output-generic-enum-bad.graphql+

```gqlp
output Test { | Ref<Boolean.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `Invalid Output Arg Enum Value. 'unknown' not a Value of 'Boolean'`

### Objects\Invalid\output-generic-enum-wrong.graphql+

```gqlp
output Test { | Ref<Wrong.unknown> }
output Ref<$type> { field: $type }
output Wrong { }
```

##### Expected Verify errors

- `Invalid Output Arg Enum. 'Wrong' is not an Enum type`

### Objects\Invalid\output-param-diff.graphql+

```gqlp
output Test { field(Param): Test }
output Test { field(Param?): Test }
input Param { }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of InputParam for 'Param' is not singular Modifiers['', '?']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\output-param-mod-undef-param.graphql+

```gqlp
output Test { field(Param[$a]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined`

### Objects\Invalid\output-param-mod-undef.graphql+

```gqlp
output Test { field(Param[Domain]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Domain' not defined`

### Objects\Invalid\output-param-mod-wrong.graphql+

```gqlp
output Test { field(Param[Test]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Test' invalid type`

### Objects\Invalid\output-param-undef.graphql+

```gqlp
output Test { field(Param): Test }
```

##### Expected Verify errors

- `Invalid Input Param. 'Param' not defined`

### Objects\Invalid\output-parent-input.graphql+

```gqlp
output Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Parent. 'Bad' invalid type. Found 'Input'`

### Objects\Invalid\parent-alt-mod.graphql+

```gqlp
object Test { :Parent }
object Test { | Alt }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\parent-alt-more.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :More }
object More { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`

### Objects\Invalid\parent-alt-recurse.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates`
- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`

### Objects\Invalid\parent-alt-self-more.graphql+

```gqlp
object Test { :Alt }
object Alt { | More }
object More { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More`

### Objects\Invalid\parent-alt-self-recurse.graphql+

```gqlp
object Test { :Alt }
object Alt { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

### Objects\Invalid\parent-alt-self.graphql+

```gqlp
object Test { :Alt }
object Alt { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`

### Objects\Invalid\parent-field-alias-more.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`

### Objects\Invalid\parent-field-alias-recurse.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`

### Objects\Invalid\parent-field-alias.graphql+

```gqlp
object Test { :Parent }
object Test { field1 [alias]: Test }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\parent-field-mod-more.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`

### Objects\Invalid\parent-field-mod-recurse.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Invalid Dual Child. Can't merge Test into Parent Recurse`
- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Input

- `Invalid Input Child. Can't merge Test into Parent Recurse`
- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Output

- `Invalid Output Child. Can't merge Test into Parent Recurse`
- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`

### Objects\Invalid\parent-field-mod.graphql+

```gqlp
object Test { :Parent }
object Test { field: Test }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### Objects\Invalid\parent-more.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :More }
object More { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be a child of itself, even recursively via Recurse`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be a child of itself, even recursively via Recurse`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be a child of itself, even recursively via More`
- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be a child of itself, even recursively via Recurse`

### Objects\Invalid\parent-recurse.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be a child of itself, even recursively via Recurse`
- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test`

### Objects\Invalid\parent-self-alt-more.graphql+

```gqlp
object Test { | Alt }
object Alt { :More }
object More { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More`

### Objects\Invalid\parent-self-alt-recurse.graphql+

```gqlp
object Test { | Alt }
object Alt { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt`

### Objects\Invalid\parent-self-alt.graphql+

```gqlp
object Test { | Alt }
object Alt { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt`
- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test`

### Objects\Invalid\parent-self.graphql+

```gqlp
object Test { :Test }
```

##### Expected Verify errors Dual

- `Invalid Dual. 'Test' cannot be a child of itself`

##### Expected Verify errors Input

- `Invalid Input. 'Test' cannot be a child of itself`

##### Expected Verify errors Output

- `Invalid Output. 'Test' cannot be a child of itself`

### Objects\Invalid\parent-simple.graphql+

```gqlp
object Test { :String }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. 'String' invalid type. Found 'Domain'`

##### Expected Verify errors Input

- `Invalid Input Parent. 'String' invalid type. Found 'Domain'`

##### Expected Verify errors Output

- `Invalid Output Parent. 'String' invalid type. Found 'Domain'`

### Objects\Invalid\parent-undef.graphql+

```gqlp
object Test { :Parent }
```

##### Expected Verify errors Dual

- `Invalid Dual Parent. 'Parent' not defined`

##### Expected Verify errors Input

- `Invalid Input Parent. 'Parent' not defined`

##### Expected Verify errors Output

- `Invalid Output Parent. 'Parent' not defined`

### Objects\Invalid\unique-alias.graphql+

```gqlp
object Test [a] { }
object Dup [a] { }
```

##### Expected Verify errors Dual

- `Multiple Duals with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Input

- `Multiple Inputs with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Output

- `Multiple Outputs with alias 'a' found. Names 'Test' 'Dup'`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`
