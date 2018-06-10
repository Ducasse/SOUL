visiting terms
constantVisit: aConstant
	
	| number |
	number := database addressForPredicate: aConstant predicate.
	aConstant lexicalAddress: number