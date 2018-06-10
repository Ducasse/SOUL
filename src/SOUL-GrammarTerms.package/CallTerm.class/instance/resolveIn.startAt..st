resolving
resolveIn: anEnv startAt: anIndex
	"resolve as a normal clause: do lookup in repository and create a  
	resolver on it"

	
	| foundClauses resRep |
	resRep := self callRepositoryInEnv: anEnv startAt: anIndex.
	resRep compile.
	normalterm recursiveDefinitionRepository: resRep.
	foundClauses := resRep
		normalAddressLookup:
			(normalterm
				lexicalAddressInEnv: anEnv
				startAt: anIndex
				repository: resRep
				ifAbsent:
					[^self clauseNotFoundIn: resRep inEnv: anEnv startAt: anIndex])
		multiplicity: self multiplicity.
	^Resolver fromClause: normalterm toClauses: foundClauses inEnv: anEnv
		startAt: anIndex