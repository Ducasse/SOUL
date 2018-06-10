generated-reduction actions
reduceActionForKEYWORDEDMESSAGE2: nodes
	^ builder
		buildKeywordedMessageReceiver: (nodes at: 1)
		message: (nodes at: 2)