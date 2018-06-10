initialize
fromClause: aClause toClauses: aSetOfClauses inEnv: anEnv startAt: anIndex
	
	clause := aClause.
	clauseIndex := 1.
	delayedClauses := aSetOfClauses.
	env := anEnv.
	startIndex := anIndex