resolving
resolveIn: anEnv startAt: anIndex
	
	| args termpointer resultpointer |
	termpointer := self getArgument: 1 in: anEnv startAt: anIndex.
	resultpointer := self getArgument: 2 in: anEnv startAt: anIndex.
	args := OrderedCollection new.
	args add: termpointer.
	^NativeResolver
		onBlock:
			[:theArg | 
			| hisIndex |
			hisIndex := anEnv startUnify: 0.
			(resultpointer term
				unifyWith: termpointer soulUp
				inEnv: anEnv
				myIndex: resultpointer envIndex
				hisIndex: hisIndex
				inSource: true)
				ifTrue:
					[ResolutionResult
						condition: OrderedCollection new
						rollbackInfo: anEnv rollbackInfo
						conditionsEnvIndex: hisIndex
						cutState: false]
				ifFalse:
					[anEnv rollback.
					nil]]
		withArguments: args