

main :: IO ()
-- main = putStrLn $ show $ numberSpiralDiagonals 5
main = putStrLn $ show $ numberSpiralDiagonals 1001
-- main = putStrLn $ show $ map sumOfDiagonals [0..5]

numberSpiralDiagonals :: Integer -> Integer
numberSpiralDiagonals n
    | even n    = 0
    | otherwise = sum $ map sumOfDiagonals [0..(n-1)`div`2]

sumOfDiagonals :: Integer -> Integer
sumOfDiagonals 0 = 1
sumOfDiagonals m
    = n * n + 1 * 2 * m
    + n * n + 2 * 2 * m
    + n * n + 3 * 2 * m
    + n * n + 4 * 2 * m
    where n = 2 * m - 1

