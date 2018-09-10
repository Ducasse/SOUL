natives
testgetEnv
	
	self processQuery:
			' if getEnv(?env,?id),[(?env isKindOf: Environment) and: [?id isKindOf: Number]]'
		description: 'Does the getEnv predicate return an environment?'.
	self processQuery: ' if getEnv(?env,?id),[?env == env]' description:
			'Does the getEnv predicate return the correct environment?'