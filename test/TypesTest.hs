{-# LANGUAGE OverloadedStrings #-}
module TypesTest where

import Types
import Test.Tasty (testGroup, TestTree, defaultMain)
import Test.Tasty.HUnit (testCase, assertEqual)
import Data.Aeson (decode)
import qualified Data.ByteString.Lazy as BS
import Data.Maybe (fromJust)

main :: IO ()
main = defaultMain test_json

luke :: Character
luke = Character
  { name = "Luke Skywalker"
  , films = [ "https://swapi.co/api/films/2/"
            , "https://swapi.co/api/films/6/"
            , "https://swapi.co/api/films/3/"
            , "https://swapi.co/api/films/1/"
            , "https://swapi.co/api/films/7/"
            ]
  }

decodingWorksFine :: TestTree
decodingWorksFine = testCase "character's json decoding" $ do
  lukeJson <- BS.readFile "test/luke.json"
  assertEqual "decode" luke (fromJust $ decode lukeJson)

test_json :: TestTree
test_json = testGroup "JSON encoding / decoding tests"
  [ decodingWorksFine ]
