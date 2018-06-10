resolving
resolveIn: anEnv startAt: anIndex
	
	| query ruleSelector args resolveBlock theNil holdCallStack clausesPointer clauses |
	args := OrderedCollection new.
	clausesPointer := self getArgument: 1 in: anEnv startAt: anIndex.
	clauses := OrderedCollection new.
	clausesPointer term listDo: [:anItem | clauses add: anItem].
	query := SoulFactory current makeQuery
		condition: 
			((SoulFactory current makeTermSequence terms: clauses)
				definitionRepository: self definitionRepository).
	ruleSelector := SoulFactory current makeRuleSelector new.
	holdCallStack := anEnv callStack.
	ruleSelector
		evalQuery: query
		inEnv: anEnv
		startAt: clausesPointer envIndex.
	args add: ruleSelector next.
	anEnv callStack: holdCallStack.
	theNil := nil.
	resolveBlock := [:theResult | 
	theResult == false
		ifTrue:
			[ResolutionResult
				condition:
					(SoulFactory current makeTermSequence terms: OrderedCollection new)
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: anEnv currentVariableIndex
				cutState: false]
		ifFalse: [theNil]].
	^NativeResolver onBlock: resolveBlock withArguments: args