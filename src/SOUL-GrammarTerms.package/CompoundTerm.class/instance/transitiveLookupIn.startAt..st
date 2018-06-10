reification
transitiveLookupIn: anEnv startAt: anIndex
	"See comment in AbstractTerm"

	
	| newTermSequence |
	newTermSequence := termsequence transitiveLookupIn: anEnv startAt: anIndex.
	^(self class
		functor: (functor transitiveLookupIn: anEnv startAt: anIndex)
		termSequence: newTermSequence
		astLink: (astlink transitiveLookupIn: anEnv startAt: anIndex))
		definitionRepository: self definitionRepository