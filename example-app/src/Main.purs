module Main where

import Prelude
import Examples.Functions
import Examples.List
import Examples.Game
import Examples.Maybe
import Examples.Foreign
import Control.Monad.Eff         (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
