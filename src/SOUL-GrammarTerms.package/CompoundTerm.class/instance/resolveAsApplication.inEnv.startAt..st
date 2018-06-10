resolving
resolveAsApplication: aBlockClosure inEnv: env startAt: anIndex
	"I resolve a CompoundTerm whose functor is a BlockClosure as the application of the BlockClosure to the CompoundTerm's arguments."

	
	| numArgs downedTermArgs |
	downedTermArgs := self termSequence terms asArray
		collect: [:term | term soulDownIn: env startAt: anIndex].
	numArgs := aBlockClosure numArgs.
	numArgs = self multiplicity
		ifTrue:
			[^(aBlockClosure valueWithArguments: downedTermArgs) soulUp resolveIn: env
				startAt: anIndex].
	numArgs = (self multiplicity - 1)
		ifTrue:
			[^SoulFactory current makeNativeResolver
				onBlock:
					[:arg | 
					(downedTermArgs last
						unifyWith: arg soulUp
						inEnv: env
						myIndex: anIndex
						hisIndex: (env startUnify: 0)
						inSource: false)
						ifFalse:
							[env rollback.
							nil]
						ifTrue:
							[SoulFactory current makeResolutionResult
								condition: SoulFactory current makeTermSequence new
								rollbackInfo: env rollbackInfo
								conditionsEnvIndex: nil
								cutState: false]]
				withArguments:
					(OrderedCollection
						with:
							(aBlockClosure valueWithArguments: (downedTermArgs allButLast: 1)))].
	^SoulFactory current makeNativeResolver
		onBlock: [:res | res]
		withArguments: #(nil)