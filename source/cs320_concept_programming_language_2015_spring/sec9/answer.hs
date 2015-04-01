
module Answer where

data IList =
   Nil
 | Cons Int IList
 deriving (Eq, Show)

ilength :: IList -> Int
ilength Nil = 0
ilength (Cons _ xs2) = 1 + ilength xs2

itake :: IList -> Int -> IList
itake xs 0 = Nil
itake (Cons x xs) n = Cons x (itake xs (n - 1))

iremove :: IList -> Int -> IList
iremove xs 0 = xs
iremove (Cons x xs) n = iremove xs (n - 1)

iappend :: IList -> IList -> IList
iappend Nil ys = ys
iappend (Cons x xs2) ys = Cons x (iappend xs2 ys)

irappend :: IList -> IList -> IList
irappend Nil ys = ys
irappend (Cons x xs2) ys = irappend xs2 (Cons x ys)

iappend2 :: IList -> IList -> IList
iappend2 xs ys = let
    xs' = irappend xs Nil
  in
    iappend2 xs' ys

merge_sort :: IList -> IList

merge_sort xs = let
    len = ilength xs
  in
    if len == 1 then xs
    else let
      len2 = len `div` 2
      xs1 = itake xs len2
      xs11 = merge_sort xs1
      xs2 = iremove xs (len - len2)
      xs21 = merge_sort xs2
    in
      merge xs11 xs21

merge :: IList -> IList -> IList

merge xs Nil = xs
merge Nil ys = ys
merge (Cons x xs2) (Cons y ys2) =
  if x <= y then Cons x (merge xs2 (Cons y ys2))
  else Cons y (merge (Cons x xs2) ys2)


main :: IO ()
main = do
  let xs = Cons 5 (Cons 3 (Cons 7 (Cons 8 (Cons 0 Nil))))
      ys = merge_sort xs
  putStrLn (show ys)

