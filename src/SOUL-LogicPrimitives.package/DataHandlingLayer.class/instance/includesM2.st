soul auto saved
includesM2

"tested on 27/08/2001

includes(+-?Element, +?Set) is the equivalent for sets of member/2 which works on lists.
	 (But since we represents sets as list too, includes/2 is directly implemented in 
	 terms of member/2.) The first argument ?Element can either be instantiated or not,
	 the second argument ?Set must be instantiated upon calling the predicate."

includes(?Element,?Set) if 
	member(?Element,?Set)