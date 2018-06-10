private
processArguments: aMessageNode
	
	^aMessageNode arguments size > 1
		ifTrue: [self processMultiArguments: aMessageNode arguments]
		ifFalse: [self processArgument: (aMessageNode arguments at: 1)]