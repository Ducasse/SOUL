visitor-double dispatching
acceptBlockNode: aBlockNode
	
	| temp |
	temp := self visitNode: aBlockNode body.
	^self
		makeCompoundTerm: 'block'
		withTerm:
			(self
				makeCompoundTerm: 'arguments'
				withTerm: (self visitNodes: aBlockNode arguments))
		andTerm: temp first
		andTerm: (temp at: 2)