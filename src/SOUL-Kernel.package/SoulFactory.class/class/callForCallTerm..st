SLG - auxiliary
callForCallTerm: aCallTerm
	
	| callsForPredicate theCall |
	callsForPredicate := CallsPerPredicate
		at: aCallTerm predicate , aCallTerm multiplicity asString
		ifAbsentPut: [OrderedCollection new].
	theCall := callsForPredicate
		detect: [:aCall | aCall isSLGEquivalentTo: aCallTerm]
		ifNone: [self newSLGCallFor: aCallTerm inCollection: callsForPredicate].
	^theCall