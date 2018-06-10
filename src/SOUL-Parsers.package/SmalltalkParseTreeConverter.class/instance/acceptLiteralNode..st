visitor-double dispatching
acceptLiteralNode: aLiteralNode
	
	^self
		makeCompoundTerm: 'literal'
		withTerm: (SoulFactory current makeUppedObject up: aLiteralNode value)