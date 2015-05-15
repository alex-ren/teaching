
**************************
Section 12: Polymorphism
**************************

Polymorphism
==================

Polymorphism, means "ploy" and "morphi", which is "many shapes". It is also known as "type scheme". A value is polymorphic if there is more than one type it can have.

* Parameteric Polymorphism: parametric polymorphism refers to when the type of a value contains one or more (unconstrained) type variables, so that the value may adopt any type that results from substituting those variables with concrete types.

	.. code-block:: haskell

		length :: [a] -> Int
		fst :: (a, b) -> a
		snd :: (a, b) -> b

		length :: forall a. [a] -> Int
		fst :: forall a b. (a, b) -> a

	.. note:: In Haskell, type variables always begin in lowercase whereas concrete types like ``Int`` or ``String`` always start with an uppercase letter.

	.. note:: Also note, in languages like Haskell, functions are values of some function types.

* Ad-hoc Polymorphism: ad-hoc polymorphism refers to when a value is able to adopt any one of several types because it, or a value it uses, has been given a separate definition for each of those types. 

	.. code-block:: haskell

		-- type 'a' belongs to class 'Eq' if there is a function named 
		-- '(==)', of the appropriate types, defined on it
		class Eq a where
			(==) :: a -> a -> Bool

		instance Eq Integer where
			x == y = x `integerEq` y

		instance Eq Float where
			x == y = x `floatEq` y

		memberOf :: (Eq a) => a -> [a] -> Bool


	.. note:: the equality operator, ``==`` is a function. So are ``+``, ``*``, ``-``, ``/`` and pretty much all operators. If a function is comprised only of special characters, it's considered an infix function by default. If we want to examine its type, pass it to another function or call it as a prefix function, we have to surround it in parentheses.

	.. note:: The function ``member`` has the type ``a -> [a] -> Bool`` with the context ``(Eq a)``, which **constrains** the types which ``a`` can range over to those ``a`` which belong to the ``Eq`` class. (Note: Haskell ``=>`` can be called a **'class constraint'**.)


Practice
=============

1. Write a polymorphic list
2. Write a ``list_len`` function for it
3. Write a ``list_get`` function for it
4. Write a identity function for it

.. code-block:: haskell

	data List a = Nil
		| Cons a (List a)

	list_len :: (List a) -> Int
	list_len (Nil) = 0
	list_len (Cons _ xs) = 1 + list_len (xs)

	list_eq :: (Eq a) => List a -> List a -> Bool
	list_eq Nil Nil = True
	list_eq Nil _ = False
	list_eq _ Nil = False
	list_eq (Cons x xs) (Cons y ys) = (x == y) && (list_eq xs ys)

	instance (Eq a) => Eq (List a) where
		x == y = x `list_eq` y

	list_get :: List a -> Int -> a
	list_get (Cons x _) 0 = x
	list_get (Cons _ xs) index = list_get xs (index - 1)

Example
===============
polyset.hs

.. literalinclude:: polyset.hs
 :language: haskell
 :linenos:

polyset.py

.. literalinclude:: polyset.py
 :language: python
 :linenos:

Solution:
:download:`polyset.hs <polyset.hs>`
:download:`polyset.py <polyset.py>`
:download:`Makefile <Makefile>`










