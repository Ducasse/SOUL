initialize
fromResolution: aResolutionResult
	
	| conditionsEnvIndex |
	envRollbackInfo := aResolutionResult rollbackInfo.
	conditionsEnvIndex := aResolutionResult conditionsEnvIndex.
	aResolutionResult conditions
		reverseDo:
			[:condition | 
			conditionsList := TermPointer term: condition envIndex: conditionsEnvIndex
				nextTerm: conditionsList]