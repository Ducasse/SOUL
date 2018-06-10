visiting terms
compoundVisit: aCompound
	
	^aCompound class
		functor: (aCompound functor accept: self)
		termSequence: (aCompound termSequence accept: self)
		astLink:
			(aCompound astLink == nil
				ifTrue: [nil]
				ifFalse: [aCompound astLink accept: self])