
import Data.List(maximumBy, intersperse, findIndex)

main :: IO ()
-- main = putStrLn $ show $ zip xs $ map unitFraction'' xs
-- main = putStrLn $ show $ zip xs $ map (lengthRecurring . unitFraction'') xs
-- main = putStrLn $ show $ longestRecurringCycle' xs

-- main = putStrLn $ show $ map unitFraction' xs

main = putStrLn $ show $ longestRecurringCycle xs
-- main = putStrLn $ show $ map unitFraction xs
-- main = putStrLn $ show $ map recurringCycle xs
-- main = putStrLn $ show $ map (\(x, y) -> (x, length y, y)) $ map recurringCycle xs
    where xs = [2..1000]

longestRecurringCycle' :: [Integer] -> (Integer, Frac)
longestRecurringCycle' xs
    = maximumBy
        (\(_, (Frac _ recs1)) (_, (Frac _ recs2)) -> length recs1 `compare` length recs2)
        $ zip xs $ map unitFraction'' xs

longestRecurringCycle :: [Integer] -> (Integer,Int,[(Integer,Integer)])
longestRecurringCycle xs = maximumBy (\(_,x,_) (_,y,_) -> x `compare` y) $ map (\(x, y) -> (x, length y, y)) $ map recurringCycle xs

recurringCycle :: Integer -> (Integer, [(Integer,Integer)])
recurringCycle n
    | head lst `elem` tail lst = (n, head lst : takeWhile (head lst /=) (tail lst))
    | otherwise                = (n, [])
    where lst = unitFraction n

type Quot = Integer
type Remain = Integer
data DivPart = DivPart Quot Remain deriving (Show, Eq)

getQ :: DivPart -> Quot
getQ (DivPart q _) = q

-- data Fraction = Fraction Integer [DivPart] deriving (Eq)
-- instance Show Fraction where
--     show (Fraction n divParts) = "1/" ++ show n ++ ": " ++ showDivParts divParts

data Frac = Frac
    -- Integer   -- 1/n
    [Integer] -- non recurring
    [Integer] -- recurring decimal
    deriving (Eq)
instance Show Frac where
    show (Frac nonRecs recs)
        -- =  "1/" ++ show n ++ "="
        =  "0." ++ showDecimalList nonRecs
        ++ if length recs > 0
            then "(" ++ showDecimalList recs ++ ")"
            else ""
        where showDecimalList = concat . map show

lengthRecurring :: Frac -> Integer
lengthRecurring (Frac _ recs) = fromIntegral $ length recs

-- showDecimalList :: [Integer] -> String
-- showDecimalList = concat . map show

-- showDivParts :: [DivPart] -> String
-- showDivParts lst
--     | isRecurring lst = showRecurring lst
--     | otherwise       = showNonRecurring lst
--
-- isRecurring :: [DivPart] -> Bool
-- isRecurring []     = False
-- isRecurring (d:ds) = d `elem` ds

-- showNonRecurring :: [DivPart] -> String
-- showNonRecurring []                 = ""
-- showNonRecurring ((DivPart q _):[]) = show q ++ "."
-- showNonRecurring ((DivPart q _):ds) = showNonRecurring ds ++ show q
-- 
-- showRecurring :: [DivPart] -> String
-- showRecurring []                 = ""
-- showRecurring divParts@(d:ds) = case findIndex (==d) ds of
--     Nothing -> showNonRecurring divParts
--     Just i  -> showNonRecurring (drop (i+1) ds) ++ "(" ++ showQuots (take (i+1) ds) ++ ")"
-- 
-- showQuots :: [DivPart] -> String
-- showQuots []                 = ""
-- showQuots ((DivPart q _):ds) = showQuots ds ++ show q

unitFraction'' :: Integer -> Frac
unitFraction'' n = Frac nonRecs recs
    where
        divParts = helper' n 10 [DivPart 0 1]
        (nonRecs, recs) = helper5 divParts
helper5 :: [DivPart] -> ([Quot], [Quot])
helper5 []     = ([], [])
helper5 divParts@(d:ds) = case findIndex (==d) ds of
    Nothing -> (reverse $ map getQ (init divParts),
                [])
    Just i  -> (reverse $ map getQ $ drop (i+1) (init ds),
                reverse $ map getQ $ take (i+1) ds)

-- unitFraction' :: Integer -> Fraction
-- unitFraction' n = Fraction n $ helper' n 10 [DivPart 0 1]
helper' :: Integer -> Integer -> [DivPart] -> [DivPart]
helper' 0 _ _        = []
helper' _ 0 divParts = divParts
helper' n r divParts@(d:ds)
    | d `elem` ds    = divParts
    | otherwise      = helper' n (10 * newR) (DivPart newQ newR : divParts)
    where
        newQ = r `div` n
        newR = r `mod` n

unitFraction :: Integer -> [(Integer,Integer)]
unitFraction n = helper n 10 [(0, 1)]
helper :: Integer -> Integer -> [(Integer, Integer)] -> [(Integer, Integer)]
helper 0 _ _         = []
helper _ 0 quotients = quotients
helper n m quotients@(x:xs)
    | x `elem` xs = quotients
    -- | m < n       = helper n (10*m)         ((0, m):quotients)
    | otherwise   = helper n (10*(m`mod`n)) (((m`div`n),(m`mod`n)):quotients)

