converting
generateTransitions: identifier term: aTerm definitionRepository: aDefinitionRepository
	
	self generateExistential: identifier term: aTerm definitionRepository:
			aDefinitionRepository.
	self generateUniversal: identifier term: aTerm definitionRepository:
			aDefinitionRepository