# InvalidObjects Schema Samples

### alt-diff-mod.graphql+

```gqlp
object Test { | Test1 }
object Test { | Test1[] }
object Test1 { }
```

##### Expected Verify errors Ddual

- `Group of DualAlternate for 'Test1' is not singular Modifiers['', '[]'],`
- `Multiple Duals with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Group of InputAlternate for 'Test1' is not singular Modifiers['', '[]'],`
- `Multiple Inputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Group of OutputAlternate for 'Test1' is not singular Modifiers['', '[]'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### alt-mod-undef-param.graphql+

```gqlp
object Test { | Alt[$a] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'a' not defined.`

### alt-mod-undef.graphql+

```gqlp
object Test { | Alt[Domain] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Domain' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Domain' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Domain' not defined.`

### alt-mod-wrong.graphql+

```gqlp
object Test { | Alt[Test] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Test' invalid type.`

### alt-more.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | More }
object More { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Recurse.`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via More.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Recurse.`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via More.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Recurse.`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via More.,`

### alt-recurse.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

### alt-self.graphql+

```gqlp
object Test { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be an alternate of itself.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be an alternate of itself.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be an alternate of itself.`

### alt-simple-param.graphql+

```gqlp
object Test { | Number<String> }
```

##### Expected Verify errors Ddual

- `Invalid Dual Alternate. Args invalid on Number, given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Alternate. Args invalid on Number, given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Alternate. Args invalid on Number, given 1.`

### dual-alt-input.graphql+

```gqlp
dual Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input.`

### dual-alt-output.graphql+

```gqlp
dual Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output.`

### dual-alt-param-input.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Input.`

### dual-alt-param-output.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Alternate. Type kind mismatch for Bad. Found Output.`

### dual-field-input.graphql+

```gqlp
dual Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input.`

### dual-field-output.graphql+

```gqlp
dual Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output.`

### dual-field-param-input.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Input.`

### dual-field-param-output.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Field. Type kind mismatch for Bad. Found Output.`

### dual-parent-input.graphql+

```gqlp
dual Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Input'.`

### dual-parent-output.graphql+

```gqlp
dual Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. 'Bad' invalid type. Found 'Output'.`

### dual-parent-param-input.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Input.`

### dual-parent-param-output.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Invalid Dual Parent. Type kind mismatch for Bad. Found Output.`

### field-alias.graphql+

```gqlp
object Test { field1[alias]: Test }
object Test { field2[alias]: Test[] }
```

##### Expected Verify errors Ddual

- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2'],`
- `Multiple Duals with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2'],`
- `Multiple Inputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### field-diff-mod.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test[] }
```

##### Expected Verify errors Ddual

- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []'],`
- `Multiple Duals with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []'],`
- `Multiple Inputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### field-diff-type.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test1 }
object Test1 { }
```

##### Expected Verify errors Ddual

- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test1'],`
- `Multiple Duals with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test1'],`
- `Multiple Inputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test1'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### field-mod-undef-param.graphql+

```gqlp
object Test { field: Test[$a] }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'a' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'a' not defined.`

### field-mod-undef.graphql+

```gqlp
object Test { field: Test[Random] }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Random' not defined.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Random' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Random' not defined.`

### field-mod-wrong.graphql+

```gqlp
object Test { field: Test[Test] }
```

##### Expected Verify errors Ddual

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Iinput

- `Invalid Modifier. 'Test' invalid type.`

##### Expected Verify errors Ooutput

- `Invalid Modifier. 'Test' invalid type.`

### field-simple-param.graphql+

```gqlp
object Test { field: String<0> }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. Args invalid on String, given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Field. Args invalid on String, given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. Args invalid on String, given 1.`

### generic-alt-undef.graphql+

```gqlp
object Test { | $type }
```

##### Expected Verify errors Ddual

- `Invalid Dual Alternate. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Alternate. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Alternate. '$type' not defined.`

### generic-arg-less.graphql+

```gqlp
object Test { field: Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Iinput

- `Invalid Input Field. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. Args mismatch, expected 1 given 0.`

### generic-arg-more.graphql+

```gqlp
object Test<$type> { field: Ref<$type> }
object Ref { }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Field. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. Args mismatch, expected 0 given 1.`

### generic-arg-undef.graphql+

```gqlp
object Test { field: Ref<$type> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Field. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. '$type' not defined.`

### generic-field-undef.graphql+

```gqlp
object Test { field: $type }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Field. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. '$type' not defined.`

### generic-param-undef.graphql+

```gqlp
object Test { field: Ref<Test1> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Field. 'Test1' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Field. 'Test1' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Field. 'Test1' not defined.`

### generic-parent-less.graphql+

```gqlp
object Test { :Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. Args mismatch, expected 1 given 0.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. Args mismatch, expected 1 given 0.`

### generic-parent-more.graphql+

```gqlp
object Test { :Ref<Number> }
object Ref { }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. Args mismatch, expected 0 given 1.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. Args mismatch, expected 0 given 1.`

### generic-parent-undef.graphql+

```gqlp
object Test { :$type }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. '$type' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. '$type' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. '$type' not defined.`

### generic-unused.graphql+

```gqlp
object Test<$type> { }
```

##### Expected Verify errors Ddual

- `Invalid Dual. '$type' not used.`

##### Expected Verify errors Iinput

- `Invalid Input. '$type' not used.`

##### Expected Verify errors Ooutput

- `Invalid Output. '$type' not used.`

### input-alt-output.graphql+

```gqlp
input Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Alternate. Type kind mismatch for Bad. Found Output.`

### input-field-null.graphql+

```gqlp
input Test { field: Test = null }
```

##### Expected Verify errors

- `Invalid Input Field Default. 'null' default requires Optional type, not 'Test'.`

### input-field-output.graphql+

```gqlp
input Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Field. Type kind mismatch for Bad. Found Output.`

### input-parent-output.graphql+

```gqlp
input Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `Invalid Input Parent. 'Bad' invalid type. Found 'Output'.`

### output-alt-input.graphql+

```gqlp
output Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Alternate. Type kind mismatch for Bad. Found Input.`

### output-enum-bad.graphql+

```gqlp
output Test { field = unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum. Enum Value 'unknown' not defined.,`
- `Invalid Output Field. '' not defined.`

### output-enum-diff.graphql+

```gqlp
output Test { field = true }
output Test { field = false }
```

##### Expected Verify errors

- `Group of OutputField for 'field' is not singular ModifiedType['Boolean.false', 'Boolean.true'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### output-enumValue-bad.graphql+

```gqlp
output Test { field = Boolean.unknown }
```

##### Expected Verify errors

- `Invalid Output Field Enum Value. 'unknown' not a Value of 'Boolean'.`

### output-enumValue-wrong.graphql+

```gqlp
output Test { field = Wrong.unknown }
input Wrong { }
```

##### Expected Verify errors

- `Invalid Output Field Enum. 'Wrong' is not an Enum type.,`
- `Invalid Output Field. Type kind mismatch for Wrong. Found Input.`

### output-field-input.graphql+

```gqlp
output Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Field. Type kind mismatch for Bad. Found Input.`

### output-generic-enum-bad.graphql+

```gqlp
output Test { | Ref<Boolean.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `Invalid Output Arg Enum Value. 'unknown' not a Value of 'Boolean'.`

### output-generic-enum-wrong.graphql+

```gqlp
output Test { | Ref<Wrong.unknown> }
output Ref<$type> { field: $type }
output Wrong { }
```

##### Expected Verify errors

- `Invalid Output Arg Enum. 'Wrong' is not an Enum type.`

### output-param-diff.graphql+

```gqlp
output Test { field(Param): Test }
output Test { field(Param?): Test }
input Param { }
```

##### Expected Verify errors

- `Group of InputParam for 'Param' is not singular Modifiers['', '?'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### output-param-mod-undef-param.graphql+

```gqlp
output Test { field(Param[$a]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'a' not defined.`

### output-param-mod-undef.graphql+

```gqlp
output Test { field(Param[Domain]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Domain' not defined.`

### output-param-mod-wrong.graphql+

```gqlp
output Test { field(Param[Test]): Test }
input Param { }
```

##### Expected Verify errors

- `Invalid Modifier. 'Test' invalid type.`

### output-param-undef.graphql+

```gqlp
output Test { field(Param): Test }
```

##### Expected Verify errors

- `Invalid Input Param. 'Param' not defined.`

### output-parent-input.graphql+

```gqlp
output Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `Invalid Output Parent. 'Bad' invalid type. Found 'Input'.`

### parent-alt-mod.graphql+

```gqlp
object Test { :Parent }
object Test { | Alt }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Group of DualObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Duals with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Group of InputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Inputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### parent-alt-more.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :More }
object More { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`
- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates.,`

##### Expected Verify errors Iinput

- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`
- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates.,`

##### Expected Verify errors Ooutput

- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`
- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates.,`

### parent-alt-recurse.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Ddual

- `Group of DualAlternate for 'Alt' is not singular Modifiers['', '[]']`
- `Invalid Dual Child. Can't merge Test alternates into Parent Recurse alternates.,`

##### Expected Verify errors Iinput

- `Group of InputAlternate for 'Alt' is not singular Modifiers['', '[]']`
- `Invalid Input Child. Can't merge Test alternates into Parent Recurse alternates.,`

##### Expected Verify errors Ooutput

- `Group of OutputAlternate for 'Alt' is not singular Modifiers['', '[]']`
- `Invalid Output Child. Can't merge Test alternates into Parent Recurse alternates.,`

### parent-alt-self-more.graphql+

```gqlp
object Test { :Alt }
object Alt { | More }
object More { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More.`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More.`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More.`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

### parent-alt-self-recurse.graphql+

```gqlp
object Test { :Alt }
object Alt { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

### parent-alt-self.graphql+

```gqlp
object Test { :Alt }
object Alt { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt.,`

### parent-field-alias-more.graphql+

```gqlp
object Test { :Recurse field1[alias]: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field2[alias]: Parent }
```

##### Expected Verify errors Ddual

- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Iinput

- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Invalid Input Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Ooutput

- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Invalid Output Child. Can't merge Test into Parent Recurse.,`

### parent-field-alias-recurse.graphql+

```gqlp
object Test { :Recurse field1[alias]: Test }
object Recurse { :Parent }
object Parent { field2[alias]: Parent }
```

##### Expected Verify errors Ddual

- `Aliases of DualField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Iinput

- `Aliases of InputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Invalid Input Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Ooutput

- `Aliases of OutputField for 'alias' is not singular ModifiedType['field1', 'field2']`
- `Invalid Output Child. Can't merge Test into Parent Recurse.,`

### parent-field-alias.graphql+

```gqlp
object Test { :Parent }
object Test { field1[alias]: Test }
object Parent { field2[alias]: Parent }
```

##### Expected Verify errors Ddual

- `Group of DualObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Duals with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Group of InputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Inputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### parent-field-mod-more.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Ddual

- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Iinput

- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Invalid Input Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Ooutput

- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Invalid Output Child. Can't merge Test into Parent Recurse.,`

### parent-field-mod-recurse.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Ddual

- `Group of DualField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Invalid Dual Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Iinput

- `Group of InputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Invalid Input Child. Can't merge Test into Parent Recurse.,`

##### Expected Verify errors Ooutput

- `Group of OutputField for 'field' is not singular ModifiedType['Test', 'Test []']`
- `Invalid Output Child. Can't merge Test into Parent Recurse.,`

### parent-field-mod.graphql+

```gqlp
object Test { :Parent }
object Test { field: Test }
object Parent { field: Test[] }
```

##### Expected Verify errors Ddual

- `Group of DualObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Duals with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Iinput

- `Group of InputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Inputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

##### Expected Verify errors Ooutput

- `Group of OutputObject for 'Test' is not singular Parent['', 'Parent'],`
- `Multiple Outputs with name 'Test' can't be merged.,`
- `Multiple Types with name 'Test' can't be merged.`

### parent-more.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :More }
object More { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'More' cannot be a child of itself, even recursively via Recurse.`
- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test.,`
- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via More.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'More' cannot be a child of itself, even recursively via Recurse.`
- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test.,`
- `Invalid Input. 'Test' cannot be a child of itself, even recursively via More.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'More' cannot be a child of itself, even recursively via Recurse.`
- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test.,`
- `Invalid Output. 'Test' cannot be a child of itself, even recursively via More.,`

### parent-recurse.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Recurse' cannot be a child of itself, even recursively via Test.`
- `Invalid Dual. 'Test' cannot be a child of itself, even recursively via Recurse.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Recurse' cannot be a child of itself, even recursively via Test.`
- `Invalid Input. 'Test' cannot be a child of itself, even recursively via Recurse.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Recurse' cannot be a child of itself, even recursively via Test.`
- `Invalid Output. 'Test' cannot be a child of itself, even recursively via Recurse.,`

### parent-self-alt-more.graphql+

```gqlp
object Test { | Alt }
object Alt { :More }
object More { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via More.`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via More.`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'More' cannot be an alternate of itself, even recursively via Alt.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via More.`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

### parent-self-alt-recurse.graphql+

```gqlp
object Test { | Alt }
object Alt { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Dual. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Input. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.,`
- `Invalid Output. 'Recurse' cannot be an alternate of itself, even recursively via Alt.`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Recurse.,`

### parent-self-alt.graphql+

```gqlp
object Test { | Alt }
object Alt { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Alt' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Dual. 'Test' cannot be an alternate of itself, even recursively via Alt.,`

##### Expected Verify errors Iinput

- `Invalid Input. 'Alt' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Input. 'Test' cannot be an alternate of itself, even recursively via Alt.,`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Alt' cannot be an alternate of itself, even recursively via Test.`
- `Invalid Output. 'Test' cannot be an alternate of itself, even recursively via Alt.,`

### parent-self.graphql+

```gqlp
object Test { :Test }
```

##### Expected Verify errors Ddual

- `Invalid Dual. 'Test' cannot be a child of itself.`

##### Expected Verify errors Iinput

- `Invalid Input. 'Test' cannot be a child of itself.`

##### Expected Verify errors Ooutput

- `Invalid Output. 'Test' cannot be a child of itself.`

### parent-simple.graphql+

```gqlp
object Test { :String }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. 'String' invalid type. Found 'Domain'.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. 'String' invalid type. Found 'Domain'.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. 'String' invalid type. Found 'Domain'.`

### parent-undef.graphql+

```gqlp
object Test { :Parent }
```

##### Expected Verify errors Ddual

- `Invalid Dual Parent. 'Parent' not defined.`

##### Expected Verify errors Iinput

- `Invalid Input Parent. 'Parent' not defined.`

##### Expected Verify errors Ooutput

- `Invalid Output Parent. 'Parent' not defined.`

### unique-alias.graphql+

```gqlp
object Test [a] { }
object Dup [a] { }
```

##### Expected Verify errors Ddual

- `Multiple Duals with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Iinput

- `Multiple Inputs with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Ooutput

- `Multiple Outputs with alias 'a' found. Names 'Test' 'Dup',`
- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`
