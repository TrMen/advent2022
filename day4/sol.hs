split c s = drop 1 <$> break (== c) s

mapTuple f (l, r) = (f l, f r)

rangeContains ((sl, el), (sr, er)) = (sl <= sr && el >= er) || (sr <= sl && er >= el)

rangesOverlap ((sl, el), (sr, er)) = (sl <= sr && el >= sr) || (sr <= sl && er >= sl)

part f lines = (length . filter (== True) . fmap f) parse
  where
    parse :: [((Int, Int), (Int, Int))]
    parse = fmap (mapTuple (mapTuple read . split '-') . split ',') lines

(p1, p2) = (part rangeContains <$> input, part rangesOverlap <$> input)
  where
    input = lines <$> readFile "day4/input.txt"
