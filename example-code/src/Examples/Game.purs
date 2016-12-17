module Examples.Game where

data Hand    = Rock    | Paper   | Scissors
data Winning = Player1 | Player2 | Tied

winningHand :: Hand -> Hand -> Winning
winningHand Rock     Paper    = Player2
winningHand Rock     Scissors = Player1
winningHand Paper    Rock     = Player1
winningHand Paper    Scissors = Player2
winningHand Scissors Rock     = Player2
winningHand Scissors Paper    = Player1
-- Catchall clause
winningHand _ _               = Tied
