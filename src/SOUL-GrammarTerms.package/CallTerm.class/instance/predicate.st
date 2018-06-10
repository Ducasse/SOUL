access
predicate
	
	| normalPredicate |
	normalPredicate := normalterm predicate.
	^normalPredicate == nil
		ifTrue: [nil]
		ifFalse: ['Q' , variable name , normalterm predicate]