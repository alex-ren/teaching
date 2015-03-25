.. Last Modified: 03/24/2015

***********************************
Discussion Session 8: Unification
***********************************

Statement of Problem
==========================

Unification, in computer science and logic, is an algorithmic process of solving 
equations between *symbolic* expressions. [1]_

.. productionlist:: termgrammar
  term: variable
  term: id (`termlst`)
  termlst: `term` `termlst`
  termlst: 

Substitution is a mapping from *id* to *term*.

The essential task of unification is to find a substitution :math:`\sigma` that *unifies*
two given terms (i.e., makes them equal).  Let's write :math:`\sigma (t)` for the result of
applying the substitution :math:`\sigma` to the term :math:`t`.  Thus, given 
:math:`t_1` and :math:`t_2`, we want to find :math:`\sigma` such that 
:math:`\sigma(t_1) = \sigma(t_2)`. Such a substitution :math:`\sigma` is called a 
unifier for :math:`t_1` and :math:`t_2`.  For example, given the two terms::

  f(x, g(y))      f(g(z), w) 

where ``x``, ``y``, ``z``, and ``w`` are variables, the substitution::

  sigma = {x: g(z), w: g(y)} 

would be a unifier, since::

  sigma( f(x, g(y)) ) = sigma( f(g(z), w) ) = f(g(z), g(y))

Unifiers do not necessary exist. However, when a unifier exists, there is a *most
general unifier* (mgu) that is unique up to renaming. A unifier :math:`\sigma` 
for :math:`t_1` and :math:`t_2` is an mgu for :math:`t_1` and :math:`t_2` if

* :math:`\sigma` is a unifier for :math:`t_1` and :math:`t_2`; and
* any other unifier :math:`\sigma'` for :math:`t_1` and :math:`t_2` is a 
  refinement of :math:`\sigma`; that is, :math:`\sigma'` can be obtained 
  from :math:`\sigma` by doing further substitutions.

Application of Unification
==============================

* Pattern Matching (A simplified version of Unification)

  Algorithm and example (`notes <http://cs-people.bu.edu/lapets/320/
  s.php#95e800c8e74e4991a2ddb48668b544e0>`_)

* Type Inference

  Let's set up some typing rules for Python similar to those of Java or C.
  Then we can use unification to infer the types of the following Python
  programs::

    def foo(x):
        y = foo(3)
        return y

    def foo(x):
        y = foo(3)
        z = foo(y)
        return z

    def foo(x):
        y = foo(3)
        z = foo(4)
        r = foo(y, z)
        return r

* Logic Programming (Prolog)

A More General Unification Algorithm
========================================

Some examples that simplified algorithm cannot handle::

  x     f(x)
  f(x, g(x))     f(h(y), y)

Instead of unifying a pair of terms, we work on a list of pairs of terms::

  # We use a list of pairs to represent unifier. The unifier has a property
  # no variable on a lhs occurs in any term earlier in the list
  # [(x3: x4), (x1: f(x3, x4)), (x2: f(g(x1, x3), x3))]
  # Another way to view this.
  # Let's rename these variables by ordering them.
  # x3 -> y1
  # x4 -> y0
  # x1 -> y2
  # x2 -> y3
  # [(y1: y0), (y2: f(y1, y0)), (y3: f(g(y2, y1), y1))]

  def unify_one(t1, t2): # return a list of pairs for unifier
      if t1 is variable x and t2 is variable y:
          if x == y:
              return []
          else:
              return [(x, t2)]
      elif t1 is f(ts1) and t2 is g(ts2): # ts1 and ts2 are lists of terms.
          if f == g and len(ts1) == len(ts2):
              return unify(ts1, ts2)
          else:
              return None # Not unifiable: id conflict
      elif t1 is variable x and t2 is f(ts):
          if x occurrs in t2:
              return None # Not unifiable: circularity
          else:
              return [(x, t2)]
      else: # t1 is f(ts) and t2 is variable x
          if x occurrs in t1:
              return None # Not unifiable: circularity
          else:
              return [(x, t1)]

  def unify(ts1, ts2): # return a list of pairs for unifier
      if len(ts1) == 0:
          return []
      else:
          ts1_header = ts1[0]
          ts1_tail = ts1[1:]
          ts2_header = ts2[0]
          ts1_tail = ts2[1:]

          s2 = unify(ts1_tail, ts2_tail)
          t1 = apply(s2, ts1_header)
          t2 = apply(s2, ts2_header)
          s1 = unify_one(t1, t2)
          return s1 + s2

  def apply(s, t):
      // substitute one by one backward
      n = len(s) - 1
      while n >= 0:
          p = s[n]
          t = subs(p, t)
          n = n - 1
      return t

Example::

  f(x1, g(x2, x1), x2)    f(a, x3, f(x1, b))

Bibliography
=====================

.. [1] http://en.wikipedia.org/wiki/Unification_%28computer_science%29


