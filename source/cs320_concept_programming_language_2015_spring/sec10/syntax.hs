
-- Elementary expression
a = 1
b = "abc"
c = (show a) ++ b

-- "let" expression
x = let
  x = 1  -- binding
  y = 2  -- binding
  sum :: Int -> Int -> Int -- function declaration
  sum a b = a + b  -- function definition
  in
  sum x y

-- "if" expression
y = if x > 0 then 'a'
else 
  if x == 0 then 'b'
  else 'c'

data IList =
  Cons Int IList
 | Nil

xs = Cons 1 (Cons 2 Nil)

-- "case" expression
z = case xs of 
  Cons _ _ -> 1  -- all clauses must be of the same indentation
  Nil -> 2

-- "case" expression
z' = case y of
  'a' -> "a"
  'b' -> "b"
  
fz 'a' = "a"
fz 'b' = "b"
z'' = fz y


-- type of main is IO (), "IO" is a type constructor
main :: IO ()
main = do 
  let
    a = 1 -- Indentation is important
    b = let
      c = 1
      in
      a + c
  putStrLn (show z)  -- The following two lines are of the same indentation.
  putStrLn (show z)


