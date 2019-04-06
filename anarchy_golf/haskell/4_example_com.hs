module Main where

import Network.HTTP -- anarchy golf seem not have haskell module Network.HTTP

main :: IO ()
--main = let url = "http://www.example.com/"
main = do
    url         <- getLine
    response    <- simpleHTTP (getRequest url)
    body        <- getResponseBody response
    putStr body

