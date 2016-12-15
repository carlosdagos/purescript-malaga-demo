module Examples.List where

import Prelude ((==))
import Data.Maybe

data List a = End | Cons a (List a)

infixr 6 Cons as :

myList :: List Int
myList = Cons 1 (Cons 2 (Cons 3 End))

-- It's equivalent, only showing an infix contructor
myInfixList :: List Int
myInfixList = 1 : 2 : 3 : End

emptyList :: List Int
emptyList = End

find :: Int -> List Int -> Maybe Int
find x (Cons y rest) =
    if x == y
       then Just x
       else find x rest
find _ End = Nothing

-- It's equivalent, only showing a pattern-match with an infix constructor
findWithInfixPattern :: Int -> List Int -> Maybe Int
findWithInfixPattern x (y:rest) =
    if x == y
       then Just x
       else findWithInfixPattern x rest
findWithInfixPattern _ End = Nothing
