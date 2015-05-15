.. Last Modified: 11/18/2014

***********************************************
Discussion Session 11: Search
***********************************************

Concept
==========================

* State

* Search Tree / Graph

* Strategy

* Solution / Best Solution


Code Example
==================

We will do the 8-Queen problem today.

.. literalinclude:: eightqueens.hs
 :language: haskell
 :linenos:


Solution:
:download:`eightqueens.hs <eightqueens.hs>`
:download:`Makefile <Makefile>`


Misc
=======================

Some syntax sugar first.

The followings are equivalent:

.. code-block:: haskell

	putStrLn (show (1 + 1))
	putStrLn $ show $ 1 + 1
	putStrLn . show $ 1 + 1

The ``$`` sign is used to avoid parenthesis. Whatever on the right of it takes precedence. ``.`` sign is used to chain functions. The output of RHS will be the input of LHS.

And here is a very good place to lookup useful functions in the Prelude module of Haskell. http://hackage.haskell.org/package/base-4.6.0.1/docs/Prelude.html


