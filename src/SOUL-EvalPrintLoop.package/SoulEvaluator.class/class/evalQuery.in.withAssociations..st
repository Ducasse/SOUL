instance creation
evalQuery: aQuery in: aRepository withAssociations: aCollection
	
	| sel |
	self configureFactory.
	sel := SoulFactory current makeRuleSelector new.
	aQuery addConditionsInFront: (self makeEquals: aCollection).
	aQuery definitionRepository: aRepository.
	self prepareDefinitionRepositoryOfQuery: aQuery.
	sel evalQuery: aQuery.
	^(self new)
		ruleselector: sel;
		query: aQuery