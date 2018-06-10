resolving
resolveIn: anEnv startAt: anIndex
	
	| resolveBlock |
	resolveBlock := [:aQuery | 
	ResolutionResult
		condition: (aQuery at: 1)
		rollbackInfo: anEnv rollbackInfo
		conditionsEnvIndex: anIndex
		cutState: false].
	^NativeResolver
		onBlock: resolveBlock
		withArguments: self queries