#! /bin/env runghc

module Main where

main :: IO ()
main = putStrLn $ show $ sum $ makeFactorSequence [3, 5] [1..999]

makeFactorSequence :: [Integer] -> [Integer] -> [Integer]
makeFactorSequence factorList naturalNumbers
    = [x | x <- naturalNumbers,
           any (isFactorOf x) factorList]

isFactorOf :: Integer -> Integer -> Bool
isFactorOf multiple factor = multiple `mod` factor == 0

