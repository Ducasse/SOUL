add/del - runtime
addClause: aClause
	"Add a clause to this repository"

	
	aClause addToRepository: self.
	self addClauses: aClause additionalClausesForDefinitionRepository.
	^true