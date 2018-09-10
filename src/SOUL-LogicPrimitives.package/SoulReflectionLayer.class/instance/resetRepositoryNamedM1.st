repositories
resetRepositoryNamedM1

"resetRepositoryNamed(LogicRoot)

resets a given repository"

resetRepositoryNamed(+?repositoryName) if 
	repositoryName(?rep,?repositoryName),[?rep reset.
true]