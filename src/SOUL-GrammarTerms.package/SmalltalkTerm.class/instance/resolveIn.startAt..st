resolving
resolveIn: anEnv startAt: anIndex
	
	| resolveBlock resolveBlockArgs result |
	resolveBlockArgs := OrderedCollection new.
	resolveBlockArgs add: variables.
	resolveBlock := [:arg | 
	arg at: 1 put: anEnv.
	arg at: 2 put: anIndex.
	result := [block valueWithArguments: arg]
		on: Exception
		do:
			[:ex | 
			(((ex isKindOf: Notification) or: [ex isKindOf: SoulRuntimeException]) or:[ex isKindOf: Halt])
				ifTrue: [ex pass].
			self error:
					'Smalltalk clauses should always evaluate to true or false! (throws an error)'].
	arg at: 1 put: nil.
	arg at: 1 put: nil.
	((result isKindOf: Boolean) or: [result isKindOf: Maybe])
		ifFalse:
			[self error: 'Smalltalk clauses should always evaluate to true or false!'].
	result
		ifTrue:
			[ResolutionResult
				condition: SoulFactory current makeTermSequence new
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]].
	^NativeResolver onBlock: resolveBlock withArguments: resolveBlockArgs