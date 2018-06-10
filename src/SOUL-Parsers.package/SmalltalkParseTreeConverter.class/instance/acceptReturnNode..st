visitor-double dispatching
acceptReturnNode: aReturnNode
	
	^self
		makeCompoundTerm: 'return'
		withTerm: (self visitNode: aReturnNode value)