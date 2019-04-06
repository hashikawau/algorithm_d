

main :: IO ()
-- main = putStrLn $ show $ take 12 indexedFibonacciSeq
-- main = putStrLn $ show $ takeFirstWhere (\(i, x) -> digitsNum x >= 3) indexedFibonacciSeq
main = putStrLn $ show $ takeFirstWhere (\(i, x) -> digitsNum x >= 1000) indexedFibonacciSeq
    where digitsNum x = length $ show x

takeFirstWhere :: (a -> Bool) -> [a] -> a
takeFirstWhere pred seq = head $ filter pred seq

indexedFibonacciSeq :: [(Integer, Integer)]
indexedFibonacciSeq = zip [1..] fibonacciSeq

fibonacciSeq :: [Integer]
fibonacciSeq = 1 : 1 : zipWith (+) fibonacciSeq (tail fibonacciSeq)

