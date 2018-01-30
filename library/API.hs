{- API related functions -}
{-# LANGUAGE OverloadedStrings #-}
module API (queryCharacter) where

import Types

import Data.Aeson
import Data.Aeson.Lens
import Control.Lens
import Network.HTTP.Simple
import Data.Monoid
import Data.Maybe
import Data.Text.Encoding
import qualified Data.ByteString.Char8 as C8
import qualified Data.ByteString.Lazy as BS
import qualified Data.Vector as V

baseUrl :: String
baseUrl = "https://swapi.co/api/people/?search="

data SearchError
  = AmbiguousName Integer
  | NotFound
  | MagicError
  deriving (Show, Eq)

type SearchResult = Either SearchError Character

-- | Number of results from the query
count :: Value -> Maybe Integer
count obj = obj ^? key "count" . _Integer

-- | Get the query's first resource
getFirstResource :: Value -> C8.ByteString
getFirstResource obj = encodeUtf8 . fromJust $ firstValue ^? _String
  where
    firstValue = fromJust $ V.head <$> obj ^? key "results" . _Array

mkResult :: Value -> Either SearchError Character
mkResult v = case count v of
  Nothing -> Left MagicError
  Just 1  -> Right undefined-- (decode $ getFirstResource v)
  Just 0  -> Left NotFound
  Just n  -> Left (AmbiguousName n)

mkRequest :: String -> IO Value
mkRequest character = do
  let queryUrl = parseRequest_ (baseUrl <> character)
  response <- httpJSON queryUrl
  return (getResponseBody response :: Value)

queryCharacter :: String -> IO (Either SearchError Character)
queryCharacter character = do
  characterValue <- mkRequest character
  return $ mkResult characterValue
