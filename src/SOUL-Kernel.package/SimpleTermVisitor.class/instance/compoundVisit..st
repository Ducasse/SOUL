visiting terms
compoundVisit: aCompound
	
	aCompound functor accept: self.
	aCompound termSequence accept: self.
	aCompound astLink == nil ifFalse: [aCompound astLink accept: self]