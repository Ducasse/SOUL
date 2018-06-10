symbiotic clause support
collectionMemberBlockWithTermPointer: aTermPointer andEnvironment: anEnvironment
	"Returns block to be used in symbiotic implementation of collectionMember/2 clause. Called at run-time. Specialized for fuzzy logic such that the unification degree of the first argument with an element of the collection is taken into account. "

	
	^[:anArg | 
	| hisIndex |
	hisIndex := anEnvironment startUnify: 0.
	(aTermPointer term soulUp
		unifyWith: anArg soulUp
		inEnv: anEnvironment
		myIndex: aTermPointer envIndex
		hisIndex: hisIndex
		inSource: false)
		ifTrue:
			[SoulFactory current makeResolutionResult
				condition: OrderedCollection new
				rollbackInfo: anEnvironment rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]
		ifFalse:
			[anEnvironment rollback.
			nil]]