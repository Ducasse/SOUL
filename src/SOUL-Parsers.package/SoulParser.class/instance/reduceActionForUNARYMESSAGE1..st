generated-reduction actions
reduceActionForUNARYMESSAGE1: nodes
	^ builder
		buildUnaryMessageReceiver: (nodes at: 1)
		message: (nodes at: 2)