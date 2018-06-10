SLG - auxiliary
getDependentCalls: aCallTerm
	
	^DependentOn
		at: aCallTerm
		ifAbsent: [OrderedCollection new]