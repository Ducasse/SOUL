soul auto saved
listAsCollectionM2

"listAsCollection(+-?soullist,+-?collection) converts a SOUL list to a Smalltalk collection and vice-versa. 
	WARNING: the list as well as the collection cannot contain free variables!!!!"

listAsCollection(<>,[OrderedCollection new]) if 
	!.
listAsCollection(?soullist,?collection) if 
	atom(?collection),findall(?el,member(?el,?collection),?soullist).
listAsCollection(?soullist,?collection) if 
	var(?collection),getEnv(?env,?),envLookup(?soullist,?listPointer),equals(?collection,[?listPointer term
	collectIn: ?env
	startAt: ?listPointer envIndex])