{- CLI -}

module CLI (parseCharacters, InputChars(..)) where

import Options.Applicative
import Data.Monoid

parseCharacters :: IO InputChars
parseCharacters = execParser opts

data InputChars = InputChars
  { firstCharacter  :: String
  , secondCharacter :: String
  } deriving (Show, Eq)

parseInputChars :: Parser InputChars
parseInputChars = InputChars
  <$> strOption
  (help "First character" <> metavar "FIRST" <> short 'f')
  <*> strOption
  (help "Second character" <> metavar "SECOND" <> short 's')

opts :: ParserInfo InputChars
opts = info (parseInputChars <**> helper) (fullDesc <> description <> hd)
  where
    description = progDesc "Simple CLI App that gives you the set of films in common between two Star Wars characters"
    hd = header "SWAPP"

