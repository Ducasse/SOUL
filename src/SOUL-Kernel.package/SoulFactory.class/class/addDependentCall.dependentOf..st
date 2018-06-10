SLG - auxiliary
addDependentCall: aCallTerm dependentOf: aWaitingNode
	
	| alreadyDependent |
	alreadyDependent := DependentOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new].
	alreadyDependent add: aWaitingNode.
	DependentOn at: aCallTerm put: alreadyDependent