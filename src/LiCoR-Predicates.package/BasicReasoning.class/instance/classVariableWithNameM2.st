naming
classVariableWithNameM2

"defines the name of a class variable"

classVariableWithName(?ClassVariable,?name) if 
	classVariable(?ClassVariable),equals(?name,[MLI current classVariableNameOf: ?ClassVariable])