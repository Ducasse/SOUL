Class {
	#name : #WriteToPrologClause,
	#superclass : #NativeClause,
	#category : 'SOUL-NativeClauses'
}

{ #category : #resolving }
WriteToPrologClause >> resolveIn: anEnv startAt: anIndex [
	
	| argument writestream |
	argument := self getArgument: 1 in: anEnv startAt: anIndex.
	^NativeResolver
		onBlock:
			[:args | 
			writestream := WriteStream on: String new.
			argument term
				printAsPrologOn: writestream
				scope: #asTerm
				in: anEnv
				startAt: argument envIndex.
			Transcript
				show: writestream contents;
				cr.
			ResolutionResult
				condition:
					(SoulFactory current makeTermSequence terms: OrderedCollection new)
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: anEnv currentVariableIndex
				cutState: false]
		withArguments: #(#foo)
]
