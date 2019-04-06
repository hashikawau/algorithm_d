
import Data.Char(toUpper)
import Data.List(permutations, foldl')
import System.Environment(getProgName)

main :: IO ()
-- main = putStrLn $ show $ primePairSets
-- main = putStrLn $ show $ concatMap' (\x -> [[0..x]]) [1..3]
-- main = do
--     progName <- getProgName
--     putStrLn $ progName
main = do
    progName <- fmap (map toUpper) getProgName
    putStrLn $ progName
-- main = mapM_ putStrLn procs

procs :: [] String
procs =
    [ "hello"
    , "world"
    ]


concatMap' :: (a -> [b]) -> [a] -> [b]
concatMap' f xs = foldl' (++) [] $ map f xs


primePairSets :: Bool
primePairSets = isPrime 7110

isPrime :: Integer -> Bool
isPrime n = all (not . isFactor n) (2 : [3,5..(floor (sqrt (fromIntegral n)))])
    where isFactor n x = n `mod` x == 0

