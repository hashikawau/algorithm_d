
import Control.Monad
import Data.Char
import Data.List

main :: IO ()
main = do
    contents <- readFile "p054_poker.txt"
    putStrLn $ show $ length $ filter (\(_, _, b) -> b) $ map didPlayer1Win $ lines contents
    -- let lines = ["5H 5C 6S 7S KD 2C 3S 8S 8D TD",
    --              "5D 8C 9S JS AC 2C 5C 7D 8S QH",
    --              "2D 9C AS AH AC 3D 6D 7D TD QD",
    --              "4D 6S 9H QH QC 3D 6D 7H QD QS",
    --              "2H 2D 4C 4D 4S 3C 3D 3S 9S 9D",
    --              "KD KC AD KH KS 3D 9D 9C 3C 9H",
    --              "KD TD JD QD AD 9C KC QC JC TC"]
    -- -- putStrLn $ show $ map didPlayer1Win lines
    -- forM lines $ \line -> do
    --     putStrLn $ show $ didPlayer1Win line
    -- return ()
    -- -- putStrLn $ show $ aaa [Card 4 Diamond, Card 6 Spade, Card 9 Heart, Card 12 Heart, Card 12 Club]


data Kind = Diamond | Club | Heart | Spade deriving (Eq, Ord, Show)
data Card = Card Integer Kind deriving (Eq, Ord, Show)
data Rank
    = HighCard      Card
    | OnePair       Card Card
    | TwoPairs      Card
    | ThreeCards    Card
    | Straight      Card
    | Flush         Card
    | FullHouse     Card
    | FourCards     Card
    | StraightFlush Card
    | RoyalFlush    Kind
    deriving (Eq, Ord, Show)

makeKind :: Char -> Kind
makeKind 'D' = Diamond
makeKind 'C' = Club
makeKind 'H' = Heart
makeKind 'S' = Spade
makeKind k   = error $ show k

makeCard :: String -> Card
makeCard (v:k:[])
    | v == 'T'  = Card 10 (makeKind k)
    | v == 'J'  = Card 11 (makeKind k)
    | v == 'Q'  = Card 12 (makeKind k)
    | v == 'K'  = Card 13 (makeKind k)
    | v == 'A'  = Card 14 (makeKind k)
    | otherwise = Card (fromIntegral $ digitToInt v) (makeKind k)
makeCard invalid = error $ show invalid

getValue :: Card -> Integer
getValue (Card v _) = v
getKind :: Card -> Kind
getKind (Card _ k) = k

-- didPlayer1Win :: String -> Bool
-- didPlayer1Win :: String -> ([String],[String])
-- didPlayer1Win :: String -> ([Card],[Card])
-- didPlayer1Win line = (cards1, cards2)
--     where
--         lst = words line
--         cards1 = sort $ map makeCard (take 5 lst)
--         cards2 = sort $ map makeCard (drop 5 lst)

didPlayer1Win :: String -> (Rank,Rank,Bool)
didPlayer1Win line = (player1, player2, player1 > player2)
    where
        lst = words line
        player1 = makeRank $ sort $ map makeCard (take 5 lst)
        player2 = makeRank $ sort $ map makeCard (drop 5 lst)

makeRank :: [Card] -> Rank
makeRank ((Card 10 Diamond):(Card 11 Diamond):(Card 12 Diamond):(Card 13 Diamond):(Card 14 Diamond):[]) = RoyalFlush Diamond
makeRank ((Card 10 Club)   :(Card 11 Club)   :(Card 12 Club)   :(Card 13 Club)   :(Card 14 Club)   :[]) = RoyalFlush Club
makeRank ((Card 10 Heart)  :(Card 11 Heart)  :(Card 12 Heart)  :(Card 13 Heart)  :(Card 14 Heart)  :[]) = RoyalFlush Heart
makeRank ((Card 10 Spade)  :(Card 11 Spade)  :(Card 12 Spade)  :(Card 13 Spade)  :(Card 14 Spade)  :[]) = RoyalFlush Spade
makeRank cards
    | isSameSuit cards && isConsecutive cards = StraightFlush (maximum cards)
    | isFourCards cards   = makeFourCards cards
    | isFullHouse cards   = makeFullHouse cards
    | isSameSuit cards    = Flush (highest cards)
    | isConsecutive cards = Straight (highest cards)
    | isThreeCards cards  = makeThreeCards cards
    | isTwoPairs cards    = makeTwoPairs cards
    | isOnePair cards     = makeOnePair cards
    | otherwise           = makeHighCard cards

highest :: [Card] -> Card
highest cards = maximum cards

isSameSuit :: [Card] -> Bool
isSameSuit (c:cs) = all ((getKind c)==) $ map getKind cs
isConsecutive :: [Card] -> Bool
isConsecutive cs = all (1==) $ zipWith (-) (tail vs) vs
    where vs = map getValue cs

isFourCards :: [Card] -> Bool
isFourCards cs = (4==)
    $ (length . head)
        $ sortBy (\x y -> (length y) `compare` (length x))
            $ groupBy (\x y -> (getValue x) == (getValue y)) cs
makeFourCards :: [Card] -> Rank
makeFourCards cs = FourCards
    $ (head . head)
        $ sortBy (\x y -> (length y) `compare` (length x))
            $ groupBy (\x y -> (getValue x) == (getValue y)) cs

isFullHouse :: [Card] -> Bool
isFullHouse cs = ((3==) . length) firstGroup && ((2==) . length) secondGroup
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        firstGroup = head lst
        secondGroup = (head . tail) lst
makeFullHouse :: [Card] -> Rank
makeFullHouse cs = FullHouse (head firstGroup)
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        firstGroup = head lst

isThreeCards :: [Card] -> Bool
isThreeCards cs = ((3==) . length) firstGroup
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        firstGroup = head lst
makeThreeCards :: [Card] -> Rank
makeThreeCards cs = ThreeCards (head firstGroup)
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        firstGroup = head lst

isTwoPairs :: [Card] -> Bool
isTwoPairs cs = ((2==) . length) firstGroup && ((2==) . length) secondGroup
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        firstGroup = head lst
        secondGroup = (head . tail) lst
makeTwoPairs :: [Card] -> Rank
makeTwoPairs cs = TwoPairs (head thirdGroup)
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        thirdGroup = (head . tail . tail) lst

isOnePair :: [Card] -> Bool
isOnePair cs = ((2==) . length) firstGroup
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        firstGroup = head lst
makeOnePair :: [Card] -> Rank
makeOnePair cs = OnePair (head firstGroup) (highest remains)
    where
        lst = sortBy (\x y -> (length y) `compare` (length x)) $ groupBy (\x y -> (getValue x) == (getValue y)) cs
        firstGroup = head lst
        remains = filter (\c -> not $ c`elem`firstGroup) cs

makeHighCard :: [Card] -> Rank
makeHighCard cards = HighCard (highest cards)


