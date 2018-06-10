reification
transitiveLookupIn: anEnv startAt: anIndex
	
	^self class message: (message transitiveLookupIn: anEnv startAt: anIndex)