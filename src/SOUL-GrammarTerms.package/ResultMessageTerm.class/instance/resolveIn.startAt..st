resolving
resolveIn: env startAt: anIndex
	"resolve as a normal term: do lookup in repository and create a resolver  on it"

	
	| foundClauses multiplicity address |
	multiplicity := self multiplicity.
	address := self
		lexicalAddressInEnv: env
		startAt: anIndex
		ifAbsent:
			[multiplicity := multiplicity - 1.
			self
				lexicalAddressInEnvNoEquals: env
				startAt: anIndex
				ifAbsent:
					[^self
						clauseNotFoundIn: self definitionRepository
						inEnv: env
						startAt: anIndex]].
	foundClauses := self definitionRepository normalAddressLookup: address
		multiplicity: multiplicity.
	^SoulFactory current makeResolver fromClause: self toClauses: foundClauses
		inEnv: env startAt: anIndex