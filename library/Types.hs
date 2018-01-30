{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}

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

data Film
  = Film
  { title         :: Text
  , episode_id    :: Text
  , opening_crawl :: Text
  , director      :: Text
  , producer      :: Text
  , release_date  :: Text
  , species       :: [Text]
  , starships     :: [Text]
  , vehicles      :: [Text]
  , characters    :: [Text]
  , planets       :: [Text]
  , url           :: [Text]
  , created       :: [Text]
  , edited        :: [Text]
  } deriving (Show, Generic)

instance ToJSON Film where
instance FromJSON Film where

data Character
  = Character
    { -- | The name of this person.
      name :: Text
      -- | The height of this person in meters.
    , height :: Text
      -- | The mass of this person in kilograms.
    , mass :: Text
      -- | The hair color of this person.
    , hair_color :: Text
      -- | The skin color of this person.
    , skin_color :: Text
      -- | The eye color of this person.
    , eye_color :: Text
      -- | The birth year of this person.
    , birth_year :: Text
      -- | The gender of this person (if known).
    , gender :: Text
      -- | The url of the planet resource that this person was born on.
    , homeworld :: Text
      -- | A list of urls of film resources that this person has been in.
    , films :: [Text]
      -- | The url of the species resource that this person is.
    , species :: [Text]
      -- | A list of vehicle resources that this person has piloted
    , vehicles :: [Text]
      -- | A list of starship resources that this person has piloted
    , starships :: [Text]
      -- | The url of this resource
    , url :: Text
      -- | The ISO 8601 date format of the time that this resource was created.
    , created :: Text -- UTC.Time
      -- | the ISO 8601 date format of the time that this resource was edited.
    , edited :: Text
    } deriving (Show, Generic)

instance ToJSON Character
instance FromJSON Character

data SearchError
  = AmbiguousName String Integer
  | NotFound
  | MagicError
  deriving (Eq)

instance Show SearchError where
  show (AmbiguousName input numberOfResults)
    = "\"" ++ input ++ "\" is ambiguous, " ++ "it has " ++ show numberOfResults
    ++ " possible matches, please be more specific."
  show NotFound = "Not found"
  show MagicError = "Unknown error"
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

luke :: Character
luke = Character
  { name = "Luke Skywalker"
  , height = "172"
  , mass = "77"
  , hair_color = "blond"
  , skin_color = "fair"
  , eye_color = "blue"
  , birth_year = "19BBY"
  , gender = "male"
  , homeworld = "https://swapi.co/api/planets/1/"
  , films = [ "https://swapi.co/api/films/2/"
            , "https://swapi.co/api/films/6/"
            , "https://swapi.co/api/films/3/"
            , "https://swapi.co/api/films/1/"
            , "https://swapi.co/api/films/7/"
            ]
  , species = [ "https://swapi.co/api/species/1/" ]
  , vehicles = [ "https://swapi.co/api/vehicles/14/"
               , "https://swapi.co/api/vehicles/30/"
               ]
  , starships = [ "https://swapi.co/api/starships/12/"
                , "https://swapi.co/api/starships/22/"
                ]
  , created = "2014-12-09T13:50:51.644000Z"
  , edited = "2014-12-20T21:17:56.891000Z"
  , url = "https://swapi.co/api/people/1/"
  }

