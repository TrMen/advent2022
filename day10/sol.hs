data Instruction = Noop | AddX Int deriving (Show)

data Carry = NoCarry | ActionReady Instruction deriving (Show)

parseInstruction line = case words line of
  ["noop"] -> Noop
  ["addx", num] -> AddX $ read num

part1 instructions = sum $ fmap (($ cpuStates) . signalStrengthAt) [20, 60, 100, 140, 180, 220]
  where
    cpuStates :: [(Int, (Int, Carry))]
    cpuStates = drop 1 $ zip [0 ..] $ scanl executeInstruction (1, NoCarry) (instructions ++ repeat Noop >>= addNoop)

    executeInstruction (x, NoCarry) Noop = (x, NoCarry)
    executeInstruction (x, NoCarry) (AddX i) = (x, ActionReady (AddX i))
    executeInstruction (x, ActionReady (AddX i)) instruction = (x + i, NoCarry)

    addNoop Noop = [Noop]
    addNoop (AddX i) = [Noop, AddX i]

    signalStrengthAt cycleCounter = (!! (cycleCounter - 1)) . fmap signalStrength

    signalStrength (cycleNumber, (x, _)) = cycleNumber * x

(p1, p2) = (part1 <$> input, undefined)
  where
    input = fmap parseInstruction . lines <$> readFile "day10/input.txt"
