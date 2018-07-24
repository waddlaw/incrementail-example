# incremental-example

```hs
alice :: Person
alice = Person 'a' 10

bob :: Person
bob = Person 'b' 10

fakeBob :: Person
fakeBob = Person 'B' 14

example :: IO ()
example = do
  print $ diff alice bob
  print $ diff alice fakeBob
  print $ diff bob fakeBob
  print $ diff bob bob
```

```hs
*Lib Lib> example
Just (PersonDiff {diffName = Just 'b', diffAge = Nothing})
Just (PersonDiff {diffName = Just 'B', diffAge = Just 14})
Just (PersonDiff {diffName = Just 'B', diffAge = Just 14})
Just (PersonDiff {diffName = Nothing, diffAge = Nothing})
```
