visitor-double dispatching
acceptMessageNode: aMessageNode
	
	^self
		makeCompoundTerm: 'send'
		withTerm: (self visitNode: aMessageNode receiver)
		andTerm: (Constant name: aMessageNode selector asSymbol)
		andTerm: (self visitNodes: aMessageNode arguments)