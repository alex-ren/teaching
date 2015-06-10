
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

// local
  // assume substitution = list0 '(string, exp)
// in
  implement subs_create () = nil0 ()

  implement subs_add (xs, name, v) = let
    fun cmp (res: '(string, exp), x: '(string, exp)):<cloref1> '(string, exp) =
      if (res.0 = x.0) then $raise conflict
      else res

    val _ = list0_foldleft<'(string, exp)><'(string, exp)> (xs, '(name, v), cmp)
  in
    cons0 {'(string, exp)} ('(name, v), xs)
  end

  implement subs_merge (s1, s2) = let
    fun add_one (res: subs, x: '(string, exp)):<cloref1> subs =
      subs_add (res, x.0, x.1)
  in
    list0_foldleft (s1, s2, add_one)
  end

  implement print_subs (s) =
  case+ s of
  | cons0 (m, s1) => let
    val () = print! ("(", m.0, ": ", m.1, ")", " => ")
  in
    print_subs (s1)
  end
  | nil0 () => print ("end")

// end  // end of [local]

// may raise exception
extern fun unify (a: exp, b: exp): subs

implement unify (a, b) = let
  fun aux (a: exp, b: exp, s: subs): subs =
  case+ (a, b) of
  | (INT (_), INT (_)) => s
  | (VAR (x), _) => subs_add (s, x, b)
  | (_, VAR (y)) => subs_add (s, y, a)
  | (CONS (ida, xsa), CONS (idb, xsb)) => 
      if ida <> idb then $raise conflict
      else let
        fun unify_lst (xs: explst, ys: explst, s: subs): subs =
          case+ (xs, ys) of
          | (nil0 (), nil0 ()) => s
          | (cons0 (x, xs1), cons0 (y, ys1)) => let
            val s1 = aux (x, y, s)
          in
            unify_lst (xs1, ys1, s1)
          end
          | (_, _) => $raise conflict
      in
        unify_lst (xsa, xsb, s)
      end
  | (_, _) => $raise conflict
in
  aux (a, b, subs_create ())
end


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




























