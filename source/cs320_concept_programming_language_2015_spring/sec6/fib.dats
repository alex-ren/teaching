

dataprop fib (int, int) =
| fibzero (0, 0) of ()
| fibone (1, 1) of ()
| {n:nat} {r1,r2:int} 
  fibcons (n+2, r1 + r2) of (fib (n+1, r1), fib (n, r2))

fun Fib0 {n:nat} {a:nat} {r1,r0:int} .<n>.(
  pf1: fib (a+1, r1), pf0: fib (a, r0)
  | x: int n, y1: int r1, y0: int r0):<fun>
  [r: int] (fib (a+n, r) | int r) = 
if x = 0 then (pf0 | y0)
else let
  prval pf2 = fibcons (pf1, pf0) // fib (a+2, r1 + r0)
in
  Fib0 (pf2, pf1 | x - 1, y1 + y0, y1)
end

fun Fib {n:nat} .<>.(x: int n):<fun> [r:int] (fib (n, r) | int r) = Fib0 (fibone, fibzero | x, 1, 0)

