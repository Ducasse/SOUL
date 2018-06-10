generated-reduction actions
reduceActionForVariable3: nodes
	^ RBDelayedSoulVariableNode
		named: ((nodes at: 1) value allButFirst: 1)