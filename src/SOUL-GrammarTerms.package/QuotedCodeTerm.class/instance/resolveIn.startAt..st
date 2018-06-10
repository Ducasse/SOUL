resolving
resolveIn: anEnv startAt: anIndex
	
	| term visitor |
	term := (SoulFactory current makeParser
		parse: source
		onError: [self error: 'cannot parse contents as a soul term']) clauses
		first conclusion.
	visitor := FixVisitor new addVariables: self variables.
	term accept: visitor.
	term definitionRepository: self definitionRepository.
	^term resolveIn: anEnv startAt: anIndex