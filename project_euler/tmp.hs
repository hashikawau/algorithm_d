
import Control.Monad
import Data.Char
import System.IO


main :: IO ()
-- main = midd
-- main = loadFile "tmp.hs"
-- main = putStrLn $ show $ length $ takeWhile (<100000) primes
main = putStrLn $ show $ makeK "ab"

makeK :: String -> String
makeK (a:b:[]) = "aaaa"
makeK invalid = invalid

primes :: [Integer]
primes = 2 : filter isPrime [3,5..]
    where
        -- isPrime :: Integer -> Bool
        -- isPrime n = not $ any (isFactor n) (takeWhile (\x -> x <= floor (sqrt (fromIntegral n))) primes)
        isPrime n = all (not . isFactor n) (takeWhile (\x -> x <= floor (sqrt (fromIntegral n))) primes)
        -- isFactor :: Integer -> Integer -> Bool
        isFactor n x = n `mod` x == 0

loadFile :: String -> IO ()
loadFile filePath = do
    -- handle <- openFile "tmp.hs" ReadMode
    handle <- openFile filePath ReadMode
    contents <- hGetContents handle
    putStr contents
    hClose handle

mainShortLinesOnly :: IO ()
mainShortLinesOnly = interact' shortLinesOnly

interact' :: (String -> String) -> IO ()
interact' f = do
    str <- getContents
    putStrLn $ f str

shortLinesOnly :: String -> String
shortLinesOnly = unlines . filter (\line -> length line < 10) . lines

capslocker :: IO ()
capslocker = do
    l <- getContents
    putStrLn $ map toUpper l

echo :: IO ()
echo = do
    line <- getLine
    if null line
        then return ()
        else do
            putStrLn line
            main

midd :: IO ()
midd = mapM_ putStrLn procedures

procedures :: [String]
procedures = [
    proc4,
    proc3,
    proc2,
    proc1,

    (show $ (Empty :: List Int)),
    (show $ Cons 1 Empty),
    (show $ Cons 2 $ Cons 1 Empty),
    (show $ 2 `Cons` (1 `Cons` Empty)),

    (show $ Node 5 Leaf Leaf),
    (show $ Node 5 (Node 2 Leaf Leaf) Leaf),
    (show $ Node 5 (Node 2 Leaf Leaf) (Node 8 Leaf Leaf)),
    (show $ tree1),
    (show $ find 1 tree1),
    (show $ find 2 tree1),
    (show $ find 3 tree1),
    (show $ find 4 tree1),
    (show $ insert 4 tree1),
    (show $ find 4 $ insert 4 tree1),
    (show $ find 5 tree1),
    (show $ find 6 tree1),
    (show $ find 7 tree1),
    (show $ find 8 tree1),
    (show $ find 9 tree1),
    (show $ "----"),
    (show $ Red),
    (show $ Red == Red),
    (show $ Red == Green),
    (show $ Red /= Green),
    (show $ isEq Red Red),
    (show $ isEq Red Green),

    "good bye"]

-- ====================================
data TrafficLight = Red | Yellow | Green
instance Eq TrafficLight where
    Red    == Red    = True
    Yellow == Yellow = True
    Green  == Green  = True
    _      == _      = False
instance EEE TrafficLight where
    isEq Red Red       = True
    isEq Yellow Yellow = True
    isEq Green Green   = True
    isEq _ _           = False
instance Show TrafficLight where
    show Red    = "Red light"
    show Yellow = "Yellow light"
    show Green  = "Green light"

-- ====================================
class Eq a => EEE a where
    isEq :: a -> a -> Bool
    isEq x y = x == y

-- ====================================
data Btree a = Leaf | Node a (Btree a) (Btree a) deriving (Show, Read, Eq, Ord)
tree1 :: Btree Integer
tree1 = foldl (flip insert) Leaf [5,2,1,8]
-- tree1 = insert 8 $ insert 1 $ insert 2 $ insert 5 $ Leaf
--  (Node 5
--      (Node 2
--          (Node 1 Leaf Leaf)
--          Leaf)
--      (Node 8
--          (Leaf)
--          (Leaf)))

find :: Integer -> Btree Integer -> Maybe Integer
find _ Leaf                  = Nothing
find key (Node x left right) = case key `compare` x of
    EQ -> Just x
    LT -> find key left
    GT -> find key right

insert :: Integer -> Btree Integer -> Btree Integer
insert value Leaf                = Node value Leaf Leaf
insert value origin@(Node x left right) = case value `compare` x of
    EQ -> origin -- Node x left right
    LT -> Node x (insert value left) right
    GT -> Node x left (insert value right)

-- ====================================
data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)

proc4 :: String
proc4 = show $ (Left 3 :: Either Integer Integer) `compare` (Right 2 :: Either Integer Integer)

proc3 :: String
proc3 = show $ (Left 3 :: Either Integer Integer) `compare` (Left 2 :: Either Integer Integer)

data Vector a = Vector a a a deriving (Show, Read, Eq, Ord)

vplus :: (Num a) => Vector a -> Vector a -> Vector a
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

proc2 :: String
proc2 = show $ (read "Vector 1 2 3 " :: Vector Integer)

proc1 :: String
proc1 = show $ (Vector 1 2 3) `vplus` (Vector 6 5 4)


