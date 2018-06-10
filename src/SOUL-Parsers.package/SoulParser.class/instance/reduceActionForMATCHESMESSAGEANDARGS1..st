generated-reduction actions
reduceActionForMATCHESMESSAGEANDARGS1: nodes
	^ builder
		buildKeywordedMessageFirstKey: (builder buildKeyword: #matches:)
		andArgument: (nodes at: 2)