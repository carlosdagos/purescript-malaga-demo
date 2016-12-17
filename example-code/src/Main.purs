module Main where

import Prelude
import Examples.Functions
import Examples.List
import Examples.Game
import Examples.Maybe
import Examples.Foreign
import Control.Monad.Eff         (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

-- Example for record types
type MyRecord t = { name :: String
                  , lastName :: String
                  | t
                  }

fullName :: forall t. MyRecord t -> String
fullName record = record.name <> " " <> record.lastName

-- Examples for effects
trivialEff :: forall e. Eff e String
trivialEff = pure "World"

main :: Eff (console :: CONSOLE) Unit
main = do
  string <- trivialEff
  log "Hey what's up..."
  log $ "..." <> string <> "!"
