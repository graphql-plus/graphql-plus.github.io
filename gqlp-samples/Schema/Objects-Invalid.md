# Objects-Invalid Schema Samples

### alt-mod-undef-param.graphql+

```gqlp
object Test { | Alt[$a] }
object Alt { }
```

##### Expected Verify errors Dual

- `'a' not defined`

##### Expected Verify errors Input

- `'a' not defined`

##### Expected Verify errors Output

- `'a' not defined`

### alt-mod-undef.graphql+

```gqlp
object Test { | Alt[Domain] }
object Alt { }
```

##### Expected Verify errors Dual

- `'Domain' not defined`

##### Expected Verify errors Input

- `'Domain' not defined`

##### Expected Verify errors Output

- `'Domain' not defined`

### alt-mod-wrong.graphql+

```gqlp
object Test { | Alt[Test] }
object Alt { }
```

##### Expected Verify errors Dual

- `'Test' invalid type`

##### Expected Verify errors Input

- `'Test' invalid type`

##### Expected Verify errors Output

- `'Test' invalid type`

### alt-more.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | More }
object More { | Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via More`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Recurse`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via More`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Recurse`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via More`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Recurse`

### alt-recurse.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`

### alt-self.graphql+

```gqlp
object Test { | Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself`

### alt-simple-param.graphql+

```gqlp
object Test { | Number<String> }
```

##### Expected Verify errors Dual

- `Args invalid on Number. Expected 0, given 1`

##### Expected Verify errors Input

- `Args invalid on Number. Expected 0, given 1`

##### Expected Verify errors Output

- `Args invalid on Number. Expected 0, given 1`

### alt-undef.graphql+

```gqlp
object Test { | Undef }
```

##### Expected Verify errors Dual

- `'Undef' not defined`

##### Expected Verify errors Input

- `'Undef' not defined`

##### Expected Verify errors Output

- `'Undef' not defined`

### constraint-undef.graphql+

```gqlp
object ObjName<$type:Undef> { | $type }
```

##### Expected Verify errors Dual

- `'Undef' not defined`

##### Expected Verify errors Input

- `'Undef' not defined`

##### Expected Verify errors Output

- `'Undef' not defined`

### dual-alt-input.graphql+

```gqlp
dual Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Input`

### dual-alt-output.graphql+

```gqlp
dual Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Output`

### dual-alt-param-input.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Input`

### dual-alt-param-output.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Output`

### dual-field-input.graphql+

```gqlp
dual Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Input`

### dual-field-output.graphql+

```gqlp
dual Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Output`

### dual-field-param-input.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Input`

### dual-field-param-output.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Output`

### dual-parent-input.graphql+

```gqlp
dual Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `'Bad' invalid type. Found 'Input'`

### dual-parent-output.graphql+

```gqlp
dual Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `'Bad' invalid type. Found 'Output'`

### dual-parent-param-input.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Input`

### dual-parent-param-output.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Output`

### field-alias.graphql+

```gqlp
object Test { field1 [alias]: Test }
object Test { field2 [alias]: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Aliases of DualField for 'alias' not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Aliases of InputField for 'alias' not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Aliases of OutputField for 'alias' not singular ModifiedType['field1', 'field2']`
- `Multiple Types with name 'Test' can't be merged`

### field-diff-mod.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' not singular ModifiedType['Test', 'Test []']`
- `Multiple Types with name 'Test' can't be merged`

### field-diff-type.graphql+

```gqlp
object Test { field: Test }
object Test { field: Test1 }
object Test1 { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' not singular ModifiedType['Test', 'Test1']`
- `Multiple Types with name 'Test' can't be merged`

### field-mod-undef-param.graphql+

```gqlp
object Test { field: Test[$a] }
```

##### Expected Verify errors Dual

- `'a' not defined`

##### Expected Verify errors Input

- `'a' not defined`

##### Expected Verify errors Output

- `'a' not defined`

### field-mod-undef.graphql+

```gqlp
object Test { field: Test[Random] }
```

##### Expected Verify errors Dual

- `'Random' not defined`

##### Expected Verify errors Input

- `'Random' not defined`

##### Expected Verify errors Output

- `'Random' not defined`

### field-mod-wrong.graphql+

```gqlp
object Test { field: Test[Test] }
```

##### Expected Verify errors Dual

- `'Test' invalid type`

##### Expected Verify errors Input

- `'Test' invalid type`

##### Expected Verify errors Output

- `'Test' invalid type`

### field-simple-param.graphql+

```gqlp
object Test { field: String<0> }
```

##### Expected Verify errors Dual

- `Args invalid on String. Expected 0, given 1`

##### Expected Verify errors Input

- `Args invalid on String. Expected 0, given 1`

##### Expected Verify errors Output

- `Args invalid on String. Expected 0, given 1`

### field-undef.graphql+

```gqlp
object Test { field: Undef }
```

##### Expected Verify errors Dual

- `'Undef' not defined`

##### Expected Verify errors Input

- `'Undef' not defined`

##### Expected Verify errors Output

- `'Undef' not defined`

### generic-alt-undef.graphql+

```gqlp
object Test { | $type }
```

##### Expected Verify errors Dual

- `'$type' not defined`

##### Expected Verify errors Input

- `'$type' not defined`

##### Expected Verify errors Output

- `'$type' not defined`

### generic-arg-less.graphql+

```gqlp
object Test { field: Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Input

- `Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Output

- `Args mismatch on Ref. Expected 1, given 0`

### generic-arg-more.graphql+

```gqlp
object Test<$type> { field: Ref<$type> }
object Ref { }
```

##### Expected Verify errors Dual

- `Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Input

- `Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Output

- `Args mismatch on Ref. Expected 0, given 1`

### generic-arg-undef.graphql+

```gqlp
object Test { field: Ref<$type> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `'$type' not defined`

##### Expected Verify errors Input

- `'$type' not defined`

##### Expected Verify errors Output

- `'$type' not defined`

### generic-field-undef.graphql+

```gqlp
object Test { field: $type }
```

##### Expected Verify errors Dual

- `'$type' not defined`

##### Expected Verify errors Input

- `'$type' not defined`

##### Expected Verify errors Output

- `'$type' not defined`

### generic-param-undef.graphql+

```gqlp
object Test { field: Ref<Test1> }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `'Test1' not defined`

##### Expected Verify errors Input

- `'Test1' not defined`

##### Expected Verify errors Output

- `'Test1' not defined`

### generic-parent-less.graphql+

```gqlp
object Test { :Ref }
object Ref<$ref> { | $ref }
```

##### Expected Verify errors Dual

- `Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Input

- `Args mismatch on Ref. Expected 1, given 0`

##### Expected Verify errors Output

- `Args mismatch on Ref. Expected 1, given 0`

### generic-parent-more.graphql+

```gqlp
object Test { :Ref<Number> }
object Ref { }
```

##### Expected Verify errors Dual

- `Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Input

- `Args mismatch on Ref. Expected 0, given 1`

##### Expected Verify errors Output

- `Args mismatch on Ref. Expected 0, given 1`

### generic-parent-undef.graphql+

```gqlp
object Test { :$type }
```

##### Expected Verify errors Dual

- `'$type' not defined`

##### Expected Verify errors Input

- `'$type' not defined`

##### Expected Verify errors Output

- `'$type' not defined`

### generic-unused.graphql+

```gqlp
object Test<$type> { }
```

##### Expected Verify errors Dual

- `'$type' not used`

##### Expected Verify errors Input

- `'$type' not used`

##### Expected Verify errors Output

- `'$type' not used`

### input-alt-output.graphql+

```gqlp
input Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Output`

### input-field-null.graphql+

```gqlp
input Test { field: Test = null }
```

##### Expected Verify errors

- `'null' default requires Optional type, not 'Test'`

### input-field-output.graphql+

```gqlp
input Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Output`

### input-parent-output.graphql+

```gqlp
input Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `'Bad' invalid type. Found 'Output'`

### output-alt-input.graphql+

```gqlp
output Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Input`

### output-enum-bad.graphql+

```gqlp
output Test { field = unknown }
```

##### Expected Verify errors

- `Enum Value 'unknown' not defined`
- `'' not defined`

### output-enum-diff.graphql+

```gqlp
output Test { field = true }
output Test { field = false }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' not singular ModifiedType['Boolean.false', 'Boolean.true']`
- `Multiple Types with name 'Test' can't be merged`

### output-enumValue-bad.graphql+

```gqlp
output Test { field = Boolean.unknown }
```

##### Expected Verify errors

- `'unknown' not a Value of 'Boolean'`

### output-enumValue-wrong.graphql+

```gqlp
output Test { field = Wrong.unknown }
input Wrong { }
```

##### Expected Verify errors

- `'Wrong' not an Enum type`
- `Type kind mismatch for Wrong. Found Input`

### output-field-input.graphql+

```gqlp
output Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch for Bad. Found Input`

### output-generic-arg-enum-wrong.graphql+

```gqlp
output Test<$arg> { | Ref<$arg.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `'$arg' not used`
- `Expected Enum value not allowed after Type parameter`
- `Expected declaration selector. 'unknown' unknown`
- `Expected no more text`

### output-generic-enum-bad.graphql+

```gqlp
output Test { | Ref<Boolean.unknown> }
output Ref<$type> { field: $type }
```

##### Expected Verify errors

- `'unknown' not a Value of 'Boolean'`

### output-generic-enum-wrong.graphql+

```gqlp
output Test { | Ref<Wrong.unknown> }
output Ref<$type> { field: $type }
output Wrong { }
```

##### Expected Verify errors

- `'Wrong' not an Enum type`

### output-param-diff.graphql+

```gqlp
output Test { field(Param): Test }
output Test { field(Param?): Test }
input Param { }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of InputParam for 'Param' not singular Modifiers['', '?']`
- `Multiple Types with name 'Test' can't be merged`

### output-param-mod-undef-param.graphql+

```gqlp
output Test { field(Param[$a]): Test }
input Param { }
```

##### Expected Verify errors

- `'a' not defined`

### output-param-mod-undef.graphql+

```gqlp
output Test { field(Param[Domain]): Test }
input Param { }
```

##### Expected Verify errors

- `'Domain' not defined`

### output-param-mod-wrong.graphql+

```gqlp
output Test { field(Param[Test]): Test }
input Param { }
```

##### Expected Verify errors

- `'Test' invalid type`

### output-param-undef.graphql+

```gqlp
output Test { field(Param): Test }
```

##### Expected Verify errors

- `'Param' not defined`

### output-parent-input.graphql+

```gqlp
output Test { :Bad }
input Bad { }
```

##### Expected Verify errors

- `'Bad' invalid type. Found 'Input'`

### parent-alt-mod.graphql+

```gqlp
object Test { :Parent }
object Test { | Alt }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### parent-alt-more.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :More }
object More { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Can't merge Test alternates into Parent Recurse alternates`
- `Group of DualAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Can't merge Test alternates into Parent Recurse alternates`
- `Group of InputAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Can't merge Test alternates into Parent Recurse alternates`
- `Group of OutputAlternate for 'Alt' not singular Modifiers['', '[]']`

### parent-alt-recurse.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors Dual

- `Can't merge Test alternates into Parent Recurse alternates`
- `Group of DualAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Can't merge Test alternates into Parent Recurse alternates`
- `Group of InputAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Can't merge Test alternates into Parent Recurse alternates`
- `Group of OutputAlternate for 'Alt' not singular Modifiers['', '[]']`

### parent-alt-self-more.graphql+

```gqlp
object Test { :Alt }
object Alt { | More }
object More { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Alt`
- `'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Alt`
- `'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Alt`
- `'Recurse' cannot be an alternate of itself, even recursively via More`

### parent-alt-self-recurse.graphql+

```gqlp
object Test { :Alt }
object Alt { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

### parent-alt-self.graphql+

```gqlp
object Test { :Alt }
object Alt { | Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

### parent-field-alias-more.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Can't merge Test into Parent Recurse`
- `Aliases of DualField for 'alias' not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Input

- `Can't merge Test into Parent Recurse`
- `Aliases of InputField for 'alias' not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Output

- `Can't merge Test into Parent Recurse`
- `Aliases of OutputField for 'alias' not singular ModifiedType['field1', 'field2']`

### parent-field-alias-recurse.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Test }
object Recurse { :Parent }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Can't merge Test into Parent Recurse`
- `Aliases of DualField for 'alias' not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Input

- `Can't merge Test into Parent Recurse`
- `Aliases of InputField for 'alias' not singular ModifiedType['field1', 'field2']`

##### Expected Verify errors Output

- `Can't merge Test into Parent Recurse`
- `Aliases of OutputField for 'alias' not singular ModifiedType['field1', 'field2']`

### parent-field-alias.graphql+

```gqlp
object Test { :Parent }
object Test { field1 [alias]: Test }
object Parent { field2 [alias]: Parent }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### parent-field-mod-more.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :More }
object More { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Can't merge Test into Parent Recurse`
- `Group of DualField for 'field' not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Input

- `Can't merge Test into Parent Recurse`
- `Group of InputField for 'field' not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Output

- `Can't merge Test into Parent Recurse`
- `Group of OutputField for 'field' not singular ModifiedType['Test', 'Test []']`

### parent-field-mod-recurse.graphql+

```gqlp
object Test { :Recurse field: Test }
object Recurse { :Parent }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Can't merge Test into Parent Recurse`
- `Group of DualField for 'field' not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Input

- `Can't merge Test into Parent Recurse`
- `Group of InputField for 'field' not singular ModifiedType['Test', 'Test []']`

##### Expected Verify errors Output

- `Can't merge Test into Parent Recurse`
- `Group of OutputField for 'field' not singular ModifiedType['Test', 'Test []']`

### parent-field-mod.graphql+

```gqlp
object Test { :Parent }
object Test { field: Test }
object Parent { field: Test[] }
```

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' not singular Parent['', 'Parent']`
- `Multiple Types with name 'Test' can't be merged`

### parent-more.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :More }
object More { :Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be a child of itself, even recursively via More`
- `'Recurse' cannot be a child of itself, even recursively via Test`
- `'More' cannot be a child of itself, even recursively via Recurse`

##### Expected Verify errors Input

- `'Test' cannot be a child of itself, even recursively via More`
- `'Recurse' cannot be a child of itself, even recursively via Test`
- `'More' cannot be a child of itself, even recursively via Recurse`

##### Expected Verify errors Output

- `'Test' cannot be a child of itself, even recursively via More`
- `'Recurse' cannot be a child of itself, even recursively via Test`
- `'More' cannot be a child of itself, even recursively via Recurse`

### parent-recurse.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be a child of itself, even recursively via Recurse`
- `'Recurse' cannot be a child of itself, even recursively via Test`

##### Expected Verify errors Input

- `'Test' cannot be a child of itself, even recursively via Recurse`
- `'Recurse' cannot be a child of itself, even recursively via Test`

##### Expected Verify errors Output

- `'Test' cannot be a child of itself, even recursively via Recurse`
- `'Recurse' cannot be a child of itself, even recursively via Test`

### parent-self-alt-more.graphql+

```gqlp
object Test { | Alt }
object Alt { :More }
object More { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Alt`
- `'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Alt`
- `'Recurse' cannot be an alternate of itself, even recursively via More`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Alt`
- `'Recurse' cannot be an alternate of itself, even recursively via More`

### parent-self-alt-recurse.graphql+

```gqlp
object Test { | Alt }
object Alt { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

### parent-self-alt.graphql+

```gqlp
object Test { | Alt }
object Alt { :Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Input

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

##### Expected Verify errors Output

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

### parent-self.graphql+

```gqlp
object Test { :Test }
```

##### Expected Verify errors Dual

- `'Test' cannot be a child of itself`

##### Expected Verify errors Input

- `'Test' cannot be a child of itself`

##### Expected Verify errors Output

- `'Test' cannot be a child of itself`

### parent-simple.graphql+

```gqlp
object Test { :String }
```

##### Expected Verify errors Dual

- `'String' invalid type. Found 'Domain'`

##### Expected Verify errors Input

- `'String' invalid type. Found 'Domain'`

##### Expected Verify errors Output

- `'String' invalid type. Found 'Domain'`

### parent-undef.graphql+

```gqlp
object Test { :Parent }
```

##### Expected Verify errors Dual

- `'Parent' not defined`

##### Expected Verify errors Input

- `'Parent' not defined`

##### Expected Verify errors Output

- `'Parent' not defined`

### unique-alias.graphql+

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
