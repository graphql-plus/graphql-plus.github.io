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
```

### Simple types

```mermaid
classDiagram
    direction LR

    Simple : *~Item~[] Members

    Simple <|-- Domain
    Simple <|-- Enum
    Simple <|-- Union

    <<Declaration>> Domain
    Domain : Kind

    Domain *-- TrueFalse : Kind = Boolean
    Domain *-- Member : Kind = Enum
    Domain *-- Range : Kind = Number
    Domain *-- Regex : Kind = String

    TrueFalse --|> Item
    Member --|> Item
    Range --|> Item
    Regex --|> Item

    Item : Excluded

    <<Declaration>> Enum
    <<Declaration>> Union
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

```

## Operation

```mermaid
classDiagram
  direction LR

  Operation *.. Variable
  Operation *.. Directive
  Operation *.. Fragment
```
