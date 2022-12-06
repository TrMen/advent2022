import Data.List

rotateFixedList :: Int -> [a] -> a -> [a]
rotateFixedList n xs x =
  if length xs < n
    then xs ++ [x]
    else tail xs ++ [x]

packetMarker :: Int -> String -> Maybe Int
packetMarker uniqueCount str = helper str [] 1
  where
    helper "" lastChars i = Nothing
    helper str' lastChars i =
      if (nub newChars == newChars) && (length newChars == uniqueCount)
        then Just i
        else helper (tail str') newChars (i + 1)
      where
        newChars = rotateFixedList uniqueCount lastChars (head str')

(p1, p2) = ((fmap . fmap) (packetMarker 4) input, (fmap . fmap) (packetMarker 14) input)
  where
    input = lines <$> readFile "day6/input.txt"
