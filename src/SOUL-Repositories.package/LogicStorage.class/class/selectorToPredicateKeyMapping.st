private - storage
selectorToPredicateKeyMapping
	
	selectorToPredicateKey == nil ifTrue: [self initPredicateMappings].
	^selectorToPredicateKey