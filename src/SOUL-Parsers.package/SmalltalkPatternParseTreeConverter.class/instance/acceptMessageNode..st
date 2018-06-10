visitor-double dispatching
acceptMessageNode: aMessageNode
	
	^aMessageNode isPatternNode
		ifTrue: [self processPatternMessageNode: aMessageNode]
		ifFalse: [super acceptMessageNode: aMessageNode]