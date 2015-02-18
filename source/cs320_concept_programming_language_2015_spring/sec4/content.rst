.. Last modified: 02/17/2015

*********************
Discussion Session 4
*********************

Language of Regular Expressions
-------------------------------------------------

The language of all regular expressions can be described by the
following grammar (BNF)

.. productionlist:: grammar_reg
  reg: CHAR
  reg: .
  reg: `reg` `reg`
  reg: `reg` | `reg`
  reg: `reg` *
  reg: `reg` ?
  reg: ( `reg` )

The following grammar doesn't have ambiguity and sets different precedences for
operators ``|``, space (invisible operator), and ``*``.

.. productionlist:: grammar_reg
  reg: `seq` | `reg`    // Alt
  reg: `seq`
  seq: `block` seq      // Cat
  seq: `block`
  block: `atom` *       // Star
  block: `atom` ?       // Opt
  block: `atom`
  atom: CHAR            // Char
  atom: .               // Any
  atom: ( `reg` )       // Paren

.. admonition:: Question

  Can the language of regular expressions be described by a regular expression?

Example of Abstract Syntax Tree
----------------------------------

.. code-block:: python

  {"Char": ["a"]}    # a

  {"Alt": [          # ab|c
      {"Cat": [
          {"Char": ["a"]},
          {"Char": ["b"]}]},
      {"Char": ["c"]}]}

  {"Star": [{"Char": ["a"]}]}  # a*

  "Any"        # .

Match Regular Expression against String
--------------------------------------------

Simple implementation based on Search: :download:`regmatch.py <regmatch.py>`

.. literalinclude:: regmatch.py
 :language: python
 :linenos:














