.. Last modified: 10/07/2014

*********************
Discussion Session 6
*********************

Lazy Evaluation
--------------------

Procedure definition and invocation
--------------------------------------

* ``procedure(name, body)``
* ``call(name)``

Tail Call Optimization
-------------------------

Example 1::

  procedure foo1 {
    print 1;
    call foo2;
    print 11;
  }
  procedure foo2 {
    print 2;
    call foo3;
  }
  procedure foo3 {
    print 3;
  }
  call foo1;

Example 2::

  procedure foo1 {
    print 1;
    call foo1;
  }
  call foo1;

While loop and recursive tail call is equivalent.

.. admonition:: Discussion

  What's the benefit?


