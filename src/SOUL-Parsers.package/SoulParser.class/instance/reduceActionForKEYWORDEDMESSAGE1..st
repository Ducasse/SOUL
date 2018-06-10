generated-reduction actions
reduceActionForKEYWORDEDMESSAGE1: nodes
	^ builder
		buildRegexMessageReceiver: (nodes at: 1)
		message: (nodes at: 2)