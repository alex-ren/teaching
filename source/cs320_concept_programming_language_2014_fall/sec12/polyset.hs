
module PolySet where

class IsSet s where
  empty :: s a
  insert :: Ord a => s a -> a -> s a
  contains :: (Ord a, Eq a) => a -> s a -> Bool
  
  inserts :: Ord a => s a -> [a] -> s a
  inserts s (x:xs) = inserts (insert s x) xs
  inserts s []     = s

data SetList a =
    Empty
  | Set [a]
  deriving Show   

instance IsSet SetList where
  empty = Empty

  insert (Set l) x = Set (x:l)
  insert (Empty) x = Set [x]

  contains x (Empty) = False
  contains x (Set l) = x `elem` l

data SetTree a =
    Leaf
  | Node a (SetTree a) (SetTree a)
  deriving Show   

instance IsSet SetTree where
  empty = Leaf

  insert (Leaf       ) x = Node x Leaf Leaf
  insert (Node y s s') x =
    if x < y then 
      Node y (insert s x) s' 
    else
      Node y s (insert s' x)

  contains x (Leaf       ) = False
  contains x (Node y s s') =
    if y == x then
      True
    else if x < y then
      contains x s
    else
      contains x s'

get :: (IsSet s) => s a
get = empty

both :: (Ord a, IsSet s1, IsSet s2) => s1 a -> s2 a -> a -> Bool
both s1 s2 e = (contains e s1) && (contains e s2)


main :: IO ()
main = do 
       let s1 = empty :: SetList int
           s2 = insert s1 1
           s3 = insert s2 2
           b1 = contains 2 s3
           b2 = contains 3 s3
       putStrLn (show b1)
       putStrLn (show b2)

       let
           s21 = empty :: SetTree int
           s22 = insert s21 1
           s23 = insert s22 3
           b21 = contains 3 s23
           b22 = contains 4 s23

       putStrLn (show b21)
       putStrLn (show b22)

       let
          b1 = both s3 s23 1
          b2 = both s3 s23 2
       putStrLn (show b1)
       putStrLn (show b2)








