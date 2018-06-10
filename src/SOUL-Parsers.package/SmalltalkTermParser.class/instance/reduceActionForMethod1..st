generated-reduction actions
reduceActionForMethod1: nodes
	^ (RBMethodNode
		selector: (nodes at: 1) value asSymbol
		arguments: #()
		body:
		(nodes at: 2) last)
		tags:
			(nodes at: 2) first;
		yourself