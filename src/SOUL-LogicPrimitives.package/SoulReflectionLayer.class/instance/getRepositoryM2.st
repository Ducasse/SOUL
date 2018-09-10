repositories
getRepositoryM2

getRepository(?variableName,?repository) if 
	getRepository(?rep),equals(?repository,[?rep lookupBindingFor: ?variableName])