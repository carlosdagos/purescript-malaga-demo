module Examples.Maybe where

data Maybe a = Nothing | Just a

-- Is this function "safe"?
fromJust :: forall a. Partial => Maybe a -> a
fromJust (Just x) = x


-- A little bit more "complicated"
-- What does this represent?
data Either a b = Left a | Right b

either :: forall a b c. Either a b -> (a -> c) -> (b -> c) -> c
either e f g = case e of
                 Left x  -> f x
                 Right y -> g y

