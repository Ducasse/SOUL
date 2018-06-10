reification
transitiveLookupIn: anEnv startAt: anIndex
	
	| newTermSequence |
	newTermSequence := termsequence transitiveLookupIn: anEnv startAt: anIndex.
	^self class functor: functor termSequence: newTermSequence