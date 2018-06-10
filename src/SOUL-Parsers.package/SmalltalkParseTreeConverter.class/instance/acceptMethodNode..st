visitor-double dispatching
acceptMethodNode: aMethodNode
	
	| temp |
	temp := self visitNode: aMethodNode body.
	^self
		makeProgramSequence:
			(self
				makeCompoundTerm: 'method'
				withTerm: self methodClassTerm
				andTerm: (Constant name: aMethodNode selector asSymbol)
				andTerm:
					(self
						makeCompoundTerm: 'arguments'
						withTerm: (self visitNodes: aMethodNode arguments))
				andTerm: temp first
				andTerm: (temp at: 2))