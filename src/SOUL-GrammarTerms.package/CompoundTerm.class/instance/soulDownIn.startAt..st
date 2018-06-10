reification
soulDownIn: anEnv startAt: anIndex
	"downing a compoundterm means downing the functor and downing the termsequence. HOWEVER: we must up the functor again because it gets included 	in the compound again"

	
	| newTermSequence value |
	value := astlink soulDownIn: anEnv startAt: anIndex.	"Need for a cleaner solution here... this requires me to work a bit on the environment too though"

	(value isKindOf: Variable)
		ifTrue:
			[newTermSequence := termsequence soulDownIn: anEnv startAt: anIndex.
			^(self class
				functor: (functor soulDownIn: anEnv startAt: anIndex) soulUp
				termSequence: newTermSequence
				astLink: value) definitionRepository: self definitionRepository]
		ifFalse: [^value]