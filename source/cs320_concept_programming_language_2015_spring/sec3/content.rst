.. Last modified: 02/10/2015

*********************
Discussion Session 3
*********************

Ambiguity X Left Recursion X Associativity
-------------------------------------------------

Grammar with ambiguity:

.. productionlist:: grammar1a
  term: `term` + `term`
  term: `term` - `term`
  term: `NUM`

After doing left-recursion elimination mechanically:

.. productionlist:: grammar1b
  term: `NUM` `term2`
  term2: + `term` `term2`
  term2: - `term` `term2`
  term2:                     // Empty

Left-recursion elimination won't be able to remove ambiguity. 
The grammar still has ambiguity, but we can use 
recursive descent parsing technique now. Ambiguity is 
ressolved by the parsing process. (Semantics of the language
is now influenced by the parsing process.)

Grammar without ambiguity but with left recursion (left associativity):

.. productionlist:: grammar2a
  term: `term` + `NUM`
  term: `term` - `NUM`
  term: `NUM`

After doing left-recursion elimination mechanically:

.. productionlist:: grammar2b
  term: `NUM` `term2`   
  term2: + `NUM` `term2`
  term2: - `NUM` `term2`
  term2:                      // Empty

A smarter way to express such grammar (right associativity):

.. productionlist:: grammar2c
  term: `NUM` + `term`   
  term: `NUM` - `term`   
  term: `NUM`

Operator Precedence and Associativity
----------------------------------------

.. productionlist:: grammar3
  start: `term2`               // lowest precedence
  term2: `term2` Opr2a `term1`  // left associative
  term2: `term2` Opr2b `term1`  // left associative
  term2: `term1`               // next precedence
  term1: `term` Opr1 `term1`   // right associative
  term1: `term`                // next precedence
  term: `factor` + `term`      // right associative
  term: `factor`               // next precedence
  factor: `factor` * `base`     // left associative
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

..
  Advanced Techniques
  ------------------------------------------------------
  In the early seventies, Vaughan Pratt published an elegant improvement
  to recursive-descent in his paper "Top-down Operator Precedence". 
  Pratt’s algorithm associates semantics with tokens instead of grammar rules, 
  and uses a simple “binding power” mechanism to handle precedence levels. 
  Traditional recursive-descent parsing is then used to handle odd or 
  irregular portions of the syntax.
  
  Some explanation and implementation in case you don't want to read the original
  paper. http://javascript.crockford.com/tdop/tdop.html

Limitation of our implementation of Recursive Descendent Parser
----------------------------------------------------------------------

.. productionlist:: grammar4_1
  program: print `expression` ; `program`
  program:                  // Empty
  expression: `formula`
  expression: `term`

.. productionlist:: grammar4_2
  formula: `prop`
  formula: `prop` and `formula`
  formula: `prop` or `formula`
  prop: true
  prop: false
  prop: `VAR`

.. productionlist:: grammar4_3
  term: `factor` + `factor`
  term: `factor` - `factor`
  term: `factor`
  factor: `NUM`
  factor: `VAR`

.. admonition:: Question

  Does this grammar have ambiguity?

Assume we do not care. Let parsing process dissolve the ambiguity for concrete 
syntax like ``print x``.

.. admonition:: Question

  Can our recursive descendent parser handle the concrete syntax ``print true and false``?

Ordering of rules matters.

.. admonition:: Question

  Can our recursive descendent parser handle the concrete syntax ``print x + 1``?


Any remedy?

.. productionlist:: grammar4a
  program: print `formula` ; `program`
  program: print `term` ; `program`
  program:                  // Empty

.. productionlist:: grammar4b
  program: print `expression` `program`
  program:                  // Empty
  expression: `formula`;
  expression: `term`;

.. admonition:: Question

  What is perfect backtracking?


.. productionlist:: grammar5
  a1: b1 b2 b3
  b1: c1
  b1: c2

Search all possible sequences of choices: record the state at each choice and
backtrack if necessary.














