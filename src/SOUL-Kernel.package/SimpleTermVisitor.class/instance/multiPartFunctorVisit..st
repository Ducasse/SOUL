visiting terms
multiPartFunctorVisit: aFunctor
	"See comment in keywordFunctorVisit: and messageFunctorVisit:"

	
	^aFunctor keywords do: [:keyword | keyword accept: self]