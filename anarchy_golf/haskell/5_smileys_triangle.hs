module Main where

-- -------------------------------------
--
-- -------------------------------------
-- |
-- create triangle
--
-- >>> mkTriangle (-10)
-- [[]]
--
-- >>> mkTriangle 0
-- [[]]
--
-- >>> mkTriangle 1
-- [[0]]
--
-- >>> mkTriangle 2
-- [[0],[0,1]]
--
-- >>> mkTriangle 3
-- [[0],[0,1],[0,1,2]]
--
-- >>> mkTriangle 4
-- [[0],[0,1],[0,1,2],[0,1,2,3]]
--
-- >>> mkTriangle 5
-- [[0],[0,1],[0,1,2],[0,1,2,3],[0,1,2,3,4]]
--
mkTriangle :: Int -> [[Int]]
mkTriangle n
    | n > 0     = [[0..n] | n <- [0..(n-1)]]
    | otherwise = [[]]

-- -------------------------------------
--
-- -------------------------------------
-- |
-- convert [[0],[0,1],[0,1,2],[0,1,2,3],...] to ":-))..."
--
-- >>> convertToSmileys [[]]
-- [""]
--
-- >>> convertToSmileys [[0]]
-- [":"]
--
-- >>> convertToSmileys [[0], [0, 1]]
-- [":",":-"]
--
-- >>> convertToSmileys [[0], [0, 1], [0, 1, 2]]
-- [":",":-",":-)"]
--
-- >>> convertToSmileys [[0], [0, 1], [0, 1, 2], [0, 1, 2, 3]]
-- [":",":-",":-)",":-)))"]
--
-- >>> convertToSmileys [[0], [0, 1], [0, 1, 2], [0, 1, 2, 3], [0, 1, 2, 3, 4]]
-- [":",":-",":-)",":-)))",":-)))))"]
--
convertToSmileys :: [[Int]] -> [String]
convertToSmileys lst = [convertToSmiley str | str <- lst]

-- -------------------------------------
--
-- -------------------------------------
-- 
-- convert [0,1,2,3,...] to ":-))..."
--
-- >>> convertToSmiley []
-- ""
--
-- >>> convertToSmiley [0]
-- ":"
--
-- >>> convertToSmiley [0, 1]
-- ":-"
--
-- >>> convertToSmiley [0, 1, 2]
-- ":-)"
--
-- >>> convertToSmiley [0, 1, 2, 3]
-- ":-))"
--
-- >>> convertToSmiley [0, 1, 2, 3, 4]
-- ":-)))"
--
convertToSmiley :: [Int] -> String
convertToSmiley []          = ""
convertToSmiley (x : xs)    = convertToParts x ++ convertToSmiley xs

-- -------------------------------------
--
-- -------------------------------------
-- |
-- convert a number to smiley parts
--
-- >>> convertToParts (-1)
-- ""
--
-- >>> convertToParts 0
-- ":"
--
-- >>> convertToParts 1
-- "-"
--
-- >>> convertToParts 2
-- ")"
--
-- >>> convertToParts 3
-- "))"
--
-- >>> convertToParts 4
-- "))"
--
convertToParts :: Int -> String
convertToParts n
    | n < 0     = ""
    | n == 0    = ":"
    | n == 1    = "-"
    | n == 2    = ")"
    | otherwise = "))"

-- -------------------------------------
--
-- -------------------------------------
main :: IO ()
main = let
    order = 34
    in putStrLn (concatMap (\str -> str ++ "\n") (convertToSmileys (mkTriangle order)))

