visitor-double dispatching
acceptMethodNode: aMethodNode
	
	^aMethodNode isPatternNode
		ifTrue: [self processPatternMethodNode: aMethodNode]
		ifFalse: [super acceptMethodNode: aMethodNode]