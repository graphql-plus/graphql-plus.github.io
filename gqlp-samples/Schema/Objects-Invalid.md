# Objects-Invalid Schema Samples

### alt-mod-undef-param.graphql+

```gqlp
object Test { | Alt[$a] }
object Alt { }
```

##### Expected Verify errors

- `'a' not defined`

### alt-mod-undef.graphql+

```gqlp
object Test { | Alt[Dom] }
object Alt { }
```

##### Expected Verify errors

- `'Dom' not defined`

### alt-mod-wrong.graphql+

```gqlp
object Test { | Alt[Test] }
object Alt { }
```

##### Expected Verify errors

- `'Test' invalid type`

### alt-more.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | More }
object More { | Test }
```

##### Expected Verify errors

- `'Test' cannot be an alternate of itself, even recursively via More`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`
- `'More' cannot be an alternate of itself, even recursively via Recurse`

### alt-recurse.graphql+

```gqlp
object Test { | Recurse }
object Recurse { | Test }
```

##### Expected Verify errors

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Recurse' cannot be an alternate of itself, even recursively via Test`

### alt-self.graphql+

```gqlp
object Test { | Test }
```

##### Expected Verify errors

- `'Test' cannot be an alternate of itself`

### alt-simple-param.graphql+

```gqlp
object Test { | Number<String> }
```

##### Expected Verify errors

- `Args mismatch on Number. Expected none, given 1`

### alt-undef.graphql+

```gqlp
object Test { | Undef }
```

##### Expected Verify errors

- `'Undef' not defined`

### constraint-undef.graphql+

```gqlp
object Test<$type:Undef> { | $type }
```

##### Expected Verify errors

- `'Undef' not defined`

### constraint-wrong.graphql+

```gqlp
object Ref { | Test<Dom> }
object Test<$ref:String> { | $ref }
domain Dom { Number }
```

##### Expected Verify errors

- `'Dom' not match 'String'`

### dual-alt-input.graphql+

```gqlp
dual Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### dual-alt-output.graphql+

```gqlp
dual Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### dual-alt-param-input.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T:_Dual> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`
- `'Bad' not match '_Dual'`

### dual-alt-param-output.graphql+

```gqlp
dual Test { | Param<Bad> }
dual Param<$T:_Dual> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`
- `'Bad' not match '_Dual'`

### dual-field-input.graphql+

```gqlp
dual Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### dual-field-output.graphql+

```gqlp
dual Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### dual-field-param-input.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T:_Dual> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`
- `'Bad' not match '_Dual'`

### dual-field-param-output.graphql+

