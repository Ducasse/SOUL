repository composition
lookupBindingForName: varName
	"Lookup the binding for a repository variable"

	
	^self
		lookupBindingForName: varName
		ifAbsent: [self error: varName , ' does not exist!']