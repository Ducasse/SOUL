private - predicate keys
makePredicateKey: aPredicate multiplicity: aMult
	
	^aMult < 0
		ifTrue: [aPredicate , '@']
		ifFalse: [aPredicate , '/' , aMult asString]