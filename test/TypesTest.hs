{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
module TypesTest where

import Types
import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck
import Data.Aeson
import qualified Data.ByteString.Lazy as BS

main :: IO ()
main = defaultMain jsonTests

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

lukeJson :: BS.ByteString
lukeJson = ""

jsonTests :: TestTree
jsonTests = testGroup "JSON encoding / decoding tests"
  [
    testCase "character's json encoding" $ encode luke @=? lukeJson
  ]
