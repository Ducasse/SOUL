access
usesPredicate: aPredicate multiplicity: aNumber
	
	self condition
		do:
			[:term | (term usesPredicate: aPredicate multiplicity: aNumber) ifTrue: [^true]].
	^false