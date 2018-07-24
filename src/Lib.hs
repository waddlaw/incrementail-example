{-# LANGUAGE TypeFamilies #-}
module Lib where

import Data.Incremental

data Person = Person
  { name :: Char
  , age  :: Int
  } deriving (Eq, Show)

data PersonDiff = PersonDiff
  { diffName :: Maybe Char
  , diffAge  :: Maybe Int
  } deriving (Eq, Show)

instance Incremental Person where
  type Delta Person = PersonDiff
  -- patch _ _ = ()
  diff (Person name1 age1) (Person name2 age2) = Just $ PersonDiff (diff name1 name2) (diff age1 age2)

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