SLG
detectTabledCallIn: aTermCollection using: aConclusion
	
	| myLiteral |
	myLiteral := aConclusion predicate , aConclusion multiplicity asString.	"Check if the conditions contain a recursive call or a call to a tabled predicate. TODO: check for tabled predicate too"

	^aTermCollection
		detect:
			[:aCondition | 
			(aCondition functor printString , aCondition multiplicity printString) =
					myLiteral]
		ifNone: [nil]