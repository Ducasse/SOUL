generated-reduction actions
reduceActionForTERM1: nodes
	^ builder
		buildAnnotatedTerm: (nodes at: 1)
		withAnnotation: (nodes at: 3)