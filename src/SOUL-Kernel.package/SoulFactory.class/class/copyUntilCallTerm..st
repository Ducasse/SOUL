SLG - auxiliary
copyUntilCallTerm: aCallTerm
	
	| result index |
	index := SLGCallStack lastIndexOf: aCallTerm.
	result := SLGCallStack
		copyFrom: index
		to: SLGCallStack size.
	^result