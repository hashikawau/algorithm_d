-- #! /bin/env runghc

import Data.List(sortBy, permutations)

main :: IO ()
main = putStrLn $ show $ lexicographicPermutations 1000000

lexicographicPermutations :: Integer -> String
lexicographicPermutations nth
    = toString $ (sortBy compare $ permutations [0..9])!!((fromIntegral nth) - 1)

toString :: [Integer] -> String
toString []     = ""
toString (x:xs) = show x ++ toString xs

