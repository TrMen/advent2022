(part1, part2) = (sum . fmap p1 <$> inp, sum . fmap p2 <$> inp)
  where
    inp = fmap words . lines <$> readFile "day2/input.txt"
    p1 xs = case (head xs, xs !! 1) of
      ("A", "X") -> 4 -- Rock, Rock
      ("B", "Y") -> 5 -- Paper, Paper
      ("C", "Z") -> 6 -- Scissors, Scissors
      ("B", "X") -> 1 -- Paper, Rock
      ("A", "Y") -> 8 -- Rock, Paper
      ("A", "Z") -> 3 -- Rock, Scissors
      ("B", "Z") -> 9 -- Paper, Scissors
      ("C", "X") -> 7 -- Scissors, Rock
      ("C", "Y") -> 2 -- Scissors, Paper
    p2 xs = case (head xs, xs !! 1) of
      ("A", "X") -> 3 -- Rock, Lose -> Scissors
      ("B", "X") -> 1 -- Paper, Lose -> Rock
      ("C", "X") -> 2 -- Scissors, Lose -> Paper
      ("A", "Y") -> 4 -- Rock, Tie
      ("B", "Y") -> 5 -- Paper, Tie
      ("C", "Y") -> 6 -- Scissors, Tie
      ("A", "Z") -> 8 -- Rock, Win  -> Paper
      ("B", "Z") -> 9 -- Paper, Win -> Scissors
      ("C", "Z") -> 7 -- Scissors, Win -> Rock
