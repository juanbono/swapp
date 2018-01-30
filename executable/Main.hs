
import CLI

main :: IO ()
main = do
  InputChars first second <- parseCharacters -- get the input from command line

  print $ "First Character: " ++ first
  print $ "Second Character: " ++ second

