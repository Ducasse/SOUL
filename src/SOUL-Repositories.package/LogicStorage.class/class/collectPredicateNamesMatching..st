accessing-all
collectPredicateNamesMatching: pattern
	
	| result |
	result := (self predicateKeys asOrderedCollection
		select: [:namex | pattern match: namex])
		collect: [:namex | Association key: self value: namex].
	self subclasses
		do:
			[:subclass | result addAll: (subclass collectPredicateNamesMatching: pattern)].
	^result