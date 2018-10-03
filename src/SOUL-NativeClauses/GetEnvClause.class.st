Class {
	#name : #GetEnvClause,
	#superclass : #NativeClause,
	#category : 'SOUL-NativeClauses'
}

{ #category : #resolving }
GetEnvClause >> resolveIn: anEnv startAt: anIndex [
	
	| argument1 argument2 |
	argument1 := self getArgument: 1 in: anEnv startAt: anIndex.
	argument2 := self getArgument: 2 in: anEnv startAt: anIndex.
	^NativeResolver
		onBlock:
			[:theArg | 
			| hisIndex |
			hisIndex := anEnv startUnify: 0.
			(argument1 term
				unifyWith: anEnv soulUp
				inEnv: anEnv
				myIndex: argument1 envIndex
				hisIndex: hisIndex
				inSource: true)
				ifTrue:
					[(argument2 term
						unifyWith: (anIndex - 2) soulUp
						inEnv: anEnv
						myIndex: argument2 envIndex
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
							nil]	"because getEnv itself reserves 2 spaces on the stack, we need to decrement by 2 to get the index before getEnv"
]
				ifFalse:
					[anEnv rollback.
					nil]]
		withArguments: #(#foo)
]
