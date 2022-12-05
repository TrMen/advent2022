import Data.List
import Data.Maybe

windowsDroppingOne n = unfoldr (\xs -> if length xs >= n then Just $ drop 1 <$> splitAt 3 xs else Nothing)

stackDepth = 8 -- Simply determined by looking at the input file

data Instruction = Instruction
  { count :: Int,
    from :: Int,
    to :: Int
  }
  deriving (Show)

instructions :: [String] -> [Instruction]
instructions lines = parseInstruction <$> drop (stackDepth + 2) lines
  where
    parseInstruction line = Instruction (nums !! 1) (nums !! 3) (nums !! 5)
      where
        nums = read <$> words line

type Stacks = [[Char]]

stacks :: [String] -> Stacks
stacks lines = fmap fromJust . filter isJust <$> transpose (lettersOf <$> take stackDepth lines)
  where
    lettersOf line = parseElem <$> windowsDroppingOne 3 line
    parseElem elem = if head elem == '[' then (Just . head . tail) elem else Nothing

updateListAt :: [a] -> Int -> a -> [a]
updateListAt list n new = front ++ (new : tail rest)
  where
    (front, rest) = splitAt n list

part doReverse lines = head <$> stacksAfterInstructions
  where
    stacksAfterInstructions = foldl applyInstruction (stacks lines) (instructions lines)

    applyInstruction stacks instr = updateListAt (updateListAt stacks movingFrom updatedFromStack) movingTo updatedToStack
      where
        movingFrom = from instr - 1
        movingTo = to instr - 1

        movedElements = (if doReverse then reverse else id) (take (count instr) (stacks !! movingFrom))

        updatedFromStack = drop (count instr) (stacks !! movingFrom)
        updatedToStack = movedElements ++ (stacks !! movingTo)

(p1, p2) = (part True <$> input, part False <$> input)
  where
    input = lines <$> readFile "day5/input.txt"
