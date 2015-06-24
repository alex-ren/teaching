
#include "share/atspre_staload.hats"

#include
"share/HATS/atspre_staload_libats_ML.hats"


(* ************** ************** *)

datatype
tree0 (a:t@ype) =
  | tree0_nil of ()
  | tree0_cons of (tree0 a, a, tree0 a)

fun {a:t@ype} brauntree_size (t: tree0 a): int =
case+ t of
| tree0_nil () => 0
| tree0_cons (t1, _, t2) => let
  val sz1 = brauntree_size (t1)
  val sz2 = brauntree_size (t2)
in
  sz1 + sz2 + 1
end


(* ************** ************** *)

// Decide whether the size of t is sz or sz - 1, 
// assuming the size of the input tree is either sz or sz - 1
// true: sz
// false: sz - 1
fun {a:t@ype} brauntree_size_is (t: tree0 a, sz: int): bool =
case+ t of
| tree0_nil () => if (sz = 0) then true else false
| tree0_cons (t1, _, t2) =>
  if sz mod 2 = 1 then brauntree_size_is (t2, sz / 2)
  else brauntree_size_is (t1, sz / 2)

(* ************** ************** *)

fun {a:t@ype} brauntree_size2 (t: tree0 a): int =
case+ t of
| tree0_nil () => 0
| tree0_cons (t1, _, t2) => let
  val sz1 = brauntree_size2 (t1)
in
  if brauntree_size_is (t2, sz1) then 2 * sz1 + 1
  else 2 * sz1
end

(* ************** ************** *)

exception notfound of ()

fun{a:t@ype}
brauntree_get_at(t: tree0(a), i: int): a = let
  val sz = brauntree_size2 (t)

  fun aux (t: tree0 a, i: int, sz: int): a = let
    val sz1 = sz / 2
  in
    case- t of
    | tree0_cons (t1, x, t2) => let
      val sz1 = sz / 2
    in
      if i < sz1 then aux (t1, i, sz1)
      else if i = sz1 then x
      else aux (t2, i - sz1 - 1, sz - sz1 - 1)
    end
  end
in
  if i < 0 || i >= sz then $raise notfound () else aux (t, i, sz)
end

(* ************** ************** *)


extern fun {a:t@ype} mylist0_to_brauntree (xs: list0 a): tree0 a
  
implement
{a}(*tmp*)
mylist0_to_brauntree(xs) = let
  fun aux (xs: list0 a, len: int): (tree0 a, list0 a) =
  if len = 0 then (tree0_nil (), xs)
  else let
    val len1 = len / 2
    val (t1, xs1) = aux (xs, len1)
    val- cons0 (x, xs2) = xs1
    val (t2, xs3) = aux (xs2, len - len1 - 1)
  in
    (tree0_cons (t1, x, t2), xs3)
  end

  val len = list0_length (xs)
  val (t, xs1) = aux (xs, len)
in
  t
end

(* ************** ************** *)

implement main0 () = let
  val xs = g0ofg1 ($list (1, 2, 3, 4, 5))
  val t = mylist0_to_brauntree<int> (xs)
  val r = brauntree_size_is (t, 5)
  val () = assertloc (r)

  val xs = g0ofg1 ($list (1, 2, 3, 4))
  val t = mylist0_to_brauntree<int> (xs)
  val r = brauntree_size_is (t, 5)
  val () = assertloc (~r)

  val xs = g0ofg1 ($list (1, 2, 3, 4))
  val t = mylist0_to_brauntree<int> (xs)
  val r = brauntree_size_is (t, 4)
  val () = assertloc (r)

  (* ******** ******** *)

  val xs = g0ofg1 ($list (1, 2, 3, 4, 5))
  val t = mylist0_to_brauntree<int> (xs)
  val r = brauntree_size2 (t)
  val () = assertloc (r = 5)

  (* ******** ******** *)

  val x0 = brauntree_get_at (t, 0)
  val x1 = brauntree_get_at (t, 1)
  val x2 = brauntree_get_at (t, 2)
  val x3 = brauntree_get_at (t, 3)
  val x4 = brauntree_get_at (t, 4)

  val () = assertloc (x0 = 1)
  val () = assertloc (x1 = 2)
  val () = assertloc (x2 = 3)
  val () = assertloc (x3 = 4)
  val () = assertloc (x4 = 5)

  val () = (try let
             val _ = brauntree_get_at (t, 6)
           in
             assertloc (false)
           end
           with ~notfound () => ()
           ): void
in
end



