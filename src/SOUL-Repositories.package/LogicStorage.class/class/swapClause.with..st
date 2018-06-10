editing-local
swapClause: clauseA with: clauseB
	
	| key indexA indexB |
	key := self predicateKeyofClause: clauseA.
	(self predicateKeyofClause: clauseB) = key
		ifFalse:
			[self error:
					'Trying to swap two clauses which do not implement the same predicate.'].
	indexA := (self clausesCollectionForKey: key)
		indexOf: clauseA
		ifAbsent:
			[self error: 'Trying to swap two clauses not in the same layer. '].
	indexB := (self clausesCollectionForKey: key)
		indexOf: clauseB
		ifAbsent:
			[self error: 'Trying to swap two clauses not in the same layer. '].
	(self clausesCollectionForKey: key) swap: indexA with: indexB.
	self storeClausesWithPredicateKey: key