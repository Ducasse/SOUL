generated-reduction actions
reduceActionForRESULTMESSAGE1: nodes
	^ builder
		buildResultMessageTerm: (nodes at: 1)
		resultTerm: (nodes at: 3)