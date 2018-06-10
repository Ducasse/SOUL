scoping
recursiveDefinitionRepository: aRepository
	"see comment in AbstractTerm"

	
	self definitionRepository: aRepository.
	messageTerm recursiveDefinitionRepository: aRepository.
	resultTerm recursiveDefinitionRepository: aRepository