import Data.List

data Instruction = Noop | AddX Int deriving (Show)

data Carry = NoCarry | ActionReady Instruction deriving (Show)

chunks n = takeWhile (not . null) . unfoldr (Just . splitAt n)

parseInstruction line = case words line of
  ["noop"] -> Noop
  ["addx", num] -> AddX $ read num

cpuStates instructions = drop 1 $ zip [0 ..] $ scanl executeInstruction (1, NoCarry) (instructions ++ repeat Noop >>= addNoop)
  where
    executeInstruction (x, NoCarry) Noop = (x, NoCarry)
    executeInstruction (x, NoCarry) (AddX i) = (x, ActionReady (AddX i))
    executeInstruction (x, ActionReady (AddX i)) instruction = (x + i, NoCarry)

    addNoop Noop = [Noop]
    addNoop (AddX i) = [Noop, AddX i]

part1 cpuStates = sum $ fmap (($ cpuStates) . signalStrengthAt) [20, 60, 100, 140, 180, 220]
  where
    signalStrengthAt cycleCounter = (!! (cycleCounter - 1)) . fmap signalStrength

    signalStrength (cycleNumber, (x, _)) = cycleNumber * x

part2 :: [Int] -> String
part2 xRegisterValues = intercalate "\n" $ chunks 40 $ take 240 $ drawnChar <$> zip [0 ..] xRegisterValues
  where
    drawnChar (cycle, xRegisterValue) = if abs (xRegisterValue - (cycle `mod` 40)) < 2 then '#' else '.'

(p1, p2) = (part1 <$> input, input >>= putStrLn . part2 . fmap (\(_, (x, _)) -> x))
  where
    input = cpuStates . fmap parseInstruction . lines <$> readFile "day10/input.txt"
