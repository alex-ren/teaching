

module Quiz where

data IList = Nil
           | Cons Int IList
           deriving (Eq, Show)

ilength :: IList -> Int
ilength xs = case xs of
             Nil -> 0
             Cons x xs -> 1 + ilength xs

itake :: IList -> Int -> IList
itake xs 0 = Nil
itake (Cons x xs) n = Cons x (itake xs (n - 1))


iremove :: IList -> Int -> IList
iremove xs 0 = xs
iremove (Cons x xs) n = iremove xs (n - 1)

data Option a = None
            | Some a

iremove_opt :: IList -> Int -> Option IList
iremove_opt xs 0 = Some xs
iremove_opt (Cons x xs) n = iremove_opt xs (n - 1)
iremove_opt xs n = None

-- Please implement the function to append two IList's.
-- iappend :: IList -> IList -> IList

-- Please implement the merge sort algorithm on IList
-- merge_sort :: IList -> IList

-- imap
-- ifold

data ITree = Leaf
            | Node Int ITree ITree
            deriving (Eq, Show)

from_ilist :: IList -> ITree
from_ilist Nil = Leaf
from_ilist xs = let
    n = ilength xs
  in
    from_ilist_num xs n


from_ilist_num :: IList -> Int -> ITree
from_ilist_num xs 0 = Leaf
from_ilist_num (Cons x xs) 1 = Node x Leaf Leaf
from_ilist_num xs n = let
    n1 = n `div` 2
    xs1 = itake xs n1
    Some (Cons x xs2) = iremove_opt xs n1
    t1 = from_ilist_num xs1 n1
    t2 = from_ilist_num xs2 (n - 1 - n1)
  in
    Node x t1 t2

nats :: IList
nats = genNat 0

genNat :: Int -> IList
genNat n = Cons n (genNat (n + 1))

nat3 = itake nats 3

ifilter :: IList -> (Int -> Bool) -> IList
ifilter Nil f = Nil
ifilter (Cons x xs) f = 
  if (f x) then Cons x (ifilter xs f)
  else ifilter xs f

isEven x = if x `mod` 2 == 0 then True else False

evens = ifilter nats isEven

even3 = itake evens 3

genPrime0 (Cons x xs) f = if (f x) then genPrime0 xs f
                          else let
                            newf y = if (f y) then True
                                     else if (y `mod` x == 0) then True
                                          else False
                            xs2 = genPrime0 xs newf
                          in
                            Cons x xs2

f0 n = if n < 2 then True else False

genPrime xs = genPrime0 xs f0

primes = genPrime nats

prime5 = itake primes 5
prime10 = itake primes 10





main :: IO ()
main = do putStrLn (show prime10)


