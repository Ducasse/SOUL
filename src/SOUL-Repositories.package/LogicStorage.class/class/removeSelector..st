compilation support
removeSelector: sel
	
	| res |
	self clausesStore removeKey: (selectorToPredicateKey at: sel).
	selectorToPredicateKey
		removeKey: sel
		ifAbsent: [].
	res := super removeSelector: sel.
	self notifyImplementationChange.
	^res