
module EightQueen where

data Cell = E | Q deriving (Show)
type Position = (Integer, Integer)
data Board = Board [Position]

data Graph = 
   Branch Board [Graph]
 | Finish Board

instance Show Board where
  show (Board xs) = let
    show_line_loop cur pos len accu =
      if cur >= len then accu
      else if cur == pos then show_line_loop (cur + 1) pos len (accu ++ "Q ")
      else show_line_loop (cur + 1) pos len (accu ++ ". ")

    show_loop ((_, pos) : tail) accu = let
        new_line = show_line_loop 0 pos 8 ""
      in
        show_loop tail (accu ++ new_line ++ "\n")
    
    show_loop [] accu = accu

    in
      show_loop xs ""
       
nextMoves :: Board -> [Board]
nextMoves (Board xs) = let
    row = toInteger (length xs)
    cols = [0 .. 7]
    candidates = [(row, y) | y <- cols]

    conflict :: Position -> Position -> Bool
    conflict (x1,y1) (x2,y2) = if y1 == y2 then True
                               else if abs(x1 - x2) == abs(y1 - y2) then True
                               else False

    conflict_list :: Position -> [Position] -> Bool
    conflict_list x (head : tail) = (conflict x head) || (conflict_list x tail)
    conflict_list x [] = False

    new_moves = [c | c <- candidates, (conflict_list c xs) == False]

    new_boards = [Board (xs ++ [pos]) | pos <- new_moves]
  in
    new_boards

graph :: Board -> Graph
graph (Board xs) = if (length xs) >= 8 then Finish (Board xs)
                   else let
                       new_boards = nextMoves (Board xs)
                     in
                       if length(new_boards) == 0 then Finish (Board xs)
                       else let
                           new_graphs = [graph b | b <- new_boards]
                         in
                           Branch (Board xs) new_graphs


is_sol :: Board -> Bool
is_sol (Board xs) = (length xs) == 8

find_sol :: Graph -> [Board]
find_sol (Branch b gs) = let
  bss = [find_sol g | g <- gs]
  bs = foldl (\x -> \y -> x ++ y) [] bss
  in
  if is_sol b then b : bs
  else bs

find_sol (Finish b) = 
  if is_sol b then [b]
  else []

search_space = graph (Board [])
sol = find_sol (search_space)

show_boards (b : bs) = (show b) ++ "\n\n\n" ++ (show_boards bs)
show_boards [] = "\n"

main :: IO ()
main = do putStrLn (show_boards sol)
          putStrLn $ "Total solutions found: " ++ show (length sol)



  




