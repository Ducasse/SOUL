resolving
lexicalAddressInEnv: anEnv startAt: anIndex ifAbsent: aBlock
	
	^self
		lexicalAddressInEnv: anEnv
		startAt: anIndex
		repository: self definitionRepository
		ifAbsent: aBlock