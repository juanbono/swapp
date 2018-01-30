{- API related functions -}
{-# LANGUAGE OverloadedStrings #-}
module API (mkSearch) where

import Types

import Data.Aeson
import Network.HTTP.Simple
import Data.Monoid
import Data.Maybe

baseUrl :: String
baseUrl = "https://swapi.co/api/people/?search="

mkSearch :: String -> IO SearchResult
mkSearch character = do
  let queryUrl = parseRequest_ (baseUrl <> character)
  response <- httpLbs queryUrl
  let search = fromJust . decode . getResponseBody $ response
  case count search of
    0 -> return $ Left NotFound
    1 -> return $ Right (head . results $ search)
    n -> return $ Left (AmbiguousName n)
