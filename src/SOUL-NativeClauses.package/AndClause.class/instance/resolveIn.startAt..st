resolving
resolveIn: anEnv startAt: anIndex
	"resolve an and-clause by fetching the conditions from the clause and  
	putting them all back on the stack"

	
	| args resolveBlock clausesPointer clauses |
	clausesPointer := self getArgument: 1 in: anEnv startAt: anIndex.
	clauses := OrderedCollection new.
	clausesPointer term listDo: [:aClause | clauses add: aClause].
	args := OrderedCollection new.
	args add: clauses.
	resolveBlock := [:myClauses | 
	ResolutionResult
		condition: myClauses
		rollbackInfo: anEnv rollbackInfo
		conditionsEnvIndex: clausesPointer envIndex
		cutState: false].
	^NativeResolver onBlock: resolveBlock withArguments: args