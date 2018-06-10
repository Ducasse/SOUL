repository composition
lookupBindingForName: varName ifAbsent: aBlock
	"Lookup the binding for a repository variable"

	
	^repositoryVariables at: varName ifAbsent: aBlock