repository composition
breakBindingForName: varName
	
	| repository |
	"Free a repository variable"

	repository := repositoryVariables
		at: varName
		ifAbsent: [self error: varName , ' does not exist!'].
	repositoryVariables removeKey: varName.
	exports
		at: varName
		ifAbsent: [^true].
	(exports at: varName) do: [:cl | repository removeClause: cl]