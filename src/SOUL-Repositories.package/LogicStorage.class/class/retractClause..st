editing-local
retractClause: clause
	
	| key |
	key := self predicateKeyofClause: clause.
	(self clausesCollectionForKey: key)
		remove: clause
		ifAbsent:
			[self error:
					'Trying to remove a clause from a layer that does not contain it.'].
	self storeClausesWithPredicateKey: key