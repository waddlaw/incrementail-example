{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Lib where

import Data.Incremental

data Person = Person
  { name :: String
  , age  :: Int
  } deriving (Eq, Show)

data PersonDiff = PersonDiff
  { diffName :: Maybe String
  , diffAge  :: Maybe Int
  } deriving (Eq, Show)

instance Incremental String where
  type Delta String = String
  diff str1 str2 =
    if str1 == str2
    then Nothing
    else Just ""

instance Incremental Person where
  type Delta Person = PersonDiff
  diff (Person name1 age1) (Person name2 age2) = Just $ PersonDiff (diff name1 name2) (diff age1 age2)

alice :: Person
alice = Person "Alice" 10

bob :: Person
bob = Person "Bob" 10

fakeBob :: Person
fakeBob = Person "BoB" 14

example :: IO ()
example = do
  print $ diff alice bob
  print $ diff alice fakeBob
  print $ diff bob fakeBob
  print $ diff bob bob