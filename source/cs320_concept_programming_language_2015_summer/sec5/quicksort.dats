


#define
ATS_PACKNAME "LAB_QUICKSORT"

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#include "share/HATS/atspre_staload_libats_ML.hats"


// return value ret: new position for the pivot
// ret < enda
// elements in [beg, ret) are less than arr[ret]
// elements in [ret, enda) are no less than arr[ret]
extern fun array0_partition (
  arr: array0 int, beg: size_t, enda: size_t): size_t

extern fun array0_quicksort (arr: array0 int): void

implement array0_quicksort (arr) = let
  val sz = arr.size ()

  fun array0_quicksort_size (
    arr: array0 int, 
    beg: size_t,
    enda: size_t
    ): void =
    if enda <= beg then () else let
      // val () = fprint! (stdout_ref, "arr = ")
      // val () = fprint_array0 (stdout_ref,arr)
      // val () = fprintln! (stdout_ref)
      val mid = array0_partition (arr, beg, enda)
      // val () = println! ("array0_quicksort_size, mid is ", mid)
    in
      let
        val () = array0_quicksort_size (arr, beg, mid)
        val () = array0_quicksort_size (arr, succ mid, enda)
      in end
    end
in
  array0_quicksort_size (arr, i2sz 0, sz)
end

implement array0_partition (arr, beg, enda) = let
  // val () = println! ("array0_partition start ",
  //                    " beg is ", beg,
  //                    " enda is ", enda)

  val pivot = arr[enda - i2sz(1)]

  // elements in [beg, div) are less than p
  // elements in [div, cur) are no less than p
  fun loop (arr: array0 int,
            beg: size_t,
            div: size_t,
            cur: size_t,
            enda: size_t,
            p: int
            ): size_t = 
  let
    // val () = println! ("loop: beg is ", beg,
    //                    " div is ", div,
    //                    " cur is ", cur,
    //                    " enda is ", enda,
    //                    " pivot is ", p)
  in
    // put pivot at the appropriate position
    if cur = pred (enda) then let
      val v = arr[cur]
      val () = arr[cur] := arr[div]
      val () = arr[div] := v
    in
      div
    end
    else let
      val v = arr[cur]
    in
      if v < p then // swap elements arr[div] and arr[cur]
        if cur = div then loop (arr, beg, succ (div), succ (cur), enda, p)
        else let
          val () = arr[cur] := arr[div]
          val () = arr[div] := v
        in
          loop (arr, beg, succ (div), succ (cur), enda, p)
        end
      else  // div is unchanged
        loop (arr, beg, div, succ (cur), enda, p)
    end
  end  // end of [fun loop]
  val ret = loop (arr, beg, beg, beg, enda, pivot)

  // val () = println! ("array0_partition end, div is ", ret)
in
  ret  // end of array0_partition
end

implement main0 () = let

  // create an array0 in an easy way
  val xs = $arrpsz{int} (2, 9, 8, 4, 5, 3, 1, 7, 6, 0) (* end of [val] *)
  val xs = array0 (xs)

  val () = fprint! (stdout_ref, "xs(*input*)  = ")
  val () = fprint_array0 (stdout_ref, xs)
  val () = fprintln! (stdout_ref)

  val () = array0_quicksort (xs)

  val () = fprint! (stdout_ref, "xs(*output*)  = ")
  val () = fprint_array0 (stdout_ref, xs)
  val () = fprintln! (stdout_ref)

in
end


