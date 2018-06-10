resolving
resolveIn: anEnv startAt: envIndex
	
	| headPointer bodyPointer head body clauses address clausePointer |
	headPointer := self getArgument: 1 in: anEnv startAt: envIndex.
	bodyPointer := self getArgument: 2 in: anEnv startAt: envIndex.
	clausePointer := self getArgument: 3 in: anEnv startAt: envIndex.
	headPointer term innerTerm isVariable
		ifTrue:
			[clauses := OrderedCollection new.
			self definitionRepository clausesDo: [:clause | clauses add: clause]]
		ifFalse:
			[(headPointer term innerTerm
				predicateInEnv: anEnv
				startAt: headPointer envIndex) == nil
				ifTrue:
					[clauses := self definitionRepository
						allClausesWith: headPointer term innerTerm multiplicity]
				ifFalse:
					[address := self definitionRepository
						addressForPredicate:
							(headPointer term innerTerm
								predicateInEnv: anEnv
								startAt: headPointer envIndex).
					address isNil
						ifTrue: [clauses := OrderedCollection new]
						ifFalse:
							[clauses := self definitionRepository
								normalAddressLookup: address
								multiplicity: headPointer term innerTerm multiplicity]]].
	clauses isEmpty
		ifTrue:
			[clauses add: nil.
			^NativeResolver
				onBlock: [:theNil | theNil]
				withArguments: clauses]
		ifFalse:
			[^NativeResolver
				onBlock:
					[:clause | 
					| hisIndex |
					head := clause conclusion.
					body := SoulFactory current makeList termSequence: clause condition.
					hisIndex := anEnv startUnifyWith: clause.
					(headPointer term
						unifyWith: head
						inEnv: anEnv
						myIndex: headPointer envIndex
						hisIndex: hisIndex
						inSource: true)
						&
							(bodyPointer term
								unifyWith: body
								inEnv: anEnv
								myIndex: bodyPointer envIndex
								hisIndex: hisIndex
								inSource: true)
						&
							(clausePointer term
								unifyWith: (UppedObject up: clause)
								inEnv: anEnv
								myIndex: clausePointer envIndex
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
				withArguments: clauses]