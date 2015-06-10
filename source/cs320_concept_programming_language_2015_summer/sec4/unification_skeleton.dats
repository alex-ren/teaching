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
print_explst (es: list0 exp): void = let
  fun print_explst_tail (es: list0 exp): void =
    case+ es of
    | cons0 (e, es1) => let
      val () = print ", "
      val () = print_exp (e)
    in
      print_explst_tail (es1)
    end
    | nil0 () => ()
in
  case+ es of
  | cons0 (x, es) => let
    val () = print_exp (x)
    val () = print_explst_tail es
  in end
  | nil0 () => ()
end

overload print with print_exp

(* ************** *************** *)

abstype substitution = ptr
typedef subs = substitution

exception conflict of ()
exception notfound of ()

extern fun subs_create (): subs

// may raise exception
extern fun subs_add (xs: subs, name: string, v: exp): subs

// may raise exception
extern fun subs_merge (s1: subs, s2: subs): subs  

// may raise exception
extern fun subs_get (s: subs, n: string): exp

extern fun subs_substitute (e: exp, s: subs): exp

extern fun print_subs (s: subs): void

local
  assume substitution = list0 '(string, exp)
in
  implement subs_create () = nil0 ()

  implement subs_add (xs, name, v) = let
    fun cmp (res: '(string, exp), x: '(string, exp)):<cloref1> '(string, exp) =
      if (res.0 = x.0) then $raise conflict
      else res

    val _ = list0_foldleft<'(string, exp)><'(string, exp)> (xs, '(name, v), cmp)
  in
    cons0 {'(string, exp)} ('(name, v), xs)
  end

  // implement subs_merge (s1, s2) = todo

  // implement subs_get (s: subs, n: string) = todo

  // implement subs_substitute (e, s) = todo

  implement print_subs (s) = let
    fun print_subs_tail (s: subs): void =
      case+ s of
      | cons0 (p, s) => let
        val () = print! (", ", p.0, ": ", p.1)
      in end
      | nil0 () => ()
    val () = print "{"
    val () = case+ s of
      | cons0 (m, s1) => let
        val () = print! (m.0, ": ", m.1)
      in
        print_subs_tail (s1)
      end
      | nil0 () => ()
    val () = print "}"
  in end

end  // end of [local]

// may raise exception
extern fun unify (a: exp, b: exp): subs

// implement unify (a, b) = todo

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

  val () = println! ("e2 is ", e2)
  val () = println! ("e4 is ", e4)
  val s = unify (e2, e4)
  val () = print "s = "
  val () = print_subs (s)
  val () = println! ()

  val e2' = subs_substitute (e2, s)
  val e4' = subs_substitute (e4, s)
  val () = println! ("s(e2) = ", e2')
  val () = println! ("s(e4) = ", e4')

  val () = println! ()
  val () = println! ()

  val () = println! ("e5 is ", e5)
  val () = println! ("e3 is ", e3)
  val s = unify (e5, e3)
  val () = print "s = "
  val () = print_subs (s)
  val () = println! ()

  val e5' = subs_substitute (e5, s)
  val e3' = subs_substitute (e3, s)
  val () = println! ("s(e5) = ", e5')
  val () = println! ("s(e3) = ", e3')
in
end




























