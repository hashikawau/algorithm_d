#! /bin/env runghc

main :: IO ()
main
    -- = putStrLn $ show $ properDivisors 220
    -- = putStrLn $ show $ sumOfProperDivisors 220
    -- = putStrLn $ show $ sumOfProperDivisors 284
    -- = putStrLn $ show $ filter onlyJust $ map (\x -> (x, amicablePair x)) [1..220]
    -- = putStrLn $ show $ filter onlyJust $ map (\x -> (x, amicablePair x)) [1..1000]
    -- = putStrLn $ show $ filter onlyJust $ map (\x -> (x, amicablePair x)) [1..10000]
    -- = putStrLn $ show $ sumOfAllAmicableNumbersUnder 220
    = putStrLn $ show $ sumOfAllAmicableNumbersUnder 10000

sumOfAllAmicableNumbersUnder :: Integer -> Integer
sumOfAllAmicableNumbersUnder n
    = sum $ filter isAmicable [1..n]

onlyJust :: (a, Maybe b) -> Bool
onlyJust (_, Nothing)  = False
onlyJust (_, (Just _)) = True

amicablePair :: Integer -> Maybe Integer
amicablePair n
    | n < 1     = Nothing
    | otherwise =
        let y = sumOfProperDivisors n
        in if y /= n && n == sumOfProperDivisors y then Just y else Nothing

isAmicable :: Integer -> Bool
isAmicable n
    | n < 1     = False
    | otherwise =
        let y = sumOfProperDivisors n
        in y /= n && n == sumOfProperDivisors y

sumOfProperDivisors :: Integer -> Integer
sumOfProperDivisors n
    = sum $ properDivisors n

properDivisors :: Integer -> [Integer]
properDivisors n
    = filter (\x -> n `mod` x == 0) [1..n`div`2]


