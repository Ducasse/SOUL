private - predicate keys
multiplicityOfKey: aPredicateKey
	
	| splitIndex multString |
	splitIndex := aPredicateKey indexOf: $/.
	multString := aPredicateKey
		copyFrom: splitIndex + 1
		to: aPredicateKey size.
	^multString asNumber