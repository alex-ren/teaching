
#define
ATS_PACKNAME "LAB_QUICKSORT"

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#include "share/HATS/atspre_staload_libats_ML.hats"


// return value ret: new position for the pivot
// ret < enda
extern fun {a:t@ype} array0_partition (
  arr: array0 a, beg: size_t, enda: size_t): size_t

extern fun {a:t@ype} array0_quicksort (arr: array0 a): void

implement {a} array0_quicksort (arr) = let
  val sz = arr.size ()

  fun {a:t@ype} array0_quicksort_size (
    arr: array0 a, 
    beg: size_t,
    enda: size_t
    ): void =
    if enda <= beg then () else let
      val mid = array0_partition (arr, beg, enda)
    in
      let
        val () = array0_quicksort_size (arr, beg, mid)
        val () = array0_quicksort_size (arr, succ mid, enda)
      in end
    end
in
  array0_quicksort_size (arr, i2sz 0, sz)
end

implement {a} array0_partition (arr, beg, enda) = let
  val pivot = arr[enda - i2sz(1)]

  // return value ret: new position for the pivot
  // ret < enda
  // elements in [beg, div) are less than p
  // elements in [div, cur) are no less than p
  fun loop (arr: array0 a,
            beg: size_t,
            div: size_t,
            cur: size_t,
            enda: size_t,
            p: a
            ): size_t = 
  if cur = pred (enda) then let
    val v = arr[cur]
    val () = arr[cur] := arr[div]
    val () = arr[div] := v
  in
    div
  end
  else let
    val v = arr[cur]
    val sgn = gcompare_val_val (v, p)  // generic comparison function
  in
    if sgn < 0 then // swap elements arr[div] and arr[cur]
      if cur = div then loop (arr, beg, succ (div), succ (cur), enda, p)
      else let
        val () = arr[cur] := arr[div]
        val () = arr[div] := v
      in
        loop (arr, beg, succ (div), succ (cur), enda, p)
      end
    else  // div is unchanged
      loop (arr, beg, div, succ (cur), enda, p)
  end  // end of [fun loop]
  val ret = loop (arr, beg, beg, beg, enda, pivot)

in
  ret  // end of array0_partition
end

implement main0 () = let

  typedef T = int
  // create an array0 in an easy way
  val xs = $arrpsz{T} (2, 9, 8, 4, 5, 3, 1, 7, 6, 0) (* end of [val] *)
  val xs = array0 (xs)

  val () = fprint! (stdout_ref, "xs(*input*)  = ")
  val () = fprint_array0 (stdout_ref, xs)
  val () = fprintln! (stdout_ref)

  // override the default implementation for gcompare_val_val for int
  implement gcompare_val_val<int> (x1, x2) = ~(x1 - x2)

  val () = array0_quicksort<int> (xs)

  val () = fprint! (stdout_ref, "xs(*output*)  = ")
  val () = fprint_array0 (stdout_ref, xs)
  val () = fprintln! (stdout_ref)

in
end


