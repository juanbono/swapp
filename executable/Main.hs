
import CLI
import Types
import qualified Data.Text as T
import qualified API as API
import Control.Applicative

main :: IO ()
main = do
  InputChars first second <- parseCharacters -- get the input from command line

  a <- API.mkSearch first
  b <- API.mkSearch second
  let films = liftA2 filmsInCommon a b
  print $ "First Character: " ++ first
  print $ "Second Character: " ++ second
  print films

