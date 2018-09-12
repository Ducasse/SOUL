information extraction
selector
	
	selector isNil ifTrue: [selector := compiledMethod selector].
	^selector