.. Last modified: 03/03/2015


************************************************
Discussion Session 6: Program Verification
************************************************

Intepretation
=======================

.. productionlist:: formulagrammar
  formula: true | false
  formula: not `formula`
  formula: `formula` and `formula`
  formula: `formula` or `formula`

Python code::

  def formula_true():
      return "True"

  def formula_false():
      return "False"

  def formula_not(formula):
      return {"Not": [formula]}

  def formula_and(formula1, formula2):
      return {"And": [formula1, formula2]}

  def formula_or(formula1, formula2):
      return {"Or": [formula1, formula2]}

  def evaluateFormula(formula):
      if is_true(formula):
          return True
      if is_false(formula):
          return False
      if is_not(formula):
          return not evaluateFormula(formula["Not"][0])
      if is_and(formula):
          formula1 = formula["And"][0]
          formula2 = formula["And"][1]
          return evaluateFormula(formula1) and evaluateFormula(formula2)
      if is_or(formula):
          formula1 = formula["Or"][0]
          formula2 = formula["Or"][1]
          return evaluateFormula(formula1) or evaluateFormula(formula2)
      return None

.. admonition:: Discussion
  
  * What's the type for formula?
  * How to prove that evaluateFormula is implemented correctly?
  * What is correct? (Hint: `Evaluation Rule 
    <http://cs-people.bu.edu/lapets/320/s.php?#cbfa02d3624d42b08704d6a4c4fb9e03>`_)


Bounded Exhaustive Testing
==============================
Set of all possible inputs is defined inductively. We can enumerate them exhaustively.
See `notes <http://cs-people.bu.edu/lapets/320/s.php?#5.8>`_. The introduction of metric 
guarantees that we do enumerate all the possibilities.

* If formula is of format "true" or "false", then its height is 1.
* If formula is of format "not formula0", then its height is 1 + height of "formula0".
* If formula is of format "formula1 and formula2", 
  then its height is 1 + max(height of "formula1", height of "formula2".
* If formula is of format "formula1 and formula2", 
  then its height is 1 + max(height of "formula1", height of "formula2".

Code::

  def metric(f):
      if is_true(f) or is_false(f):
          return 1
      if is_not(f):
          return 1 + metric(f["Not"][0])
      if is_and(f):
          f1 = f["And"][0]
          f2 = f["And"][1]
          return 1 + max(metric(f1), metric(f2))
      if is_or(f):
          f1 = f["Or"][0]
          f2 = f["Or"][1]
          return 1 + max(metric(f1), metric(f2))

  def formulas(n):
      if n <= 0:
          []
      elif n == 1:
          return [formula_true(), formula_false()]
      else:
          fs = formulas(n-1)
          fsN = []
          fsN += [formula_not(f) for f in fs]
          fsN += [formula_and(f1, f2) for f1 in fs for f2 in fs]
          fsN += [formula_or(f1, f2)  for f1 in fs for f2 in fs]
          return fs + fsN


Proof by Induction
========================

* Base Case: evaluateFormula is correct for formula whose height is 1.
* Inductive Step: The input formula has height n+1.
* Induction Hypothesis: evaluateFormula is correct for formula whose height is <= n.

Example of fibonacci function
===================================

Definition of fibonacci function
----------------------------------
fib(n) =
  0 if n = 0

  1 if n = 1

  fib(n-1) + f(n-2) if n > 1

Implementation of fibonacci function
-------------------------------------

::

  def Fib(n):
    def Fib0(n, x, y):
      if n = 0:
        return y
      if n > 0:
        return Fib0(n - 1, x + y, x)

    return Fib0(n, 1, 0)

Verification Task
-------------------

For any n >= 0, fib(n) == Fib(n).

Proof By Induction
--------------------

We prove the following instead.

For any n >= 0, for any a >= 0, Fib0(n, fib(a+1), fib(a)) == fib(a+n).

Base Case:
  | When n = 0, we have
  | for any a >= 0, Fib0(0, fib(a+1), fib(a)) = fib(a) <== (By def of Fib0)

Inductive Step:
  n = m > 0

  Inductive Hypothesis: For any m0 < m, for any a >= 0, Fib0(m0, fib(a+1), fib(a)) == fib(a+m0).
  
  For any a >= 0, we have the following

  Fib0(m, fib(a+1), fib(a))

  = Fib0(m-1, fib(a+1) + fib(a), fib(a+1)) <== (By def of Fib0)

  = Fib0(m-1, fib(a+2), fib(a+1)) <== (By def of fib)
  
  = fib(a+1 + m-1) <== (By Induction Hypothesis)

  = fib(a+m) <== (Done)
  
Programming with Theorem Proving
---------------------------------------

Advanced programming languages provide us with abilities to write proof along
with code so that the compiler can help check the correctness of our implementation.
One example of such language is `ATS <http://www.ats-lang.org>`_.

.. code-block:: txt

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
  
  fun Fib {n:nat} .<>.(x: int n):<fun> [r:int] (fib (n, r) | int r) = 
    Fib0 (fibone, fibzero | x, 1, 0)
              
You can try type checking the code at 
http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode=hello.












