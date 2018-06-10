visitor-double dispatching
acceptVariableNode: aVariableNode
	
	^self
		makeCompoundTerm: 'variable'
		withTerm: (Constant name: aVariableNode name asSymbol)