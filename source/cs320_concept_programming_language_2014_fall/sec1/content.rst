.. Last Modified: 09/01/2014

**********************
Discussion Session 1
**********************



Submissions
===============

In this course, we are using ``gsubmit`` to submit homework. 
The `note <http://cs-people.bu.edu/lapets/320/s.php?#A>`_ describes how to install 
the softwares necessary to use ``gsubmit``. You can find more details about ``gsubmit`` 
`here <http://www.cs.bu.edu/teaching/hw/gsubmit/>`_.  And please **strictly** follow 
the instructions on that page to submit your homework, **or otherwise your homework will not be graded at all**.

Some important thing to know *(extracted from the documentation)*:

* Before submission, make sure all the files are under a **single folder** named ``hwXX``, 
  or otherwise we can't see it in the right place. *e.g.* ``hw01``, ``hw02``, ...
* Submit that folder as a whole into the right course. *e.g.* ``gsubmit cs320 hw01``
	
.. warning:: The command is **case-sensitive**, 
  ``gsubmit CS320 hw01`` will submit your work to another planet.  
  Please use lower-case whenever possible. 

* If you forget how to use ``gsubmit``, try ``gsubmit --help`` for help.

Quick Usage Example
--------------------

Suppose I have three files to submit: ``hello.h``, ``hello.c``, and ``main.c``, which
are already on the csa2.bu.edu server.

.. code-block:: bash

	ssh username@csa2.bu.edu           #login to csa2.bu.edu using your BU CS login name
	mkdir hw01                         #create a folder using a correct name for this homework
	cp hello.h hello.c main.c hw01     #copy everything into this folder
	gsubmit cs320 hw01                 #submit
	gsubmit cs320 -ls                  #double check that everything is submitted


Python
===============
The `note <http://cs-people.bu.edu/lapets/320/s.php?#B>`_ contains a simple introduction
of Python programming language. We will use Python 3 for grading. Make sure you are
using the correct version when working on your homework.

Background
===============

#. Programming language is a set of programs.
#. We use grammars to describe programming languages.
#. Writing a program using a programming language means keying a sequence of characters/tokens
   compabile with the grammar of the programming language.
#. We use notations to describe grammers.


Formal Language
-----------------

#. It has an **alphabet**, which is a finite set of symbols, and is usually denoted as :math:`\Sigma`.
#. **String** is a finite sequence of symbols from the alphabet, including empty string :math:`\epsilon`.
#. A **formal language** is *a set of strings* defined over an alphabet, including the empty set :math:`\emptyset`.

#. We use notations to describe grammars.
#. We implement grammars as automata.
#. We use automata to recognize programming languages.

Formal Grammar
----------------

Formal grammar is a set of production rules which generate all the strings of a corresponding formal language.

Types of Grammars
--------------------

Different grammars have different abilities of describing languages. According to Chomsky [wikich]_, there are four types of grammars in descending order w.r.t. their abilities.

Type 0
	Unrestricted grammars. This type of grammars generate recursively enumerable languages.

Type 1
	Context-sensitive grammars. These grammars generate context-sensitive languages.

Type 2
	Context-free grammars. These grammars generate context-free languages.

Type 3
	Regular grammars. These grammars generate regular languages.

.. note:: Note that actually, people can add restrictions onto these four types of grammars, and use those subset grammars to generate subset languages. For example, there are some important subsets of context-free grammars, like *LL(k)* and *LR(k)* grammars. You don't need to learn it for now. Just get some sense of those terminologies and their relationship.

Regular Language and Regular Expression
============================================

Regular language is a formal language, regular expression (in formal language theory) is a way (notation) to describe regular grammar.

Regular Language
------------------

Recall that a language is essentially a set of strings.

* The empty set is a regular language.
* Every symbol of :math:`\Sigma \cup \{\epsilon\}` is a regular language.
* If :math:`L_1, L_2` are regular languages, then 

	* :math:`L_1 \cdot L_2 = \{xy \mid x \in L_1, y \in L_2\}` is a regular language. It is formed by concatenate strings in both languages. Sometimes it is written as :math:`L_1L_2`.
	* :math:`L_1 \cup L_2` is a regular language. It is simply the union of both languages.
	* :math:`L^*` is a regular language. This is called the Kleene-Star, or Kleene closure. It is formed by concatenating any strings in :math:`L` any times (including zero times). *e.g.* :math:`\{a,b\}^* = \{\epsilon, a, b, ab, aa, bb, abb, aab, aaa, baa, bba, bbb, ...\}`.

* And there is no other regular languages.

