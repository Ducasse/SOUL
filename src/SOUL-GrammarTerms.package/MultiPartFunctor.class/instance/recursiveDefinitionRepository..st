scoping
recursiveDefinitionRepository: aRepository
	"see comment in AbstractTerm"

	
	self definitionRepository: aRepository.
	keywords
		do: [:keyword | keyword recursiveDefinitionRepository: aRepository]