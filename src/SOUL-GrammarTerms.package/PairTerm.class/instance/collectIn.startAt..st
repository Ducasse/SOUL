enumeration
collectIn: anEnv startAt: anIndex
	
	| newCollection |
	newCollection := OrderedCollection new.
	newCollection
		add: (termsequence terms first soulDownIn: anEnv startAt: anIndex).
	newCollection
		addAll:
			((termsequence terms last soulDownIn: anEnv startAt: anIndex) collectIn:
					anEnv startAt: anIndex).
	^newCollection