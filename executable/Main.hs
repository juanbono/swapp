
import CLI
import Types
import API
import Data.Monoid
import Control.Applicative

main :: IO ()
main = do
  InputChars first second <- parseCharacters -- get the input from command line

  firstResult  <- mkSearch first  -- search the first input
  secondResult <- mkSearch second -- search the second inpit
  case liftA2 filmsInCommon firstResult secondResult of
    Left err -> print ("Error: " <> show err)
    Right filmsUrl -> mapM_ printFilmName filmsUrl


