iterators
foreachM2

"tested on 29/08/2001

foreach/2

foreach(+?List, +?Predicate) applies the ?Predicate one by one to each of the
	 elements of a list ?List. Both the ?Predicate and the ?List are supposed to be
	 instantiated upon calling foreach/2.

Usage note: This predicate is typically used to apply a predicate with a side
	 effect to each of the elements of a given list. See for example writeLst/1 or
	 writeLnLst/1."

foreach(?List,?Predicate) if 
	list(?List),forall(member(?Item,?List),?Predicate(?Item))