
import CLI
import Types
import qualified Data.Text as T
import qualified API as API
import Data.Monoid
import Control.Applicative

main :: IO ()
main = do
  InputChars first second <- parseCharacters -- get the input from command line

  firstResult  <- API.mkSearch first
  secondResult <- API.mkSearch second
  case liftA2 filmsInCommon firstResult secondResult of
    Left err -> print ("Error: " <> show err)
    Right filmsUrl -> print filmsUrl


