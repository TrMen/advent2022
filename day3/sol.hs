import Data.Char
import Data.List

windows n = unfoldr (\xs -> if length xs >= n then Just $ splitAt 3 xs else Nothing)

priority c
  | c `elem` ['a' .. 'z'] = 1 + ord c - ord 'a'
  | c `elem` ['A' .. 'Z'] = 27 + ord c - ord 'A'

part2 = sum . fmap groupBadge . windows 3
  where
    groupBadge windowOfThree =
      (sum . fmap priority . nub)
        (foldr1 intersect windowOfThree)

part1 = sum . concatMap intersectHalves
  where
    intersectHalves line = (fmap priority . nub . uncurry intersect . splitAt (length line `div` 2)) line

(p1, p2) = (part1 <$> input, part2 <$> input)
  where
    input = lines <$> readFile "day3/input.txt"
