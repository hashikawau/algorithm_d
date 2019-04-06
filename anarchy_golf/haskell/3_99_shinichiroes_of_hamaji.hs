module Main (main) where

import Text.Printf

-- ------------------------------------
--
-- ------------------------------------
-- |
-- show number of shinichiro of hamaji
--
-- >>> showShinOfHam 1
-- "1 shinichiro of hamaji"
--
-- >>> showShinOfHam 2
-- "2 shinichiroes of hamaji"
--
-- >>> showShinOfHam 3
-- "3 shinichiroes of hamaji"
--
-- >>> showShinOfHam 30
-- "30 shinichiroes of hamaji"
--
showShinOfHam :: Int -> String
showShinOfHam n
    | n == 1    = printf "%d shinichiro of hamaji" n
    | otherwise = printf "%d shinichiroes of hamaji" n

-- ------------------------------------
--
-- ------------------------------------
-- |
-- message function
--
-- >>> message 1
-- "1 shinichiro of hamaji on the wall, 1 shinichiro of hamaji.\nGo to the store and buy some more, 99 shinichiroes of hamaji on the wall."
--
-- >>> message 2
-- "2 shinichiroes of hamaji on the wall, 2 shinichiroes of hamaji.\nTake one down and pass it around, 1 shinichiro of hamaji on the wall."
--
-- >>> message 98
-- "98 shinichiroes of hamaji on the wall, 98 shinichiroes of hamaji.\nTake one down and pass it around, 97 shinichiroes of hamaji on the wall."
--
-- >>> message 99
-- "99 shinichiroes of hamaji on the wall, 99 shinichiroes of hamaji.\nTake one down and pass it around, 98 shinichiroes of hamaji on the wall."
--

message :: Int -> String
message n
    | n == 1    = printf "%s on the wall, %s.\n\
                         \Go to the store and buy some more, %s on the wall." (showShinOfHam 1) (showShinOfHam 1) (showShinOfHam 99)
    | otherwise = printf "%s on the wall, %s.\n\
                         \Take one down and pass it around, %s on the wall." (showShinOfHam n) (showShinOfHam n) (showShinOfHam (n-1))

main :: IO ()
main = f [99, 98..1] where
    f []        = putStrLn ""
    f (x : xs)  = do
                    putStrLn (message x ++ "\n")
                    f xs

