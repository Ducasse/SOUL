*SOUL-Repositories
repository: aName put: aRepository
	
	Repositories at: aName put: aRepository.
	aRepository name: aName.
	aRepository compile.
	self notifyRepositoriesDependents