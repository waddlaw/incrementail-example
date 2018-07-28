{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeOperators     #-}
module Lib where

import           Data.Extensible
import           Data.Incremental

type Person = Record
  '[ "name" >: String
   , "age"  >: Int
   ]

type PersonDiff = Record
  '[ "name" >: Maybe String
   , "age"  >: Maybe Int
   ]

instance Incremental String where
  type Delta String = String
  diff str1 str2 =
    if str1 == str2
    then Nothing
    else Just ""

alice :: Person
alice = #name @= "Alice"
     <: #age  @= 10
     <: nil

bob :: Person
bob = #name @= "Bob"
   <: #age  @= 10
   <: nil

fakeBob :: Person
fakeBob = #name @= "BoB"
       <: #age  @= 14
       <: nil

example :: IO ()
example = do
  print $ diff alice bob
  print $ diff alice fakeBob
  print $ diff bob fakeBob
  print $ diff bob bob
