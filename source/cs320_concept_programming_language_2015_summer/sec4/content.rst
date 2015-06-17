
.. Last Modified: 06/09/2015

**********************
Lab Session 4
**********************



Unification Problem
================================================
Unification, in computer science and logic, is an algorithmic process of solving 
equations between symbolic expressions. In the following text, we shall give out its
formal definiton in maths and programming language ATS.

Expression and Substitution
----------------------------------
**Definition of language of expressions:**
  .. productionlist::
      exp: `VAR`    // variable (leaf)
      exp: `INT`    // integer (leaf)
      exp: `ID` (`explst`)  // constructor (branch)
      explst:
      explst: `exp` `explst`
      VAR: x, y, z, ...  // strings of characters
      INT: ..., -1, 0, 1, ...  // integers
      ID: x, y, z, ...  // strings of characters

**Encode the language of expressions in ATS**

.. code-block:: text

  datatype exp =
  | VAR of (string)
  | INT of (int)
  | CONS of (string (*constructor id*), explst)
  where
  explst = list0 (exp)

**Algorithm (equality =)**: The following algorithm can determine whether two expressions are equivalent.
  **equal(a, b)**: two expressions *a* and *b*
    **if** both *a* and *b* are leaf nodes and are equivalent
      **return true**
    **if** both *a* and *b* have the same ID **and** the same number of children
      | in order from left to right, check each pair of corresponding children of *a* and *b* for equality
      | **return true** if all the subexpressions are equivalent
      | **return false** otherwise

**ATS code**

.. code-block:: text

  extern fun equal (a: exp, b: exp): bool

  extern fun print_exp (e: exp): void
  
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
            if equal (x, y) = false then false
            else cmp2 (xs1, ys1)
        | (_, _) => false
    in
      cmp2 (expsa, expsb)
    end
    )
  | (_, _) => false

**Definition of substitution:**
  A mapping from variabes to expressions, e.g. {"v": 3, "xs": cons0 (1, nil0), ...}.

**ATS code**

.. code-block:: text

  abstype substitution = ptr
  typedef subs = substitution

  exception conflict of ()
  exception notfound of ()

  extern fun subs_create (): subs
  extern fun subs_add (s: subs, name: string, v: exp): subs  // may raise exception
  extern fun subs_merge (s1: subs, s2: subs): subs  // may raise exception
  extern fun subs_get (s: subs, n: string): exp // may raise exception

  extern fun print_subs (s: subs): void

  assume substitution = '(string, exp)  // one possible implementation

**Definition of substitute expresion *a* with substitution** :math:`\sigma`:
  Replace the variables in an expression with corresponding expression designated
  in the substitution.

**ATS code**

.. code-block:: text

  extern fun subs_substitute (e: exp, s: subs): exp

Unification
----------------------------------

**Definition of Unification (not very strict):**
  Given two expressions *a* and *b*, find :math:`\sigma` such that :math:`\sigma(a) =
  \sigma(b)`

**Algorithm (pattern matching unification)**: Whether unification can be computed efficiently, or at all, depends on what restrictions are placed on the expressions that may need to be unified). The following algorithm, which we will call pattern matching unification, is guaranteed to terminate quickly (i.e., polynomial time) as long as at least one side of the equation contains no variables. It is guaranteed to quickly find a solution if it exists, as long as all variables occur exactly once.
  **unify(a, b)**: two expressions *a* and *b*
    **if** both *a* **and** *b* are leaf nodes and are equivalent
      **return** the empty substitution :math:`\sigma0`
    **if** *a* is a variable node representing a variable *x*
      **return** the substitution {*x*: *b*}
    **if** *b* is a variable node representing a variable *x*
      **return** the substitution {*x*: *a*}
    **if** both *a* and *b* have the same ID **and** the same number of children
      | in order from left to right, unify each pair of corresponding children of *a* and *b*
      | as long as they do not overlap on any variables, combine the substitutions obtained above
      | **return** the combined substitution

**ATS code**

.. code-block:: text

  fun unify (a: exp, b: exp): subs  // may raise exception

**Skeleton Code**

.. literalinclude:: unification_skeleton.dats

:download:`unification_skeleton.dats <./unification_skeleton.dats>`

**Solution**

:download:`unification.dats <./unification.dats>`

:download:`Makefile <./Makefile>`

Bibliography
==============

	.. [wikiunification] http://en.wikipedia.org/wiki/Unification_%28computer_science%29


