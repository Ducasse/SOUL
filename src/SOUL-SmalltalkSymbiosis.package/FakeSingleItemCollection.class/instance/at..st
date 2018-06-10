collection faking
at: idx
	
	^idx = 1
		ifTrue: [item]
		ifFalse: [self error: 'collection contains only one element']