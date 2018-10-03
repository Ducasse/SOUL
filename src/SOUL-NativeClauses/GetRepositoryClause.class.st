Class {
	#name : #GetRepositoryClause,
	#superclass : #NativeClause,
	#category : 'SOUL-NativeClauses'
}

{ #category : #resolving }
GetRepositoryClause >> resolveIn: anEnv startAt: anIndex [
	
	| argument args |
	argument := self getArgument: 1 in: anEnv startAt: anIndex.
	args := OrderedCollection new.
	args add: argument.
	^NativeResolver
		onBlock:
			[:theArg | 
			| hisIndex |
			hisIndex := anEnv startUnify: 0.
			(theArg term
				unifyWith: self definitionRepository soulUp
				inEnv: anEnv
				myIndex: theArg envIndex
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
]
