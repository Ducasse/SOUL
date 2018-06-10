visitor-double dispatching
acceptSequenceNode: aSequenceNode
	
	^OrderedCollection
		with:
			(self
				makeCompoundTerm: 'temporaries'
				withTerm: (self visitNodes: aSequenceNode temporaries))
		with:
			(self
				makeCompoundTerm: 'statements'
				withTerm: (self visitNodes: aSequenceNode statements))