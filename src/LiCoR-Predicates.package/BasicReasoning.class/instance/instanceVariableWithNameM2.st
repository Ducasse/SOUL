naming
instanceVariableWithNameM2

"defines the name of an instance variable"

instanceVariableWithName(?instanceVariable,?name) if 
	instanceVariable(?instanceVariable),equals(?name,[MLI current instanceVariableNameOf: ?instanceVariable])