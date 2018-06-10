generated-reduction actions
reduceActionForKEYWORDEDMESSAGEANDARGS2: nodes
	^ builder
		buildKeywordedMessageFirstKey: (nodes at: 1)
		andArgument: (nodes at: 2)