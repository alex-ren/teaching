.. Last modified: 09/23/2014

*********************
Discussion Session 4
*********************

Assignment 2
--------------

Grammar with ambiguity:

.. productionlist:: grammar1a
  formula: `formula` Xor `formula`
  formula: `base`
  base: T
  base: F

After left-recursion elimination:

.. productionlist:: grammar1b
  formula: `base` `formula2`    // Atom
  formula2: Xor `formula` `formula2`  // Xor
  formula2:                     // Empty
  base: T
  base: F

The grammar still has ambiguity, but we can use recursive descent parsing technique now.

.. admonition:: Discussion

  What is the abstract syntax for ``T Xor F Xor T``? 

Grammar without ambiguity:

.. productionlist:: grammar2a
  formula: `formula` Xor `base`
  formula: `base`
  base: T
  base: F

After left-recursion elimination:

.. productionlist:: grammar2b
  formula: `base` `formula2`    // Atom
  formula2: Xor `base` `formula2` // Xor
  formula2:                     // Empty
  base: T
  base: F

.. admonition:: Discussion

  What is the abstract syntax for ``T Xor F Xor T``? 

.. note::
  Recursive descendent parsing cannot handling left associative. Left-recursion 
  elimination leads to right associativity. We have to convert the generated 
  abstract syntax into left associativity.


Going still further

.. productionlist:: grammar3a
  formula: `base` Xor `formula`
  formula: `base`
  base: T
  base: F

.. admonition:: Discussion

  What is the abstract syntax for ``T Xor F Xor T``? 

Example of `unittest`
------------------------

:download:`test.py <test.py>`

.. literalinclude:: test.py
  :language: python
  :linenos:

Unit Testing (only for Python 3):

.. code-block:: bash

  python3 -m unittest test  # all the tests in test.py
  python3 -m unittest test.NumberTestCase  # all the tests in NumberTestCase
  python3 -m unittest test.NumberTestCase.test_negtive # one test

Operator Precedence and Associativity
----------------------------------------

.. productionlist:: grammar
  start: `term2`               // lowest precedence
  term2: `term2` Opr2a `term1`  // left associative
  term2: `term2` Opr2b `term1`  // left associative
  term2: `term1`               // next precedence
  term1: `term` Opr1 `term1`   // right associative
  term1: `term`                // next precedence
  term: `factor` + `term`      // right associative
  term: `factor`               // next precedence
  factor: `factor * `base`     // left associative
  factor: `base`               // next precedence
  base: - `base`
  base: log (`term2`)
  base: (`term2`)
  base: Variable
  base: Number

#. Operator Precedence: The lower in the grammar, the higher the precedence.
#. Operator Associativity:

  * Tie breaker for precedence
  * Left recursion in the grammar means

      * left associativity of the operator
      * left branch in the tree

  * Right recursion in the grammar means

      * Right associativity of the operator
      * Right branch in the tree

