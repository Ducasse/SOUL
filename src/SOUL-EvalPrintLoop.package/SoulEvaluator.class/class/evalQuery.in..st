instance creation
evalQuery: query in: repository
	
	| selector |
	query definitionRepository: repository.
	selector := (SoulFactory current makeRuleSelector new)
		evalQuery: query;
		yourself.
	^(self new)
		ruleselector: selector;
		query: query