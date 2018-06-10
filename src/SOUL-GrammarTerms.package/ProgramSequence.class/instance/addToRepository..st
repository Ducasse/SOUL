repository
addToRepository: aRepository
	
	self clauses do: [:c | c addToRepository: aRepository]