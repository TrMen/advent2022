import Data.Char
import Data.List

extendPair c (a, b) = (a, c, b)

rotateLeft = reverse . transpose

rotateRight = transpose . reverse

gridWithCoordinates :: [String] -> [[(Int, Int, Int)]]
gridWithCoordinates lines = withXY
  where
    grid = (fmap . fmap) (subtract (ord '0') . ord) lines
    withX = fmap (zip [0 ..]) grid
    withXY = rotateRight $ fmap (zipWith extendPair [0 ..]) (rotateLeft withX)

value (_, _, c) = c

part1 :: [[(Int, Int, Int)]] -> Int
part1 grid = length . filter (== True) $ concatMap (fmap isVisible) grid
  where
    isVisible v@(colNum, rowNum, val) = any allSmaller [above, below, left, right]
      where
        allSmaller xs = all (< val) (value <$> xs)
        (above, below) = tail <$> splitAt rowNum (transpose grid !! colNum)
        (left, right) = tail <$> splitAt colNum (grid !! rowNum)

part2 :: [[(Int, Int, Int)]] -> Int
part2 grid = maximum $ concatMap (fmap scenicScore) grid
  where
    scenicScore (colNum, rowNum, val) = product (distanceToBiggerTree . fmap value <$> [reverse above, below, reverse left, right])
      where
        distanceToBiggerTree [] = 0
        distanceToBiggerTree (x : xs)
          | x >= val = 1
          | otherwise = 1 + distanceToBiggerTree xs

        (above, below) = tail <$> splitAt rowNum (transpose grid !! colNum)
        (left, right) = tail <$> splitAt colNum (grid !! rowNum)

(p1, p2) = (part1 <$> grid, part2 <$> grid)
  where
    grid = gridWithCoordinates . lines <$> readFile "day8/input.txt"
