scoping
recursiveDefinitionRepository: aRepository
	
	self definitionRepository: aRepository.
	collection do: [:each | each recursiveDefinitionRepository: aRepository]