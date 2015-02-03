.. Last Modified: 02/02/2015

**********************
Discussion Session 2
**********************

Grammar
=============

* Nonterminal
* Terminal
* Production Rule (Left Hand Side, Right Hand Side)

.. admonition:: Example

  .. productionlist:: grammar1
      start : `exp`            // Start
      exp : `exp` + `term`   // Add
      exp : `exp` - `term`   // Minus
      exp : `term`           // Term
      term : ID              // Id
      term : NUM             // Num
      term : (`exp`)         // Group

Parsing
===============

Parsing is the procedure of transforming a list of tokens into a tree with tokens 
as leaves.

.. note::
  This process is also called derivation.

.. [Nonterminal_1 [^Nonterminal_2 t1 t2] [Nonterminal_3 t3] [Nonterminal_4 t4 [^Nonterminal_5 t5 t6]]]
.. http://mshang.ca/syntree/
.. figure:: syntax_tree01.png

  Token stream ``t1, t2, t3, t4, t5, t6, ......`` and Parsing Tree (Abstract Syntax)

  +-----------------------+-----------------------+
  | Color                 | Meaning               |
  +=======================+=======================+
  | Red                   | Terminal              |
  +-----------------------+-----------------------+
  | Blue                  | Nonterminal           |
  +-----------------------+-----------------------+

.. admonition:: Example

  The abstract syntax for ``1 - 2 - 3 - 4`` goes as follows:

  .. [exp(Minus) [exp(Minus) [exp(Minus)  [exp(Term) [term(Num) 1]] - [term(Num) 2]] - [term(Num) 3]] - [term(Num) 4]]
  .. figure:: parsing01.png

* A good grammar has no ambiguity. Only one tree can be constructed from the token stream.

* A good grammar should match human expectation.

  .. admonition:: Example

    Try the following grammar on ``1 - 2 - 3 - 4``.
  
    .. productionlist:: grammar2
        start : `exp`           // Start
        exp : `term` + `exp`    // Add
        exp : `term` - `exp`    // Minus
        exp : `term`            // Term
        term : ID               // Id
        term : NUM              // Num
        term : (`exp`)          // Group


Anatomy of **LL(k)**
=====================
**L**: Left-to-right

  Examine the input (token stream) left-to-right in one parse.

**L**: Leftmost-derivation

  Create / expand the left most sub-tree first.

.. note::
  **R**: Rightmost-derivation
  
  .. admonition:: demo

    Try parsing "1 + 2 - 3 * 4 + 5" with the following grammar.

    .. productionlist:: grammar3
        start : `exp`            // Start
        exp : `exp` + `term`   // Add
        exp : `exp` - `term`   // Minus
        exp : `term`           // Term
        term : `term` * NUM    // Mul
        term : `term` / NUM    // Div
        term : NUM             // Num
        term : (`exp`)         // Group

    .. [term(Num) 1]
    .. figure:: lr_step01.png

      Step 1

    .. [[exp(Term) [term(Num) 1]] +]
    .. figure:: lr_step02.png

      Step 2

    .. [[exp(Term) [term(Num) 1]] + [term(Num) 2]]
    .. figure:: lr_step03.png

      Step 3

    .. [[exp(Plus) [exp(Term) [term(Num) 1]] + [term(Num) 2]] -]
    .. figure:: lr_step04.png

      Step 4

    .. [[exp(Plus) [exp(Term) [term(Num) 1]] + [term(Num) 2]] - [term(Num) 3]]
    .. figure:: lr_step05.png

      Step 5

    .. [[exp(Plus) [exp(Term) [term(Num) 1]] + [term(Num) 2]] - [term(Num) 3] *]
    .. figure:: lr_step06.png

      Step 6

    .. [exp(Minus) [exp(Plus) [exp(Term) [term(Num) 1]] + [term(Num) 2]] - [term(Mul) [term(Num) 3] * 4]]
    .. figure:: lr_step07.png

      Step 7




**k**: Lookahead

  Inspect the first **k** tokens before making decision.

Eliminating Left Recursion
=============================

For productions like this:

.. math::
	
	P \rightarrow P\alpha_1 \mid P\alpha_2 \mid \cdots \mid P\alpha_m \mid \beta_1 \mid \cdots \mid \beta_n 

	\textrm{where } \alpha \neq \varepsilon, \beta \textrm{ don't start with } P

It will be turned into

.. math::
	
	P \rightarrow \beta_1 P' \mid \beta_2 P' \mid \cdots \mid \beta_n P'

	P' \rightarrow \alpha_1 P' \mid \alpha_2 P' \mid \cdots \mid \alpha_m P' \mid \varepsilon

And you can verify that the resulting language is the same. 

.. warning:: This is actually eliminating direct left recursions, and turning them into right recursions.
  There are methods to eliminate all recursions, direct or indirect, but it is more complicated, and needs some restrictions on the input grammar.

.. admonition:: Example

  .. productionlist:: grammar4
      start : `exp`            // Start
      exp : `exp` + `term`   // Add
      exp : `exp` - `term`   // Minus
      exp : `term`           // Term
      term : ID              // Id
      term : NUM             // Num
      term : (`exp`)         // Group
  
  is turned into

  .. productionlist:: grammar5
      start : `exp`
      exp : `term` `exp1`
      exp1 : + `term` `exp1`
      exp1 : - `term` `exp1`
      exp1 : epsilon

Coding Demo
==================


Left-factoring
====================

For productions like this:

.. math::
	
	A \rightarrow \delta\beta_1 \mid \delta\beta_2 \mid\cdots\mid\delta\beta_n \mid \gamma_1 \mid \cdots \mid \gamma_m

We turn them into

.. math::

	A \rightarrow \delta A' \mid \gamma_1 \mid \cdots \mid \gamma_m

	A' \rightarrow \beta_1 \mid \cdots \mid \beta_n

.. admonition:: Example

  .. productionlist:: grammar6
      start : `exp`          // Start
      exp : `exp` + `term`   // Add
      exp : `exp` - `term`   // Minus
      exp : `term`           // Term
      term : ID              // Id
      term : NUM             // Num
      term : (`exp`)         // Group
  
  is turned into

  .. productionlist:: grammar7
      start : `exp`
      exp : `exp` `term1`
      term1 : + `term`
      term1 : - `term`
      exp : `term`

  Do left recursion elimination.

  .. productionlist:: grammar8
      start : `exp`
      exp : `term` `exp1`
      exp1 : `term1` `exp1`
      exp1 : epsilon
      term1 : + `term`
      term1 : - `term`


















