module Common
( primes
) where

primes :: [Integer]
primes = 2 : filter isPrime [3,5..]
    where
        isFactor n x = n `mod` x == 0
        isPrime n = all
            (not . isFactor n)
            (takeWhile (<= (floor . sqrt . fromIntegral) n) primes)

