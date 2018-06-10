reification
soulUp
	"upping a compoundterm means returning myself because all my  
	subterms are automatically already upped"

	"| newSubTerms | 
	newSubTerms _ terms 
	collect: [:subTerm | subTerm qsoulUp]. 
	^ self class functor: functor qsoulUp terms: newSubTerms"

	
	^self