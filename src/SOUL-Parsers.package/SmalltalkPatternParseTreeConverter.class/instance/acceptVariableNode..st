visitor-double dispatching
acceptVariableNode: aVariableNode
	
	^aVariableNode isPatternNode
		ifTrue: [self processPatternVariable: aVariableNode]
		ifFalse: [super acceptVariableNode: aVariableNode]