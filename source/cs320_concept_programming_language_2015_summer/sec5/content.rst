
.. Last Modified: 06/16/2015

**********************
Lab Session 5
**********************



Quick Sort
================================================

Algorithm
------------------

Quicksort is an efficient sorting algorithm, serving as a systematic method for 
placing the elements of an array in order.

In efficient implementations it is not a stable sort, meaning that the relative order of 
equal sort items is not preserved. Quicksort can operate in-place on an array, 
requiring small additional amounts of memory to perform the sorting.

Mathematical analysis of quicksort shows that, on average, the algorithm takes :math:`O(n log n)`
comparisons to sort :math:`n` items. In the worst case, it makes :math:`O(n^2)` comparisons, 
though this behavior is rare.


Bullet Points
------------------------

* Form up a metric which gets decreased each time invoking a function recursively.
* Assignment formal meaning to function parameters.
* Form up invariant that is valid in the beginning and end of a recursive function.

Code
-------------

:download:`Makefile <./Makefile>`

The file :download:`quicksort.dats <./quicksort.dats>` is an implementation 
for array of integers.

.. literalinclude:: quicksort.dats

The file :download:`quicksort_generic.dats <./quicksort_generic.dats>` is a generic
implementation based on the template system of ATS. This implementation is derived on
the previous implementation with tiny modification (e.g. using *gcompare_val_val*
instead of *<* for comparison.

.. literalinclude:: quicksort_generic.dats

Bibliography
==============

.. [wikiqsort] https://en.wikipedia.org/?title=Quicksort


