
.. Last modified: 10/21/2014


***********************************
Discussion Session 8: Type System
***********************************

Compiler must terminate!
============================

Whether interpreter terminates depends on the content of the
program.

.. admonition:: Discussion

  * Why does your compilation program terminate?

Type Theory
=======================

Background
------------------

Type theory was invented by Bertrand Russell as a solution to his own well-known 
paradox, which cast doubt on the foundations of mathematics upon its discovery.  
The problem posed by the paradox is essentially: given a set of all sets that 
do not contain themselves, does that set contain itself? Type theory resolves 
this issue by classifying the members of sets according to some type, and 
in such a system a set definition like this one is not permissible.

Nowadays, type systems are at the heart of the development of many modern 
programming languages. What is the benefit of a type system in a programming 
language? In the words of Benjamin Pierce [1]_: A type system is a 
syntactic method for automatically checking 
the absence of certain erroneous behaviors by classifying program phrases according 
to the kinds of values they compute.

.. admonition:: Discussion

  * What are erroneous behaviors? (Hint: For our machine language, what 
    program can cause our "machine" to crash?)

Robin Milner [2]_ provided the following slogan to describe type safety:

    Well-typed programs cannot "go wrong".

Type Inference / Judgement / Derivation
-------------------------------------------

All these names are referring to the same concept: How to assign types to each part
of the abstract syntax. The corresponding rules are normally closely related to the 
syntax of the language.

.. admonition:: Example

  Let's add one more production rule to the `language <http://cs-people.bu.edu/
  lapets/320/s.php?#f7d615702fe211e38cf6ce3f5508acd9>`_.

  .. productionlist:: programmar
    expression: if `expression` then `expression` else `expression`

  What type inference rule shall we add?

Type Checking Algorithm
--------------------------

Let's implement the type checking algorithm for our language with `indexed string
type <http://cs-people.bu.edu/lapets/320/s.php?#f7d61e6c2fe211e38cf6ce3f5508acd9>`_.

Sample Program::

    # function foo(string[6] x) {
    #   return x + x;
    # }
    # x = "abc"
    # y = "def"
    # z = foo(x + y)

    program = {"Function": [ {"Variable": ["foo"]} \
                           , {"String": [{"Number": [6]}]} \
                           , {"Variable": ["x"]} \
                           , {"Add": [ {"Variable": ["x"]} \
                                     , {"Variable": ["x"]}]} \
                           , {"Assign": [ {"Variable": ["x"]} \
                                        , {"String": ["abc"]} \
                                        , {"Assign": [ {"Variable": ["y"]} \
                                                     , {"String": ["def"]} \
                                                     , {"Assign": [ {"Variable": ["z"]} \
                                                                  , {"Apply": [ {"Variable": ["foo"]} \
                                                                              , {"Add": [ {"Variable": ["x"]} \
                                                                                        , {"Variable": ["y"]} ]} ]} \
                                                                  , "End" ]} ]} ]} ]}

Bibliography
=====================

.. [1] Pierce, Benjamin C. (2002). Types and Programming Languages. MIT Press. ISBN 978-0-262-16209-8.
.. [2] Milner, Robin (1978), A Theory of Type Polymorphism in Programming, Jcss 17: 348–375.








