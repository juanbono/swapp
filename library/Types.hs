{-# LANGUAGE DeriveGeneric #-}
module Types
  ( Character(..)
  , Film(..)
  , Search(..)
  , SearchError(..)
  , SearchResult
  , filmsInCommon
  ) where

import GHC.Generics
import Data.Text
import Data.Aeson
import Data.List

newtype Film = Film { title :: Text }
  deriving (Show, Generic)

instance ToJSON Film where
instance FromJSON Film where

data Character
  = Character
    { -- | The name of this person.
      name :: Text
      -- | A list of urls of film resources that this person has been in.
    , films :: [Text]
    } deriving (Eq, Show, Generic)

instance ToJSON Character
instance FromJSON Character

data SearchError
  = AmbiguousName String Integer
  | NotFound String

instance Show SearchError where
  show (AmbiguousName input numberOfResults)
    = "'" ++ input ++ "'" ++ " is ambiguous, " ++ "it has " ++ show numberOfResults
    ++ " possible matches, please be more specific."
  show (NotFound input) = "'" ++ input ++ "'" ++ " can not be found."

data Search = Search
  { count :: Integer
  , results :: [Character]
  } deriving (Show, Generic)

instance ToJSON Search
instance FromJSON Search

type SearchResult = Either SearchError Character

filmsInCommon :: Character -> Character -> [Text]
filmsInCommon character1 character2 = films1 `intersect` films2
  where
    films1 = films character1
    films2 = films character2
