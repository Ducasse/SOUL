SLG - auxiliary
addNegatedDependentCall: aCallTerm dependentOf: aWaitingNode
	
	| alreadyDependent |
	alreadyDependent := DependentNegatedOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new].
	alreadyDependent add: aWaitingNode.
	DependentNegatedOn at: aCallTerm put: alreadyDependent