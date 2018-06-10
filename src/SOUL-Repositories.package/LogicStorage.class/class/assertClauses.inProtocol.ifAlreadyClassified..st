editing-local
assertClauses: clauses inProtocol: protocol ifAlreadyClassified: alreadyClassifiedBlock
	
	| keys |
	keys := OrderedCollection new.
	clauses
		do:
			[:clause | 
			| key |
			key := self predicateKeyofClause: clause.
			(self clausesCollectionForKey: key) add: clause.
			keys add: key].
	keys
		do:
			[:key | 
			self classifyPredicate: key under: protocol ifAlreadyClassified:
					alreadyClassifiedBlock.
			self storeClausesWithPredicateKey: key]