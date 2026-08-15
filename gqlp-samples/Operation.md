# Operation Samples

## Root

### argument-field-merge.gql+

```gqlp
{user(data:{status:"active" status:"premium" tags:"vip" tags:"test"}){id}}
```

### argument-nested-object.gql+

```gqlp
{user(filter:{address:{city:"NYC" state:"NY" zipRange:{min:10000 max:10999}}}){id}}
```

### argument-variable-merge.gql+

```gqlp
($first: String, $last: String) {person(name:{firstName: $first lastName: $last}){id}}
```

### complex.gql+

```gqlp
query Complex
($arg:String)
&named:Named{firstName lastName}
{complex(arg: $arg) {
  id
  |named
  relations[String]{|named}
  emails[] {|:String{address} |{userName domain}}
}}
```

### dictionary-argument-key.gql+

```gqlp
{search(mapping:{key1:"value1" key2:"value2"})[String]{result}}
```

### dictionary-nested.gql+

```gqlp
{data[String][Number]{id}}
```

### dictionary-optional-key.gql+

```gqlp
{users[Number?]{id name}}
```

### dictionary.gql+

```gqlp
{dict[String]}
```

### directive-field.gql+

```gqlp
{name @skip(if: true) email}
```

### directive-fragment.gql+

```gqlp
&user:User @cached {id name} {user{|user}}
```

### directive-inline.gql+

```gqlp
{entity {|:User @auth {id name} |@admin {email secret}}}
```

### directive-repeatable.gql+

```gqlp
{user(id: 1) @log(level: "debug") @metrics @cache(ttl: 300)}
```

### directive-spread.gql+

```gqlp
&addr:Address{street city} {user{|addr @deprecated}}
```

### directive-variable.gql+

```gqlp
($skip: Boolean = false) {name @include(if: $skip)}
```

### domain-argument.gql+

```gqlp
:Number("first")
```

### domain-dict.gql+

```gqlp
:Number[String]
```

### domain-list.gql+

```gqlp
:Number[]
```

### domain-optional.gql+

```gqlp
:Number?
```

### domain.gql+

```gqlp
:Number
```

### field-directive-multiple.gql+

```gqlp
{user{secretData @auth @restrict @audit email @deprecated @log}}
```

### field-directive-single.gql+

```gqlp
{user{id @include(if: true) name @skip(if: false)}}
```

### fragment-end.gql+

```gqlp
{|named}fragment named on Named{name}
```

### fragment-list.gql+

```gqlp
&named:Named{name}{|named[]}
```

### fragment.gql+

```gqlp
&named:Named{name}{|named}
```

### inline-list.gql+

```gqlp
{simple |[]{extra}}
```

### inline-nested-complex.gql+

```gqlp
&address:Profile{email website}
&role:Permission{name}
{entity{|:User{profile{|address}}|:Admin{permissions{|role}}}}
```

### inline-typed.gql+

```gqlp
{simple |:Extra{extra}}
```

### inline-with-directive.gql+

```gqlp
{entity|:Admin @auth @restrict {secret}}
```

### inline-with-modifiers.gql+

```gqlp
{entity|:User []{id name}}
```

### inline.gql+

```gqlp
{simple |{extra}}
```

### list.gql+

```gqlp
{list[]}
```

### object-dict.gql+

```gqlp
{object[String]{first last}}
```

### object-list.gql+

```gqlp
{object[]{first last}}
```

### object.gql+

```gqlp
{object{first last}}
```

### simple-alias.gql+

```gqlp
{alias:simple}
```

### simple-argument.gql+

```gqlp
{simple(true)}
```

### simple-optional.gql+

```gqlp
{simple?}
```

### simple-required.gql+

```gqlp
{simple!}
```

### simple.gql+

```gqlp
{simple}
```

### spread-with-modifiers.gql+

```gqlp
&baseFields:User{id name} {user{|baseFields[]} admin{|baseFields}}
```

### spread.gql+

```gqlp
&baseFields:User{id name} {user{|baseFields}}
```

### variable-null.gql+

```gqlp
($var:Id?=null):Boolean($var)
```

### variable.gql+

```gqlp
($var):Boolean($var)
```

