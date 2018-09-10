repositories
bindRepositoryM2

bindRepository(?variable,?repository) if 
	getRepository(?rep),[?rep bind: ?variable with: ?repository.
true]