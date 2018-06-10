SLG - auxiliary
popUntilCallTerm: aCallTerm
	
	| result index |
	index := SLGCallStack lastIndexOf: aCallTerm.
	result := SLGCallStack removeLast: SLGCallStack size - index + 1.
	^result