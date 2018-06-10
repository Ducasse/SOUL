access
evaluateIn: anEnv startAt: anIndex
	"we need to evaluate the block for this term. unbound variables should be  
	looked up in the environment"

	
	| result |
	variables at: 1 put: anEnv.
	variables at: 2 put: anIndex.
	result := [block valueWithArguments: variables]
		on: UnboundVariableException
		do: [:ex | self].
	variables at: 1 put: nil.
	variables at: 2 put: nil.
	^result