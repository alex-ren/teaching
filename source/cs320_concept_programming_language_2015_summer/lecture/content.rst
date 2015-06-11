
.. Last Modified: 06/11/2015

**********************
Lecture 06/11/2015
**********************



Reference and Matrix
================================================

Reference Type: ref (a)
-------------------------------------------------

You can find description of the usage of reference `here <http://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x1479.html>`_. Don't forget to add the following in the beginning of your *.dats* file.

.. code-block:: text

  #include "share/atspre_staload.hats"

Interface of *ref (a)*:

.. code-block:: text

  // quoted from $PATSHOME/prelude/SATS/reference.sats

  // Create a reference with initial value
  fun{a:vt0p} ref (x: a):<!wrt> ref a

  // Get the value stored in the reference
  fun{a:t0p} ref_get_elt (r: ref a):<!ref> a

  // Store a value into the reference
  fun{a:t0p} ref_set_elt (r: ref a, x: a):<!refwrt> void

Code Example:

.. code-block:: text

  val refa = ref<int>(0)  // Apply type argument to template
  val x = ref_get_elt (refa)  // O.K. to omit the type argument
  val () = ref_set_elt (refa, x + 1)  // O.K. to omit the type argument

  val y = !refa  // Simplified form of ref_get_elt
  val () = !refa := y + 1  // Simplified form of ref_set_elt

Matrix Type: mtrxszref (a, m, n) and matrix0 (a)
----------------------------------------------------

mtrxszref (a, m, n)
++++++++++++++++++++++++++++++++++++++++++++++++++++

You can find description of the usage of mtrxszref (a) `here <http://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x1589.html>`_.
Don't forget to add the following in the beginning of your ATS file.

.. code-block:: text

  #include "share/atspre_staload.hats"

Interface of *mtrxszref (a, m, n)*

.. code-block:: text

  // quoted from $PATSHOME/prelude/SATS/matrixref.sats

  fun{
  a:t0p
  } matrixref_make_elt
    {m,n:int}
    (m: size_t m, n: size_t n, x0: a):<!wrt> matrixref (a, m, n)
  // end of [matrixref_make_elt]

  fun{a:t0p}
  matrixref_get_at_int
    {m,n:int}
  (
    M: matrixref (a, m, n), i: natLt(m), n: int(n), j: natLt(n)
  ) :<!ref> (a) // end of [matrixref_get_at_int]
  
  fun{a:t0p}
  matrixref_get_at_size
    {m,n:int}
  (
    M: matrixref (a, m, n), i: sizeLt(m), n: size_t(n), j: sizeLt(n)
  ) :<!ref> (a) // end of [matrixref_get_at_size]

  symintr matrixref_get_at
  overload matrixref_get_at with matrixref_get_at_int of 0
  overload matrixref_get_at with matrixref_get_at_size of 0

  fun{a:t0p}
  matrixref_set_at_int
    {m,n:int}
  (
    M: matrixref (a, m, n), i: natLt (m), n: int n, j: natLt (n), x: a
  ) :<!refwrt> void // end of [matrixref_set_at_int]
  
  fun{a:t0p}
  matrixref_set_at_size
    {m,n:int}
  (
    M: matrixref (a, m, n), i: sizeLt (m), n: size_t n, j: sizeLt (n), x: a
  ) :<!refwrt> void // end of [matrixref_set_at_size]

  symintr matrixref_set_at
  overload matrixref_set_at with matrixref_set_at_int of 0
  overload matrixref_set_at with matrixref_set_at_size of 0

*matrixref (a, m, n)* uses the feature of dependent type in ATS, which makes it a 
little bit difficult to use for beginners. Therefore for this course we prefer 
use a simpler interface matrix0 *(a)*.


matrix0 (a)
++++++++++++++++++++++++++++++++++++++++++++++++++++

To use *matrix0 (a)*, please add the following in the beginning of your ATS file.

.. code-block:: text

  #include "share/HATS/atspre_staload_libats_ML.hats"

Interface of *matrix0 (a)*

