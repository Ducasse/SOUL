private - predicate keys
predicateKeyofClause: aClause
	
	^self
		makePredicateKey: aClause predicate
		multiplicity: aClause multiplicity