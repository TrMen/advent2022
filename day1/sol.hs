import Data.List

splitWhen :: (a -> Bool) -> [a] -> [[a]]
splitWhen f xs = helper xs []
  where
    helper [] agg = [agg]
    helper (x : xs) agg =
      if f x
        then agg : helper xs []
        else helper xs (agg ++ [x])

(part1, part2) = (head <$> sorted_calories, sum . take 3 <$> sorted_calories)
  where
    elfCalories = sum . fmap read
    sorted_calories = reverse . sort . fmap elfCalories . splitWhen null . lines <$> readFile "day1/input.txt"
