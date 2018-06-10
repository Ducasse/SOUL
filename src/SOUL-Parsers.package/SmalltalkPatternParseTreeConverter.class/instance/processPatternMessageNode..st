private
processPatternMessageNode: aMessageNode
	
	^self
		makeCompoundTerm: 'send'
		withTerm: (self visitNode: aMessageNode receiver)
		andTerm: (self processSelector: aMessageNode)
		andTerm: (self processArguments: aMessageNode)