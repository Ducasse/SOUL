resolving
resolveIn: anEnv startAt: anIndex
	
	| query ruleSelector args resolveBlock theNil holdCallStack callTerm theCall |
	"Not working yet!"

	args := OrderedCollection new.
	callTerm := self getArgument: 1 in: anEnv startAt: anIndex.
	theCall := self callForCallTerm: callTerm term.
	theCall evaluate.
	query := (SoulFactory current makeQuery
		condition:
			(SoulFactory current makeCompound
				functor: (Constant name: 'slg' , callTerm term functor name)
				termSequence:
					(SoulFactory current makeTermSequence
						terms: callTerm term terms , (UppedObject up: theCall id))))
		definitionRepository: self definitionRepository.
	ruleSelector := SoulFactory current makeRuleSelector new.
	holdCallStack := anEnv callStack.
	ruleSelector
		evalQuery: query
		inEnv: anEnv
		startAt: callTerm envIndex.
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
	^NativeResolver
		onBlock: resolveBlock
		withArguments: theCall answers