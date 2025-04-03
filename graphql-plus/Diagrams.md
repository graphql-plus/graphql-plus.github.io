# Diagrams

## Schema

```mermaid
classDiagram
    direction LR

    Schema *-- Declaration : defines

    Declaration <|-- Global
    Declaration <|-- Type

    Type : *~Type~ Parent
    Type <|-- Built-In
    Type <|-- Simple
    Type <|-- Object

    Global : 🔗
    Simple : 🔗
    Object : 🔗

    link Schema "Schema.html#schema"
    link Declaration "Schema.html#declarations"
    link Type "Schema.html#type-declarations"
    link Built-In "Schema.html#built-in-types"

    link Global "#global-declarations"
    link Simple "#simple-types"
    link Object "#object-types"
```

### Global declarations

```mermaid
classDiagram
    direction LR

    Global <|-- Category
    Global <|-- Directive
    Global <|-- Option

    <<Declaration>> Category
    Category : Output

    <<Declaration>> Directive
    Directive : Param[]

    <<Declaration>> Option
    Option *-- Setting

    Setting : Key
    Setting : Value

    link Global "Schema.html#global-declarations"
    link Category "Schema.html#category-declaration"
    link Directive "Schema.html#directive-declaration"
    link Option "Schema.html#option-declaration"
```

### Simple types

```mermaid
classDiagram
    direction LR

    Simple : *~Item~[] Items

    Simple <|-- Domain
    Simple <|-- Enum
    Simple <|-- Union

    <<Declaration>> Domain
    Domain : Kind

    Domain *-- TrueFalse : Kind = Boolean
    Domain *-- Label : Kind = Enum
    Domain *-- Range : Kind = Number
    Domain *-- Regex : Kind = String

    TrueFalse --|> Item
    Label --|> Item
    Range --|> Item
    Regex --|> Item

    Item : Excluded

    <<Declaration>> Enum
    <<Declaration>> Union

    link Simple "Schema.html#simple-types"
    link Domain "Schema.html#domain-type"
    link Enum "Schema.html#enum-type"
    link Union "Schema.html#union-type"
    link TrueFalse "Schema.html#boolean-domain"
    link Label "Schema.html#enum-domain"
    link Range "Schema.html#number-domain"
    link Regex "Schema.html#string-domain"
```

### Object types

```mermaid
classDiagram
    direction LR

    Object <|-- Input
    Object <|-- Dual
    Object <|-- Output

    Object : TypeParam[]
    Object : Field~Base~[]
    Object : Alternate~Base~[]

    <<Declaration>> Input
    <<Declaration>> Dual
    <<Declaration>> Output

    InputBase ..> DualBase
    OutputBase : EnumValue

    Dual <-- DualBase
    Input <-- InputBase
    Output <-- OutputBase

    OutputBase ..> DualBase

    InputBase --|> Base
    DualBase --|> Base
    OutputBase --|> Base

    Base : TypeArg[]
    Base : IsTypeParam()

    Field : *~Base~ Type

    Field <|-- InputField
    Field <|-- OutputField

    InputField ..> DualField
    InputField : Default

    Field <|-- DualField

    OutputField ..> DualField
    OutputField : InputParam[]
    OutputField : EnumValue

    link Object "Schema.html#object-types"
    link Dual "Schema.html#dual-type"
    link Input "Schema.html#input-type"
    link Output "Schema.html#output-type"
```

## Operation

```mermaid
classDiagram
  direction LR

  Operation o.. Variable
  Operation o.. Directive
  Operation o.. Fragment

  Operation *-- Result
  Result *-- Domain : one
  Result *-- Object : of

  Domain o.. Argument
  Object o.. Argument

  link Operation "Operation.html#operation"
  link Variable "Operation.html#variables"
  link Directive "Operation.html#directives"
  link Fragment "Operation.html#fragment"
  link Result "Operation.html#result"
  link Domain "Operation.html#domain"
  link Object "Operation.html#object"
  link Argument "Operation.html#argument"
```
