#! /bin/env runghc

import Data.List

main :: IO ()
main = putStrLn $ show $
    let
        -- n = 13195
        n = 600851475143
    in
        find (\x -> n `mod` x == 0)
        $ reverse
        $ takeWhile (\x -> x < round (sqrt (fromIntegral n))) primes

primes :: [Int]
primes = 2 : 3 : filter (isPrime primes) [5, 7..]

isPrime :: [Int] -- Primes discovered "so far"
        -> Int   -- Number we are checking for primality
        -> Bool
isPrime (p:ps) n
    -- No need to check divisors past sqrt(n), we know n is prime
    | p*p > n = True 
    -- Otherwise, it's prime if none of the primes we've discovered so far divide it evenly
    | otherwise = n `rem` p /= 0 && isPrime ps n

