soul auto saved
removeM3

"tested on 28/08/2001

remove(+-?List,+-?Element,+-?ListWithoutElement) removes the first occurence of
	 ?Element from a list ?List and yields a new list ?ListWithoutElement. If ?List is variable,
	 the ?Element will be inserted somewhere in ?ListWithoutElement. It is assumed that
	 at least one of the lists is non-variable when calling the predicate."

remove(?List,?Element,?ListWithoutElement) if 
	and(var(?List),var(?ListWithoutElement)),error(['remove/3 was called with two variable lists!']).
remove(?List,?Element,?ListWithoutElement) if 
	removeAux(?List,?Element,?ListWithoutElement)