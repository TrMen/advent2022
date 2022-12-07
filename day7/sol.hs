import Data.Map qualified as M

data Entry = Dir [String] | File Int deriving (Show, Eq)

type Path = [String]

type FileSystem = M.Map Path [Entry]

parseCommand :: (FileSystem, Path) -> [String] -> (FileSystem, Path)
-- Do nothing since following commands have enough context
parseCommand (fs, pwd) ["$", "ls"] = (fs, pwd)
-- Change directory
parseCommand (fs, pwd) ["$", "cd", ".."] = (fs, tail pwd)
parseCommand (fs, pwd) ["$", "cd", dir] = (M.insert (dir : pwd) [] fs, dir : pwd)
-- Add entries to current directory
parseCommand (fs, pwd) ["dir", name] = (M.adjust (Dir (name : pwd) :) pwd fs, pwd)
parseCommand (fs, pwd) [size, _] = (M.adjust (File (read size) :) pwd fs, pwd)

fsSize :: FileSystem -> [Entry] -> Int
fsSize fs = sum . fmap entrySize
  where
    entrySize (Dir d) = fsSize fs (fs M.! d)
    entrySize (File sz) = sz

reconstructFS input = fsSize fs <$> fs
  where
    (fs, _) = foldl parseCommand (M.empty, []) input

main = do
  input <- fmap words . lines <$> readFile "day7/input.txt"

  let fs = fst . foldl parseCommand (M.empty, []) $ input
  let sizes = fsSize fs <$> fs

  let p1 = sum . filter (<= 100000) . M.elems $ sizes

  let neededSize = sizes M.! ["/"] - 40000000
  let p2 = minimum . filter (>= neededSize) . M.elems $ sizes

  print p1
  print p2
