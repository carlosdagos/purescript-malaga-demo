module Main where

import Prelude
import Examples.Functions
import Examples.List
import Examples.Game
import Examples.Maybe
import Examples.Foreign
import Control.Monad.Eff         (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

type MyRecord t = { name :: String
                  , lastName :: String
                  | t
                  }

fullName :: forall t. MyRecord t -> String
fullName record = record.name <> " " <> record.lastName

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
