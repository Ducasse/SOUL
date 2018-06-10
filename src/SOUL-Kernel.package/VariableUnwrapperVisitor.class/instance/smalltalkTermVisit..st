visiting terms
smalltalkTermVisit: anSTTerm
	
	^self objectVisit: (anSTTerm evaluateIn: nil startAt: nil) soulUp