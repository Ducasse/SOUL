resolving
predicateInEnv: anEnv startAt: anIndex
	"This method is called at runtime if the lexicalAddress for this clause was not filled in. This can either be because this clause was not present when the database was 	compiled, e.g. if a variable was used as functor"

	
	^self subclassResponsibility