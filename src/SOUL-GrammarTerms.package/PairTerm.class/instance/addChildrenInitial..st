parsing
addChildrenInitial: aCollection
	"this is called by the parser to construct a parsetree"

	"aCollection is een Collection die een QSOULTermSequence bevat"

	
	| holdFirst holdSecond |
	holdSecond := aCollection last.
	aCollection first
		reverseDo:
			[:X | 
			| holdCollection |
			holdFirst := X.
			holdCollection := OrderedCollection with: holdFirst with: holdSecond.
			holdSecond := self makeListCompound: holdCollection].
	^self
		setFunctor: holdSecond functor
		setTermSequence: holdSecond termSequence