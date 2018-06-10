repository composition
bindName: varName with: aRepository
	"Bind a repository variable to a repository"

	
	repositoryVariables at: varName put: aRepository.
	exports
		at: varName
		ifAbsent: [^true].
	(exports at: varName) do: [:cl | aRepository importClause: cl]