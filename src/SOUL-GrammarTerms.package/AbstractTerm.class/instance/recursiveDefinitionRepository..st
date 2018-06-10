scoping
recursiveDefinitionRepository: aRepository
	"Each term keeps a pointer to the repository where it was defined. This method is used by the repository when a clause (and all its subterms) get added to it"

	
	self definitionRepository: aRepository