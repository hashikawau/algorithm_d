#! /bin/env runghc

import Data.List

main :: IO ()
-- main = putStrLn $ show $ productsOf2 10 99
-- main = putStrLn $ show $ isNumberPalindrome 906609
-- main = putStrLn $ show $ head $ filter (isNumberPalindrome) (productsOf2 10 99)
main = putStrLn $ show $ head $ filter (isNumberPalindrome) (productsOf2 100 999)

productsOf2 :: Integer -> Integer -> [Integer]
productsOf2 lower upper = sortBy (flip compare) [x * y | x <- [lower..upper],
                                                         y <- [lower..x]]

isNumberPalindrome :: Integer -> Bool
isNumberPalindrome n = isPalindrome $ show n

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome [] = True
isPalindrome (_:[]) = True
isPalindrome (x:xs) = (x == (last xs)) && isPalindrome (init xs)

