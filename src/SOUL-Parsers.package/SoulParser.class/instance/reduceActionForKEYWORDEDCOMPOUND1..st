generated-reduction actions
reduceActionForKEYWORDEDCOMPOUND1: nodes
	^ builder
		addKeyword: (nodes at: 1)
		term: (nodes at: 2)
		toKeywordedCompound: (nodes at: 3)