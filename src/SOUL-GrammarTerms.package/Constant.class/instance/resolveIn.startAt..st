resolving
resolveIn: env startAt: anIndex
	"resolve as a normal term: do lookup in repository and create a resolver  on it"

	
	| foundClauses |
	foundClauses := self definitionRepository
		normalAddressLookup:
			(self
				lexicalAddressInEnv: env
				startAt: anIndex
				ifAbsent:
					[^self
						clauseNotFoundIn: self definitionRepository
						inEnv: env
						startAt: anIndex])
		multiplicity: 0.
	^SoulFactory current makeResolver fromClause: self toClauses: foundClauses
		inEnv: env startAt: anIndex