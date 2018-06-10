SLG - auxiliary
getDependentNegatedCalls: aCallTerm
	
	^DependentNegatedOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new]