instance creation
fromString: aString variables: aCollectionOfVars content: aContent block: aBlock parsetrees: aParsetree queries: aQueries type: aType
	
	| inst |
	inst := super fromString: aString variables: aCollectionOfVars content:
			aContent block: aBlock.
	inst parsetree: aParsetree queries: aQueries type: aType.
	^inst