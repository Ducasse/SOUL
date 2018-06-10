generated-reduction actions
reduceActionForTYPE1: nodes
	^ builder buildConstant: ((nodes at: 1) value allButFirst: 1)