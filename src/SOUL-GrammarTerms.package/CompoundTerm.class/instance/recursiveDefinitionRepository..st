scoping
recursiveDefinitionRepository: aRepository
	"see comment in AbstractTerm"

	
	self definitionRepository: aRepository.
	termsequence recursiveDefinitionRepository: aRepository