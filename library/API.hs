{- API related functions -}
{-# LANGUAGE OverloadedStrings #-}
module API (mkSearch, printFilmName) where

import Types

import Data.Aeson (decode)
import qualified Data.Text as T
import Network.HTTP.Simple (httpLbs, getResponseBody, parseRequest_)
import Data.Monoid ((<>))
import Data.Maybe (fromJust)

baseUrl :: String
baseUrl = "https://swapi.co/api/people/?search="

getFilmName :: T.Text -> IO T.Text
getFilmName resource = do
  response <- httpLbs $ parseRequest_ (T.unpack resource)
  let film = decode . getResponseBody $ response
  return $ title (fromJust film)

printFilmName :: T.Text -> IO ()
printFilmName x = do
  filmName <- getFilmName x
  print filmName

mkSearch :: String -> IO SearchResult
mkSearch character = do
  let queryUrl = parseRequest_ (baseUrl <> character)
  response <- httpLbs queryUrl
  let search = fromJust . decode . getResponseBody $ response
  case count search of
    0 -> return $ Left (NotFound character)
    1 -> return $ Right (head . results $ search)
    n -> return $ Left (AmbiguousName character n)
