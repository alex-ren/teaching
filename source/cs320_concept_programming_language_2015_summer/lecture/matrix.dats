
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#include "share/HATS/atspre_staload_libats_ML.hats"


extern fun add (m1: matrix0 int, m2: matrix0 int): matrix0 int

implement add (m1, m2) = let
  val row = matrix0_get_nrow (m1)
  val col = matrix0_get_ncol (m1)
  val m = matrix0_make_elt (row, col, 0)

  fun loop1 (x: size_t): void =
    if x >= row then ()
    else let
      val () = loop2 (x, i2sz(0))
    in
      loop1 (succ x)
    end
  and
  loop2 (x: size_t, y: size_t): void =
    if y >= col then ()
    else let
      val () = m[x, y] := m1[x, y] + m2[x, y]
    in
      loop2 (x, y + i2sz (1))
    end

  val () = loop1 (i2sz (0))
in
  m
end

extern fun sub (m1: matrix0 int, m2: matrix0 int): matrix0 int

implement sub (m1, m2) = let
  val row = matrix0_get_nrow (m1)
  val col = matrix0_get_ncol (m1)
  val m = matrix0_make_elt (row, col, 0)

  fun loop (x: size_t, y: size_t): void =
    if x >= row then () 
    else if y >= col then loop (succ (x), i2sz(0))
    else let
      val () = m[x, y] := m1[x, y] - m2[x, y]
    in
      loop (x, y + i2sz (1))
    end

  val () = loop (i2sz (0), i2sz (0))
in
  m
end

extern fun matrix_merge (m1: matrix0 int, 
                         m2: matrix0 int, 
                         f: (int, int) -> int): matrix0 int

extern fun {a:t@ype} matrix_merge (m1: matrix0 a, 
                         m2: matrix0 a, 
                         f: (a, a) -> a): matrix0 a

extern fun matrix_rank (m: matrix0 int): int

// implement matrix_rank (m) = todo

implement main0 () = ()