.. admonition:: Examples

	Assume :math:`\Sigma=\{a, b\}`. :math:`\{\epsilon\},\emptyset, \{a\}, \{a, a\}, \{abaab, babba\}` are regular languages. :math:`\{a^nb^n\mid n \in \mathbb{N}\}` is not.

Regular Expression
---------------------

A regular expression describes a regular language. It is actually a compact notation for regular grammars.
A regular expression itself is a character string of special form. 
The set of all valid regular expressions is itself a language. An informal
description (grammar) of such language is given in the `note <http://cs-people.bu.edu/lapets/320/s.php#2.2>`_.

.. admonition:: Question

  Can this language be described by a regular expression?

Let's play with regular expression a little bit. http://www.regexr.com/

* Match number between 0 and 255.

  .. admonition:: text
    
    .11.
    
    .0.
   
    .249.
    
    .253.

* Match phone number of US formats.

  .. admonition:: text
    
        1-234-567-8901
    
        1-234-567-8901
        
        1-234-567-8901
        
        1 (234) 567-8901
        
        1.234.567.8901
        
        1/234/567/8901
        
        12345678901


BNF: Backus Naur Form
============================

BNF stands for **Backus Naur Form** (*Backus Normal Form* is not suggested [bnf]_), which is a notation technique to describe **context-free grammars** [wikibnf]_ [wikicfg]_. 

As mentioned, those grammars correspond to different type of languages, and they use different notations to describe themselves. **BNF is one of the notations that can describe context-free grammars.**

BNF in Action
---------------

.. productionlist::
	number : `digit` | `digit` `number` 
	digit  : 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

This can be explained line by line in English as follows:

* A number consists of a digit, **or alternatively**, a digit **followed by** a number **recursively**. 
* And a digit consists of any single digit from 0 to 9.

This may not be a perfect definition for numbers, but you can get a sense.

BNF Syntax
------------

* Each group containing a ``::=`` is a rule, where the LHS will be further expanded into RHS. 
* Those names on the LHS of ``::=`` are rule names.

	In the above example, there are two rules, ``number`` and ``digit``.

* The vertical bar ``|`` can be read as "or alternatively" as used in the above explanation.
  It seperates different expansion alternatives of a single rule.
* Those names that only appear in the RHS are **terminals**. And those names appear on LHS, or on both sides, are **non-terminals**.

	``digit``, ``number`` are non-terminals, while ``0`` .. ``9`` are terminals.

Variations
------------

Different versions of BNF exists, and one of those core problems is to differ terminals from non-terminals.
Someone may be familiar with this::

<number> ::= <digit> | <digit> <number>
<digit>  ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' 

where terminals are in ``''``, and non-terminals are in ``<>``. Other syntaxs exist, but they are pretty much similar. 

Extensions
------------

BNF has some extentions, and they are generally for the sake of simplicity and succinctness. Please google EBNF and ABNF for ideas. 

Here I want to present some commonly used notions.

* ``+`` means repeating one or more times. *e.g.* ``number ::= digit+``
* ``*`` means repeating zero or more times. *e.g.* ``number ::= digit digit*``
* ``[]`` means repeating zero or one time, namely an optional part. *e.g.* ``function_call ::= function_name '(' [params] ')'``
* ``{}`` means repeating zero or more times, just as ``*``. *e.g.* ``id ::= letter {letter | digit}``
* ``()`` means a group. *e.g.* ``id ::= letter (letter | digit)*``

.. warning:: The same symbols may have different meanings in different context. Here we are using them in the scope of formal language theory. Later you will use them in Python and Haskell, where they have different meanings. 


BNF can replace regular expression
--------------------------------------

As mentioned, regular expression is a compact notation of regular grammars. And grammar is actually a set of production rules. So we can actually rewrite regular expressions using BNF notation.

Say we have a regular expression ``00[0-9]*`` (*this is a coder's way of regexp, a math people would write* :math:`00(0|1|2|3|4|5|6|7|8|9)^*` *instead*), it can be written as

.. productionlist::
	Start : 0 `A1`
	A1 : 0
	A1 : 0 `A2`
	A2 : 0 | 1 | ... | 9
	A2 : (0 | 1 | ... | 9) `A2`

Describe the language of regular expression using BNF
----------------------------------------------------------
.. productionlist::
	RE : char
	RE : `RE` `RE`
        RE : `RE` | `RE`
        RE : `RE`+
        RE : `RE`*
        RE : (`RE`)


Bibliography
==============

	.. [wikibnf] https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form
	.. [wikicfg] http://en.wikipedia.org/wiki/Context-free_grammar
	.. [wikich] http://en.wikipedia.org/wiki/Chomsky_hierarchy
	.. [bnf] Knuth, D. E. (1964). Backus normal form vs. backus naur form. Communications of the ACM, 7(12), 735-736.


