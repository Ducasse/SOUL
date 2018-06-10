private
recursiveDefinitionRepository: aRepository
	
	self definitionRepository: aRepository.
	self queries
		do:
			[:aQuery | aQuery do: [:i | i recursiveDefinitionRepository: aRepository]]