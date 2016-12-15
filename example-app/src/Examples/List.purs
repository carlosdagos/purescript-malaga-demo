module Examples.List where

import Prelude ((==))
import Data.Maybe

data List a = End | Cons a (List a)

myList :: List Int
myList = Cons 1 (Cons 2 (Cons 3 End))

emptyList :: List Int
emptyList = End

find :: Int -> List Int -> Maybe Int
find x (Cons y rest) =
    if x == y
       then Just x
       else find x rest
find _ End = Nothing

