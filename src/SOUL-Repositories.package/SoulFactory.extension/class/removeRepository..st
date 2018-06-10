*SOUL-Repositories
removeRepository: aName
	
	Repositories removeKey: aName.
	self notifyRepositoriesDependents