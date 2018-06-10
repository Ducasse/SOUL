SLG - auxiliary
justBelowTerm: aCallTerm
	
	| index |
	index := SLGCallStack lastIndexOf: aCallTerm.
	^SLGCallStack at: index - 1