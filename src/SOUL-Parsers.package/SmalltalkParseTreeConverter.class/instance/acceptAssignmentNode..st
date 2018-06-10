visitor-double dispatching
acceptAssignmentNode: anAssignmentNode
	
	^self
		makeCompoundTerm: 'assign'
		withTerm: (self visitNode: anAssignmentNode variable)
		andTerm: (self visitNode: anAssignmentNode value)