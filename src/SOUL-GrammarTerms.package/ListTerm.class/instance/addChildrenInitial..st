parsing
addChildrenInitial: aCollection
	"this method is called by the parser to construct a parsetree"

	"lists are simulated by compounds containing the head of the list as one 
	subterm and a listterm (compound) containing the rest of the list"

	"aCollection is a Collection that contains a TermSequence"

	
	| holdFirst holdSecond |
	holdSecond := EmptyListConstant new.
	aCollection first
		reverseDo:
			[:X | 
			| holdCollection |
			holdFirst := X.
			holdCollection := OrderedCollection with: holdFirst with: holdSecond.
			holdSecond := self makeListCompound: holdCollection].
	aCollection first size = 0
		ifTrue: [^holdSecond]
		ifFalse:
			[^self
				setFunctor: holdSecond functor
				setTermSequence: holdSecond termSequence]