visiting terms
compoundVisit: aCompound
	
	| number |
	number := database addressForPredicate: aCompound predicate.
	aCompound lexicalAddress: number.
	aCompound functor accept: self.
	aCompound termSequence accept: self.
	aCompound astLink == nil ifFalse: [aCompound astLink accept: self]