{- CLI -}

module CLI (parseCharacters) where

import Options.Applicative
import Data.Monoid ((<>))

type Input = (String, String)

parseCharacters :: IO Input
parseCharacters = execParser opts

parseInputChars :: Parser Input
parseInputChars = (,)
  <$> strOption
  (help "First character" <> metavar "FIRST" <> short 'f')
  <*> strOption
  (help "Second character" <> metavar "SECOND" <> short 's')

opts :: ParserInfo Input
opts = info (parseInputChars <**> helper) (fullDesc <> description <> hd)
  where
    description = progDesc "Simple CLI App that gives you the set of films in common between two Star Wars characters"
    hd = header "SWAPP"

