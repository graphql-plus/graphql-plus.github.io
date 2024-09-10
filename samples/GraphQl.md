# GraphQl Samples

## Root

### Example_003.gql

```
{
  user(id: 4) {
    name
  }
}
```

### Example_005.gql

```
mutation {
  likeStory(storyID: 12345) {
    story {
      likeCount
    }
  }
}
```

### Example_006.gql

```
{
  field
}
```

### Example_007.gql

```
{
  id
  firstName
  lastName
}
```

### Example_008.gql

```
{
  me {
    id
    firstName
    lastName
    birthday {
      month
      day
    }
    friends {
      name
    }
  }
}
```

### Example_009a.gql

```
{
  me {
    name
  }
}
```

### Example_009b.gql

```
{
  user(id: 4) {
    name
  }
}
```

### Example_010.gql

```
{
  user(id: 4) {
    id
    name
    profilePic(size: 100)
  }
}
```

### Example_011.gql

```
{
  user(id: 4) {
    id
    name
    profilePic(width: 100, height: 50)
  }
}
```

### Example_012.gql

```
{
  picture(width: 200, height: 100)
}
```

### Example_013.gql

```
{
  picture(height: 100, width: 200)
}
```

### Example_014.gql

```
{
  user(id: 4) {
    id
    name
    smallPic: profilePic(size: 64)
    bigPic: profilePic(size: 1024)
  }
}
```

### Example_016.gql

```
{
  zuck: user(id: 4) {
    id
    name
  }
}
```

### Example_018.gql

```
query noFragments {
  user(id: 4) {
    friends(first: 10) {
      id
      name
      profilePic(size: 50)
    }
    mutualFriends(first: 10) {
      id
      name
      profilePic(size: 50)
    }
  }
}
```

### Example_019.gql

```
query withFragments {
  user(id: 4) {
    friends(first: 10) {
      ...friendFields
    }
    mutualFriends(first: 10) {
      ...friendFields
    }
  }
}

fragment friendFields on User {
  id
  name
  profilePic(size: 50)
}
```

### Example_020.gql

```
query withNestedFragments {
  user(id: 4) {
    friends(first: 10) {
      ...friendFields
    }
    mutualFriends(first: 10) {
      ...friendFields
    }
  }
}

fragment friendFields on User {
  id
  name
  ...standardProfilePic
}

fragment standardProfilePic on User {
  profilePic(size: 50)
}
```

### Example_021.gql

```
query FragmentTyping {
  profiles(handles: ["zuck", "coca-cola"]) {
    handle
    ...userFragment
    ...pageFragment
  }
}

fragment userFragment on User {
  friends {
    count
  }
}

fragment pageFragment on Page {
  likers {
    count
  }
}
```

### Example_023.gql

```
query inlineFragmentTyping {
  profiles(handles: ["zuck", "coca-cola"]) {
    handle
    ... on User {
      friends {
        count
      }
    }
    ... on Page {
      likers {
        count
      }
    }
  }
}
```

### Example_024.gql

```
query inlineFragmentNoType($expandedInfo: Boolean) {
  user(handle: "zuck") {
    id
    name
    ... @include(if: $expandedInfo) {
      firstName
      lastName
      birthday
    }
  }
}
```

### Example_025.gql

```
mutation {
  sendEmail(
    message: """
    Hello,
      World!

    Yours,
      GraphQL.
    """
  )
}
```

### Example_026.gql

```
mutation {
  sendEmail(message: "Hello,\n  World!\n\nYours,\n  GraphQL.")
}
```

### Example_029.gql

```
{
  field(arg: null)
  field
}
```

### Example_030.gql

```
{
  nearestThing(location: { lon: 12.43, lat: -53.211 })
}
```

### Example_031.gql

```
{
  nearestThing(location: { lat: -53.211, lon: 12.43 })
}
```

### Example_032.gql

```
query getZuckProfile($devicePicSize: Int) {
  user(id: 4) {
    id
    name
    profilePic(size: $devicePicSize)
  }
}
```
