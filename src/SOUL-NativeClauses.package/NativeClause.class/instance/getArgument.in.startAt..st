access
getArgument: aNumber in: anEnv startAt: anIndex
	
	| result |
	result := anEnv
		lookup: (header terms at: aNumber)
		startAt: anIndex.
	^result
		ifNil:
			[TermPointer
				term: (header terms at: aNumber)
				envIndex: anIndex]
		ifNotNil: [result]