```gqlp
dual Test { field: Param<Bad> }
dual Param<$T:_Dual> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`
- `'Bad' not match '_Dual'`

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
dual Param<$T:_Dual> { | $T }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`
- `'Bad' not match '_Dual'`

### dual-parent-param-output.graphql+

```gqlp
dual Test { :Param<Bad> }
dual Param<$T:_Dual> { | $T }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`
- `'Bad' not match '_Dual'`

### field-alias.graphql+

```gqlp
object Test { field1 [alias]: Field }
object Test { field2 [alias]: Field[] }
object Field { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Aliases of DualField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Aliases of InputField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Aliases of OutputField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

### field-diff-mod.graphql+

```gqlp
object Test { field: Field }
object Test { field: Field[] }
object Field { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

### field-diff-type.graphql+

```gqlp
object Test { field: Test1 }
object Test { field: Test2 }
object Test1 { }
object Test2 { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualField for 'field' not singular ModifiedType_Label['Test1', 'Test2']`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputField for 'field' not singular ModifiedType_Label['Test1', 'Test2']`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' not singular ModifiedType_Label['Test1', 'Test2']`

### field-mod-undef-param.graphql+

```gqlp
object Test { field: Field[$a] }
object Field { }
```

##### Expected Verify errors

- `'a' not defined`

### field-mod-undef.graphql+

```gqlp
object Test { field: Field[Random] }
object Field { }
```

##### Expected Verify errors

- `'Random' not defined`

### field-mod-wrong.graphql+

```gqlp
object Test { field: Field[Field] }
object Field { }
```

##### Expected Verify errors

- `'Field' invalid type`

### field-simple-param.graphql+

```gqlp
object Test { field: String<0> }
```

##### Expected Verify errors

- `Args mismatch on String. Expected none, given 1`

### field-undef.graphql+

```gqlp
object Test { field: Undef }
```

##### Expected Verify errors

- `'Undef' not defined`

### generic-alt-undef.graphql+

```gqlp
object Test { | $type }
```

##### Expected Verify errors

- `'$type' not defined`

### generic-arg-less.graphql+

```gqlp
object Test { field: Ref }
object Ref<$ref:String> { | $ref }
```

##### Expected Verify errors

- `Args mismatch on Ref. Expected 1, given 0`

### generic-arg-more.graphql+

```gqlp
object Test<$type:String> { field: Ref<$type> }
object Ref { }
```

##### Expected Verify errors

- `Args mismatch on Ref. Expected 0, given 1`

### generic-arg-undef.graphql+

```gqlp
object Test { field: Ref<$type> }
object Ref<$ref:String> { | $ref }
```

##### Expected Verify errors

- `'$type' not defined`

### generic-field-undef.graphql+

```gqlp
object Test { field: $type }
```

##### Expected Verify errors

- `'$type' not defined`

### generic-param-undef.graphql+

```gqlp
object Test { field: Ref<Test1> }
object Ref<$ref:String> { | $ref }
```

##### Expected Verify errors

- `'Test1' not defined`
- `'Test1' not match 'String'`

### generic-parent-less.graphql+

```gqlp
object Test { :Ref }
object Ref<$ref:String> { | $ref }
```

##### Expected Verify errors

- `Args mismatch on Ref. Expected 1, given 0`

### generic-parent-more.graphql+

```gqlp
object Test { :Ref<Number> }
object Ref { }
```

##### Expected Verify errors

- `Args mismatch on Ref. Expected 0, given 1`

### generic-parent-undef.graphql+

```gqlp
object Test { :$type }
```

##### Expected Verify errors

- `'$type' not defined`

### generic-unused.graphql+

```gqlp
object Test<$type:String> { }
```

##### Expected Verify errors

- `'$type' not used`

### input-alt-output.graphql+

```gqlp
input Test { | Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### input-field-null.graphql+

```gqlp
input Test { field: Field = null }
input Field { }
```

##### Expected Verify errors

- `'null' default requires Optional type, not 'Field'`

### input-field-output.graphql+

```gqlp
input Test { field: Bad }
output Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### input-parent-output.graphql+

```gqlp
input Test { :Bad }
output Bad { }
```

##### Expected Verify errors

- `'Bad' invalid type. Found 'Output'`

### object-enum-bad.graphql+

```gqlp
object Test { field = unknown }
```

##### Expected Verify errors

- `Enum Label 'unknown' not defined`
- `'' not defined`

### object-enum-diff.graphql+

```gqlp
object Test { field = true }
object Test { field = false }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputField for 'field' not singular ModifiedType_Label['Boolean.false', 'Boolean.true']`
- `Multiple Types with name 'Test' can't be merged`

### object-enumValue-bad.graphql+

```gqlp
object Test { field = Boolean.unknown }
```

##### Expected Verify errors

- `'unknown' not a Label of 'Boolean'`

### object-enumValue-wrong.graphql+

```gqlp
object Test { field = Wrong.unknown }
input Wrong { }
```

##### Expected Verify errors

- `'Wrong' not an Enum type`
- `Type kind mismatch for Wrong. Found Input`

### object-generic-arg-enum-wrong.graphql+

```gqlp
object Test<$arg:String> { | Ref<$arg.unknown> }
object Ref<$type:String> { field: $type }
```

##### Expected Verify errors

- `'$arg' not used`
- `Expected Enum value not allowed after Type parameter`
- `Expected declaration selector. 'unknown' unknown`
- `Expected no more text`

### object-generic-enum-bad.graphql+

```gqlp
object Test { | Ref<Boolean.unknown> }
object Ref<$type:_Enum> { field: $type }
```

##### Expected Verify errors

- `'unknown' not a Label of 'Boolean'`

### object-generic-enum-wrong.graphql+

```gqlp
object Test { | Ref<Wrong.unknown> }
object Ref<$type:_Enum> { field: $type }
object Wrong { }
```

##### Expected Verify errors

- `'Wrong' not an Enum type`
- `'Wrong' not match '_Enum'`

### output-alt-input.graphql+

```gqlp
output Test { | Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### output-field-input.graphql+

```gqlp
output Test { field: Bad }
input Bad { }
```

##### Expected Verify errors

- `Type kind mismatch`

### output-param-diff.graphql+

```gqlp
output Test { field(Param): Field }
output Test { field(Param?): Field }
input Param { }
output Field { }
```

##### Expected Verify errors

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of InputParam for 'Param' not singular Modifiers['', '?']`
- `Multiple Types with name 'Test' can't be merged`

### output-param-mod-undef-param.graphql+

```gqlp
output Test { field(Param[$a]): Field }
input Param { }
output Field { }
```

##### Expected Verify errors

- `'a' not defined`

### output-param-mod-undef.graphql+

```gqlp
output Test { field(Param[Dom]): Field }
input Param { }
output Field { }
```

##### Expected Verify errors

- `'Dom' not defined`

### output-param-mod-wrong.graphql+

```gqlp
output Test { field(Param[Test]): Field }
input Param { }
output Field { }
```

##### Expected Verify errors

- `'Test' invalid type`

### output-param-undef.graphql+

```gqlp
output Test { field(Param): Field }
output Field { }
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

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' not singular Parent['', 'Parent']`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' not singular Parent['', 'Parent']`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' not singular Parent['', 'Parent']`

### parent-alt-more.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :More }
object More { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors

- `Can't merge Test alternates into Parent Recurse alternates`

##### Expected Verify errors Dual

- `Group of DualAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Group of InputAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Group of OutputAlternate for 'Alt' not singular Modifiers['', '[]']`

### parent-alt-recurse.graphql+

```gqlp
object Test { :Recurse | Alt }
object Recurse { :Parent }
object Parent { | Alt[] }
object Alt { }
```

##### Expected Verify errors

- `Can't merge Test alternates into Parent Recurse alternates`

##### Expected Verify errors Dual

- `Group of DualAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Input

- `Group of InputAlternate for 'Alt' not singular Modifiers['', '[]']`

##### Expected Verify errors Output

- `Group of OutputAlternate for 'Alt' not singular Modifiers['', '[]']`

### parent-alt-self-more.graphql+

```gqlp
object Test { :Alt }
object Alt { | More }
object More { :Recurse }
object Recurse { | Test }
```

##### Expected Verify errors

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

##### Expected Verify errors

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

### parent-alt-self.graphql+

```gqlp
object Test { :Alt }
object Alt { | Test }
```

##### Expected Verify errors

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

### parent-field-alias-more.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Field }
object Recurse { :More }
object More { :Parent }
object Parent { field2 [alias]: Field }
object Field { }
```

##### Expected Verify errors

- `Can't merge Test into Parent Recurse`

##### Expected Verify errors Dual

- `Aliases of DualField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

##### Expected Verify errors Input

- `Aliases of InputField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

##### Expected Verify errors Output

- `Aliases of OutputField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

### parent-field-alias-recurse.graphql+

```gqlp
object Test { :Recurse field1 [alias]: Field }
object Recurse { :Parent }
object Parent { field2 [alias]: Field }
object Field { }
```

##### Expected Verify errors

- `Can't merge Test into Parent Recurse`

##### Expected Verify errors Dual

- `Aliases of DualField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

##### Expected Verify errors Input

- `Aliases of InputField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

##### Expected Verify errors Output

- `Aliases of OutputField for 'alias' not singular ModifiedType_Label['field1', 'field2']`

### parent-field-alias.graphql+

```gqlp
object Test { :Parent }
object Test { field1 [alias]: Field }
object Parent { field2 [alias]: Field }
object Field { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' not singular Parent['', 'Parent']`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' not singular Parent['', 'Parent']`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' not singular Parent['', 'Parent']`

### parent-field-mod-more.graphql+

```gqlp
object Test { :Recurse field: Field }
object Recurse { :More }
object More { :Parent }
object Parent { field: Field[] }
object Field { }
```

##### Expected Verify errors

- `Can't merge Test into Parent Recurse`

##### Expected Verify errors Dual

- `Group of DualField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

##### Expected Verify errors Input

- `Group of InputField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

##### Expected Verify errors Output

- `Group of OutputField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

### parent-field-mod-recurse.graphql+

```gqlp
object Test { :Recurse field: Field }
object Recurse { :Parent }
object Parent { field: Field[] }
object Field { }
```

##### Expected Verify errors

- `Can't merge Test into Parent Recurse`

##### Expected Verify errors Dual

- `Group of DualField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

##### Expected Verify errors Input

- `Group of InputField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

##### Expected Verify errors Output

- `Group of OutputField for 'field' not singular ModifiedType_Label['Field', 'Field []']`

### parent-field-mod.graphql+

```gqlp
object Test { :Parent }
object Test { field: Field }
object Parent { field: Field[] }
object Field { }
```

##### Expected Verify errors

- `Multiple Types with name 'Test' can't be merged`

##### Expected Verify errors Dual

- `Multiple Duals with name 'Test' can't be merged`
- `Group of DualObject for 'Test' not singular Parent['', 'Parent']`

##### Expected Verify errors Input

- `Multiple Inputs with name 'Test' can't be merged`
- `Group of InputObject for 'Test' not singular Parent['', 'Parent']`

##### Expected Verify errors Output

- `Multiple Outputs with name 'Test' can't be merged`
- `Group of OutputObject for 'Test' not singular Parent['', 'Parent']`

### parent-more.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :More }
object More { :Test }
```

##### Expected Verify errors

- `'Test' cannot be a child of itself, even recursively via More`
- `'Recurse' cannot be a child of itself, even recursively via Test`
- `'More' cannot be a child of itself, even recursively via Recurse`

### parent-recurse.graphql+

```gqlp
object Test { :Recurse }
object Recurse { :Test }
```

##### Expected Verify errors

- `'Test' cannot be a child of itself, even recursively via Recurse`
- `'Recurse' cannot be a child of itself, even recursively via Test`

### parent-self-alt-more.graphql+

```gqlp
object Test { | Alt }
object Alt { :More }
object More { | Recurse }
object Recurse { :Test }
```

##### Expected Verify errors

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

##### Expected Verify errors

- `'Test' cannot be an alternate of itself, even recursively via Recurse`
- `'Alt' cannot be an alternate of itself, even recursively via Test`
- `'Recurse' cannot be an alternate of itself, even recursively via Alt`

### parent-self-alt.graphql+

```gqlp
object Test { | Alt }
object Alt { :Test }
```

##### Expected Verify errors

- `'Test' cannot be an alternate of itself, even recursively via Alt`
- `'Alt' cannot be an alternate of itself, even recursively via Test`

### parent-self.graphql+

```gqlp
object Test { :Test }
```

##### Expected Verify errors

- `'Test' cannot be a child of itself`

### parent-simple.graphql+

```gqlp
object Test { :String }
```

##### Expected Verify errors

- `'String' invalid type. Found 'Domain'`

### parent-undef.graphql+

```gqlp
object Test { :Parent }
```

##### Expected Verify errors

- `'Parent' not defined`

### unique-alias.graphql+

```gqlp
object Test [a] { }
object Dup [a] { }
```

##### Expected Verify errors

- `Multiple Types with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Dual

- `Multiple Duals with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Input

- `Multiple Inputs with alias 'a' found. Names 'Test' 'Dup'`

##### Expected Verify errors Output

- `Multiple Outputs with alias 'a' found. Names 'Test' 'Dup'`
