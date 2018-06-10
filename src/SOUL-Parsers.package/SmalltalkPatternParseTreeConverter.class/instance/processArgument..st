private
processArgument: anArgument
	
	^anArgument isPatternNode
		ifTrue: [self processPatternVariable: anArgument]
		ifFalse: [self visitNode: anArgument]