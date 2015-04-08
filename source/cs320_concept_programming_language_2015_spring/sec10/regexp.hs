
module RegExp where

data Regexp = 
   REnil
 | REemp
 | REany
 | REchar Char
 | REalt Regexp Regexp
 | REcat Regexp Regexp
 | REstar Regexp

-- string_regexp_match :: String -> Regexp -> Bool
string_regexp_match str reg = let
  str_isempty :: String -> Bool
  str_isempty [] = True
  str_isempty _ = False
  in
  accept str reg str_isempty

-- accept :: String -> Regexp -> (String -> Bool) -> Bool
accept str reg k =
  case reg of
  REnil -> False
  REemp -> k str
  REany -> (case str of 
            _ : cs -> k cs
            [] -> False
           )
  REchar c -> (case str of
            c' : cs -> if c == c' then k cs else False
            [] -> False
            )
  REalt reg1 reg2 -> if accept str reg1 k then True
                     else accept str reg2 k
  REcat reg1 reg2 -> let
    k' xs = accept xs reg2 k
    in
    accept str reg1 k'
  REstar reg0 -> if k str then True
                else let
                  k' xs = if (length xs) == (length str) then False
                          else accept xs reg k
                  in
                  accept str reg0 k'


main = do 
  let
    reg_a = REchar 'a'
    reg_b = REchar 'b'
    reg_ab = REalt reg_a reg_b
    reg_abs = REcat reg_ab (REstar reg_ab)
    reg_as = REstar reg_a
    reg_ass = REstar reg_as
  putStrLn $ show $ string_regexp_match "abaaab" reg_abs
  putStrLn (show (string_regexp_match "ac" reg_abs))
  putStrLn (show (string_regexp_match "aa" reg_ass))
  


