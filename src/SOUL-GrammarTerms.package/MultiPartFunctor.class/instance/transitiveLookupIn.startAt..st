reification
transitiveLookupIn: anEnv startAt: anIndex
	
	^self class
		keywords:
			(keywords
				collect:
					[:keyword | keyword transitiveLookupIn: anEnv startAt: anIndex])