#! /bin/env runghc

main :: IO ()
-- main = putStrLn $ show $ take 10 fibonacci
-- main = putStrLn $ show $ evenFibonacciBelow 4000000
main = putStrLn $ show $ sum $ evenFibonacciBelow 4000000

evenFibonacciBelow :: Integer -> [Integer]
evenFibonacciBelow n
    = filter (\x -> x `mod` 2 == 0)
    $ takeWhile (\x -> x < n) fibonacci

fibonacci :: [Integer]
fibonacci
    = 1 : 2 : zipWith (+) fibonacci (tail fibonacci)

