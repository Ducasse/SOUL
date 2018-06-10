resolving
resolveIn: anEnv startAt: anIndex
	
	| resolveBlock resolveBlockArgs |
	resolveBlockArgs := OrderedCollection new.
	resolveBlockArgs add: nil.
	resolveBlock := [:arg | 
	(self smalltalkValue isKindOf: Boolean)
		ifFalse:
			[self error: 'SmallTalkClauses should always evaluate to true or false!'].
	self smalltalkValue
		ifTrue:
			[ResolutionResult
				condition: SoulFactory current makeTermSequence new
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]].
	^NativeResolver onBlock: resolveBlock withArguments: resolveBlockArgs