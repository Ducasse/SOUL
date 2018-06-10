parsing
makeListCompound: aCollection
	"this is a help method for the parsetree construction"

	
	^self class
		functor: self class ListTermFunctor
		termSequence: (TermSequence terms: aCollection)