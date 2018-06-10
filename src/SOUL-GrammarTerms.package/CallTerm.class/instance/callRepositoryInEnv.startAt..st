private
callRepositoryInEnv: anEnv startAt: anIndex
	
	| localValue |
	localValue := variable soulDownIn: anEnv startAt: anIndex.
	^localValue = variable
		ifTrue: [self definitionRepository lookupBindingFor: variable]
		ifFalse: [localValue]