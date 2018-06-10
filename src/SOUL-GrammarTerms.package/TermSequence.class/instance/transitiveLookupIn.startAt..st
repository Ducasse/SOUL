reification
transitiveLookupIn: anEnv startAt: anIndex
	
	| newSubTerms |
	newSubTerms := OrderedCollection new.
	self
		do:
			[:aTerm | newSubTerms add: (aTerm transitiveLookupIn: anEnv startAt: anIndex)].
	^self class
		terms: newSubTerms
		containsCut: self containsCut