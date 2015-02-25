.. Last modified: 02/24/2015

*********************
Discussion Session 5
*********************

Computer Architecture
===========================

In computer engineering, computer architecture is a set of disciplines that
describes the functionality, the organization and the implementation of computer
systems; that is, it defines the capabilities of a computer and its programming
model in an abstract way, and how the internal organization of the system is
designed and implemented to meet the specified capabilities. [wikiarch]_

The following emulator describes the architecture in an abstract way.

.. literalinclude:: machine.py
 :language: python
 :linenos:

Instruction Set
---------------------------

* goto *label*
* branch *label* [addr]
* jump [addr]
* set [addr] **val**
* copy [addr_from] [addr_to]
* add


Memory Model
---------------------------

The range of memory address spans from negative infinity to positive infinity.
(We have infinite amount of memory, which is not possible in real case.)

Memory addresses with special functionalites: 0, 1, 2, 3, 4, 5, 6:

* 0, 1, 2 are used by *add* instruction.
* 3, 4 are used by *copy* instruction.
* 5 is used for output.
* 6 contains the current value of the program counter (instruction pointer).

Manual division of memory area:

* Stack: <= -1
* 7 is used to store the address of the top of the stack.
* Heap: > 8


Program Examples
=============================

1. Please write the machine code, the execution of which would increase the value 
   in address 8 by 1.

   Ans:

2. Please write the machine code, the execution of which have the following property:

   Assume in the initial state, memory 8 stores a natural number n, after the execution
   memory 9 should store the summation of all the natural numbers less than or equal
   to n. For instance, if memory 8 stores 10 initially, then memory 9 should store 55
   after the execution.

   Ans:

3. Please write the machine code for the defintion of a recursive function, which can output
   100 several times according to the value stored in memory 8. Please also write the
   code for invoking such function.

Tail Call Optimization
=======================================

While loop and recursive tail call are equivalent.

.. admonition:: Discussion

  What's the benefit?

Bibliography
======================================

	.. [wikiarch] http://en.wikipedia.org/wiki/Computer_architecture

