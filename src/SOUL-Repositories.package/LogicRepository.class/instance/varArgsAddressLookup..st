access
varArgsAddressLookup: anAddress
	"Do a lookup of a 'variable multiplicity' predicate using the address of the predicate. This method returns all clauses whose conclusion matches the predicate"

	
	^self allClausesAt: anAddress