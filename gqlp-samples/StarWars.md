# StarWars Samples

## Root

### droids.yaml

```
2000:
  id: 2000
  name: C-3PO
  friends: [1000, 1002, 1003, 2001]
  appearsIn: [NewHope, Empire, Jedi]
  primaryFunction: Protocol

2001:
  id: 2001
  name: R2-D2
  friends: [1000, 1002, 1003]
  appearsIn: [NewHope, Empire, Jedi]
  primaryFunction: Astromech
```

### episode-hero.yaml

```
NewHope: 2001
Empire: 1000
Jedi: 2001
```

### humans.yaml

```
1000:
  id: 1000
  name: Luke Skywalker
  friends: [1002, 1003, 2000, 2001]
  appearsIn: [NewHope, Empire, Jedi]
  homePlanet: Tatooine

1001:
  id: 1001
  name: Darth Vader
  friends: [1004]
  appearsIn: [NewHope, Empire, Jedi]
  homePlanet: Tatooine

1002:
  id: 1002
  name: Han Solo
  friends: [1000, 1003, 2001]
  appearsIn: [NewHope, Empire, Jedi]
  homePlanet: null

1003:
  id: 1003
  name: Leia Organa
  friends: [1000, 1002, 2000, 2001]
  appearsIn: [NewHope, Empire, Jedi]
  homePlanet: Alderaan

1004:
  id: 1004
  name: Wilhuff Tarkin
  friends: [1001]
  appearsIn: [NewHope]
  homePlanet: null
```

### schema.gqlp

```gqlp
output Query {
    hero(Episode?): Character
    human(String): Human
    droid(Id): Droid
}

enum Episode {
    NewHope
    Empire
    Jedi
}

output Character {
    id: Id
    name: String
    friends: Character[]?
    appearsIn: Episode[]
}

domain Id { Number > 1000 }

output Human {
    :  Character
    homePlanet: String
}

output Droid {
    :  Character
    primaryFunction: String
}
```
