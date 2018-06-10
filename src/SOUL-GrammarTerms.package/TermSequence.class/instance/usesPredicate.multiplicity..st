access
usesPredicate: aPredicate multiplicity: aNumber
	
	collection
		do:
			[:aTerm | (aTerm usesPredicate: aPredicate multiplicity: aNumber) ifTrue: [^true]].
	^false