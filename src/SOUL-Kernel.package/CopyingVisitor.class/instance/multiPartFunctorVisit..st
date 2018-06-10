visiting terms
multiPartFunctorVisit: aFunctor
	"See comment in keywordFunctorVisit: and messageFunctorVisit:"

	
	^aFunctor class
		keywords: (aFunctor keywords collect: [:keyword | keyword accept: self])