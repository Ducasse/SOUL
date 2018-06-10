SLG - auxiliary
simplifyDependencyCallsFor: aCallTerm
	
	| positiveDependents negativeDependents |
	positiveDependents := self getDependentCalls: aCallTerm.
	negativeDependents := self getDependentNegatedCalls: aCallTerm.
	positiveDependents
		do: [:aCall | aCall simplifyAnswers: aCallTerm isNegated: false].
	negativeDependents
		do: [:aCall | aCall simplifyAnswers: aCallTerm isNegated: true]