.. code-block:: text

  // quoted from $PATSHOME/libats/ML/SATS/matrix0.sats

  fun{a:t0p}
  matrix0_make_elt
    (nrow: size_t, ncol: size_t, init: a):<!wrt> matrix0 (a)
  // end of [matrix0_make_elt]
  
  fun{a:t0p}
  matrix0_get_at_int
    (M: matrix0(a), i: int, j: int):<!exnref> a
  //
  fun{a:t0p}
  matrix0_get_at_size
    (M: matrix0 (a), i: size_t, j: size_t):<!exnref> a
  //
  symintr matrix0_get_at
  overload matrix0_get_at with matrix0_get_at_int
  overload matrix0_get_at with matrix0_get_at_size
  //
  //
  fun{a:t0p}
  matrix0_set_at_int
    (M: matrix0(a), i: int, j: int, x: a):<!exnrefwrt> void
  //
  fun{a:t0p}
  matrix0_set_at_size
    (M: matrix0 (a), i: size_t, j: size_t, x: a):<!exnrefwrt> void
  //
  symintr matrix0_set_at
  overload matrix0_set_at with matrix0_set_at_int
  overload matrix0_set_at with matrix0_set_at_size

  overload [] with matrix0_get_at_int of 0
  overload [] with matrix0_get_at_size of 0
  overload [] with matrix0_set_at_int of 0
  overload [] with matrix0_set_at_size of 0

  //

  fun{}
  matrix0_get_nrow{a:vt0p} (M: matrix0 a):<> size_t
  fun{}
  matrix0_get_ncol{a:vt0p} (M: matrix0 a):<> size_t

  //

  overload .nrow with matrix0_get_nrow
  overload .ncol with matrix0_get_ncol

Code Example:

.. code-block:: text

  val m = matrix0_make_elt<int> (i2sz(3), i2sz(2), 0)  // Apply type argument to the template.
  val nrow = matrix0_get_nrow (m)  // type of nrow is size_t
  val nrow2 = m.nrow () // Simplified form of matrix0_get_nrow

  val ncol = matrix0_get_ncol (m)  // type of nrol is size_t
  val ncol2 = m.ncol ()  // Simplified form of matrix0_get_ncol

  val x = matrix0_get_at (m, 1 (*row*), 1 (*column*))  // O.K. to omit type argument.
  val x2 = m[1, 1]  // Simplified form of matrix0_get_at

  val () = matrix0_set_at_int (m, 1, 1, x + 1)
  val () = m[1,1] := x + 1  // Simplified form of matrix0_set_at

Trouble of size_t and int

*size_t* and *int* are two different types in ATS. Literal numbers like *1*, *43* are
of type *int*. Also ATS compiler doesn't know how to do arithmetic operations on both
*size_t* and *int*. Therefore sometimes we may need to use cast function *i2sz* and
*sz2i* to convert between these two types:

.. code-block:: text

  val m = matrix0_make_elt<int> (i2sz(3), i2sz(2), 0)
  val sz = m.ncol ()
  val x = sz2i (sz) - 1

Practice
------------------------------------------

.. code-block:: text

  extern fun add (m1: matrix0 int, m2: matrix0 int): matrix0 int
  extern fun sub (m1: matrix0 int, m2: matrix0 int): matrix0 int
  extern fun mul (m1: matrix0 int, m2: matrix0 int): matrix0 int

  extern fun transpose (m: matrix0 int): void

  extern fun determinant (m: matrix0 int): int

Game of Tetris
===================================

You can find the discussion about the game 
`here <https://groups.google.com/forum/#!topic/ats-lang-users/AmeOXNUZ7Ik>`_.
To play with it, simply go to http://ats-lang.sourceforge.net/COMPILED/doc/PROJECT/SMALL/JSmygame/Tetris/tetris.html.

.. code-block:: text

  // Size of the board
  #define ROW = 30
  #define COL = 14

  // Size of the box holding the block.
  #define SIZE = 4

  // m1 is the current board and m2 is the block to be added on.
  // offset is the horizontal difference between 
  // the board and the box from left to right.
  // Modify m1 in place. Keep m2 unchanged. The updated m1 should
  // reflect the configuration after dropping the block onto the
  // board vertically.
  extern fun merge (m1: matrix0 bool, 
                    m2: matrix0 bool, 
                    offset: size_t
                    ): void

  // Find out a way to meature the situation of the current board.
  // Feel free to use any heuristics.
  extern fun metric (m: matrix0 bool): int































