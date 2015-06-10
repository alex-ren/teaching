
#define
ATS_PACKNAME "LAB_UNIFICATION"

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#include "share/HATS/atspre_staload_libats_ML.hats"

datatype exp =
| VAR of (string)
| INT of (int)
| CONS of (string (*constructor id*), explst)
where
explst = list0 (exp)


extern fun equal (a: exp, b: exp): bool

implement equal (a, b) =
case+ (a, b) of
| (VAR (na), VAR (nb)) => na = nb
| (INT (ia), INT (ib)) => ia = ib
| (CONS (ida, expsa), CONS (idb, expsb)) =>
  (
  if (ida <> idb) then false else let
    fun cmp2 (xs: list0 exp, ys: list0 exp): bool =
      case+ (xs, ys) of
      | (nil0 (), nil0 ()) => true
      | (cons0 (x, xs1), cons0 (y, ys1)) =>
          if equal (a, b) = false then false
          else cmp2 (xs1, ys1)
      | (_, _) => false
  in
    cmp2 (expsa, expsb)
  end
  )
| (_, _) => false

fun print_exp (e: exp): void =
case+ e of
| VAR (x) => print x
| INT (x) => print x
| CONS (id, xs) => let
  val () = print (id)
  val () = print (" (")
  val () = print_explst (xs)
  val () = print (")")
in
end
and
print_explst (es: list0 exp): void =
case+ es of
| cons0 (x, es) => let
  val () = print_exp (x)
  val () = print (" -> ")
in
  print_explst (es)
end
| nil0 () => print ("end")

overload print with print_exp

(* ************** *************** *)

// abstype substitution
// typedef subs = substitution
typedef subs = list0 '(string, exp)
extern fun subs_create (): subs

exception conflict of ()

// may raise exception
extern fun subs_add (xs: subs, name: string, v: exp): subs

// may raise exception
extern fun subs_merge (s1: subs, s2: subs): subs  

extern fun print_subs (s: subs): void


// end  // end of [local]

// may raise exception
extern fun unify (a: exp, b: exp): subs


implement main0 () = let
  // cons1 (y, nil1 ())
  val e1 = CONS ("cons1", cons0 (VAR ("y"),
                          cons0 (CONS ("nil1", nil0 ()),
                          nil0))
           )
  // cons1 (x, cons1 (y, nil1 ()))
  val e2 = CONS ("cons1", cons0 (VAR ("x"), 
                          cons0 (e1,
                          nil0))
           )
  
  // cons1 (2, nil1 ())
  val e3 = CONS ("cons1", cons0 (INT (2),
                          cons0 (CONS ("nil1", nil0 ()),
                          nil0))
           )
  // cons1 (1, cons1 (2, nil1 ()))
  val e4 = CONS ("cons1", cons0 (INT (1), 
                          cons0 (e3,
                          nil0))
           )
  val e5 = VAR ("x")

  val s = unify (e2, e4)
  val () = print_subs (s)
  val () = println! ()

  val s = unify (e5, e3)
  val () = print_subs (s)
  val () = println! ()
in
end




























