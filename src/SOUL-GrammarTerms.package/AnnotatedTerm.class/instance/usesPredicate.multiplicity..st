access
usesPredicate: aPredicate multiplicity: aNumber
	
	^(term usesPredicate: aPredicate multiplicity: aNumber)
		or: [annotation usesPredicate: aPredicate multiplicity: aNumber]