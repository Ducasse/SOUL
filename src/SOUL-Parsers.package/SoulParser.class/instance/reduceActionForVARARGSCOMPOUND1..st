generated-reduction actions
reduceActionForVARARGSCOMPOUND1: nodes
	^ builder
		buildVarArgsCompound: (nodes at: 1)
		withTerms: (nodes at: 3)