visiting terms
unaryMessageFunctorVisit: unaryMessageFunctor
	
	^unaryMessageFunctor class
		message: (unaryMessageFunctor message accept: self)