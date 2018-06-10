reification
soulDownIn: anEnv startAt: anIndex
	
	^TermSequence
		terms:
			(collection
				collect:
					[:aSubTerm | (aSubTerm soulDownIn: anEnv startAt: anIndex) soulUp])
		containsCut: containsCut