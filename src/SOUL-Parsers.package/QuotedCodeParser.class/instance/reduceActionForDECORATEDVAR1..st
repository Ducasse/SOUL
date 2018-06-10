generated-reduction actions
reduceActionForDECORATEDVAR1: nodes
	^ builder
		buildDecoratedVariable: (nodes at: 1) value
		with: (nodes at: 2)