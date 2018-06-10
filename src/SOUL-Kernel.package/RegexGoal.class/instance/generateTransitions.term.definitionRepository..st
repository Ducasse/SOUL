converting
generateTransitions: aRegexTerm term: term definitionRepository: aRepository
	
	self generateGoal: aRegexTerm definitionRepository: aRepository.
	transitionsTo
		collect:
			[:trans | 
			trans
				generateTransitions: aRegexTerm identifier
				term: term
				definitionRepository: aRepository]