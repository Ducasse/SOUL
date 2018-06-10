access
lookup: aVar startAt: startIndex
	
	| index |
	index := startIndex + aVar address.
	index > variableArray size ifTrue: [^nil].
	^variableArray at: index