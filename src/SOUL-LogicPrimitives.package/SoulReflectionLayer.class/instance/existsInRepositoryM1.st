repositories
existsInRepositoryM1

"This predicate only works with simple predicates"

existsInRepository(?Head) if 
	getRepository(?repository),equals(?clauses,[| addr clauses mult |
addr := ?repository
	addressForPredicate: ?Head functor smalltalkValue asString.
addr == nil
	ifTrue: [#()]
	ifFalse:
		[mult := ?Head multiplicity.
		clauses := ?repository normalAddressLookup: addr multiplicity: mult.
		clauses collect: [:aClause | aClause conclusion]]]),succeeds(member(?Head,?clauses))