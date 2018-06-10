resolving
resolveIn: anEnv startAt: anIndex
	"Resolving a cut means cutting of the callstack to avoid backtracking and making an empty resolver to allow further evaluation"

	
	anEnv callStack cut.
	^NativeResolver
		onBlock:
			[:foo | 
			ResolutionResult
				condition:
					(SoulFactory current makeTermSequence
						terms: OrderedCollection new
						containsCut: false)
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: anEnv currentVariableIndex
				cutState: false]
		withArguments:
			((OrderedCollection new)
				add: #foo;
				yourself)