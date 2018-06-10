accessing-all
usersOfPredicateKey: aPredicateKey
	
	| pred mult result |
	pred := self predicateOfKey: aPredicateKey.
	mult := self multiplicityOfKey: aPredicateKey.
	result := self usersOfPredicate: pred multiplicity: mult.
	self allSubclasses
		do:
			[:layer | result addAll: (layer usersOfPredicate: pred multiplicity: mult)].
	^result