natives
testgetRepository
	
	self processQuery:
			' if getRepository(?rep),[?rep isKindOf: LogicRepository]' description:
			'Does the getRepository predicate return a repository?'