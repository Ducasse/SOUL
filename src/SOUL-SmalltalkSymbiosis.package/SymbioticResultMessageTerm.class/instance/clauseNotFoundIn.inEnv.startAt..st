resolving
clauseNotFoundIn: repository inEnv: env startAt: anIndex
	
	| resolveBlock result receiver arguments resolverArgs |
	receiver := messageTerm termSequence terms first soulDownIn: env startAt:
			anIndex.
	arguments := (messageTerm termSequence terms allButFirst: 1) asArray
		collect: [:term | term soulDownIn: env startAt: anIndex].
	(receiver class canUnderstand: messageTerm functor messageSelector)
		ifFalse:
			[self
				error:
					messageTerm functor asString ,
							' is not implemented as a rule nor is understood as a message by instances of '
						, receiver class name asString].
	result := receiver
		perform: messageTerm functor messageSelector
		withArguments: arguments.	"TODO: yuk, type test"

	resolverArgs := (result isKindOf: OrderedCollection)
		ifTrue: [result]
		ifFalse: [OrderedCollection with: result].
	resolveBlock := [:arg | 
	(resultTerm
		unifyWith: arg soulUp
		inEnv: env
		myIndex: anIndex
		hisIndex: (env startUnify: 0)
		inSource: false)
		ifFalse:
			[env rollback.
			nil]
		ifTrue:
			[ResolutionResult
				condition: SoulFactory current makeTermSequence new
				rollbackInfo: env rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]].
	^NativeResolver onBlock: resolveBlock withArguments: resolverArgs