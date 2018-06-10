access
normalAddressLookup: anAddress multiplicity: aNumber
	"Do a lookup of a normal predicate using the address of the predicate and the required multiplicity. This method returns both the clauses whose conclusion matches the 	predicate / multiplicity exactly, as well as the 'variable multiplicity' predicates in the repository"

	
	^(self clausesAt: anAddress multiplicity: aNumber)
		, (self clausesAt: anAddress multiplicity: -1)