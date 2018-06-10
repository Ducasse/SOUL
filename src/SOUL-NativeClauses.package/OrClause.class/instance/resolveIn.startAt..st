resolving
resolveIn: anEnv startAt: anIndex
	"Need to put them in a collection because the expandStack method wants  
	to do a reverseDo on every clause(Sequence)"

	
	| resolveBlock ownClauses clausesPointer |
	clausesPointer := self getArgument: 1 in: anEnv startAt: anIndex.
	resolveBlock := [:clause | 
	| temp |
	temp := OrderedCollection new.
	temp add: clause.
	ResolutionResult
		condition: temp
		rollbackInfo: anEnv rollbackInfo
		conditionsEnvIndex: clausesPointer envIndex
		cutState: false].
	ownClauses := OrderedCollection new.
	clausesPointer term listDo: [:aClause | ownClauses add: aClause].
	^NativeResolver onBlock: resolveBlock withArguments: ownClauses