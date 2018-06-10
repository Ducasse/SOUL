editing-local
moveClauseUp: clause
	
	| key index |
	key := self predicateKeyofClause: clause.
	index := (self clausesCollectionForKey: key)
		indexOf: clause
		ifAbsent:
			[self error: 'Trying to move a clause in a layer that does not contain it.'].
	index > 1
		ifTrue:
			[(self clausesCollectionForKey: key)
				swap: index
				with: index - 1.
			self storeClausesWithPredicateKey: key]