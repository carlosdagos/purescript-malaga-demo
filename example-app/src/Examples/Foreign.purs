module Examples.Foreign where

-- Import some functions from lodash

foreign import reverse :: forall a. Array a -> Array a
foreign import slice :: forall a. Array a -> Int -> Int -> Array a
