#! /bin/env runghc

import Data.List

main :: IO ()
-- main = putStrLn $ show $ divisors 28
-- main = putStrLn $ show $ map divisors [1,3,6,10,15,21,28]
-- main = putStrLn $ show $ highlyDivisibeTringularNumber 5
main = putStrLn $ show $ highlyDivisibeTringularNumber 500

highlyDivisibeTringularNumber :: Integer -> Integer
highlyDivisibeTringularNumber n = takeFirstIf (\x -> numDivisors x > n) triangleNumberSequence

triangleNumberSequence :: [Integer]
triangleNumberSequence = 1 : zipWith (+) triangleNumberSequence [2..]

takeFirstIf :: (a -> Bool) -> [a] -> a
takeFirstIf pred xs = head $ filter pred xs

numDivisors :: Integer -> Integer
numDivisors n = fromIntegral $ length $ divisors n

divisors :: Integer -> [Integer]
divisors n = sort $ nub $ firstHalf ++ secondHalf
    where
        firstHalf  = divisorsUnderSqrt n
        secondHalf = map (n`div`) firstHalf

divisorsUnderSqrt :: Integer -> [Integer]
divisorsUnderSqrt n = filter isFactor [1..floor $ sqrt $ fromIntegral n]
    where isFactor x = n `mod` x == 0

