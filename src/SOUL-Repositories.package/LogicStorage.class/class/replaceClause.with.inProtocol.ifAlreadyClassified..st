editing-local
replaceClause: original with: replacement inProtocol: protocol ifAlreadyClassified: alreadyClassifiedBlock
	
	| keyOriginal keyReplacement indexOriginal |
	keyOriginal := self predicateKeyofClause: original.
	keyReplacement := self predicateKeyofClause: replacement.
	keyOriginal = keyReplacement
		ifTrue:
			[indexOriginal := (self clausesCollectionForKey: keyOriginal)
				indexOf: original
				ifAbsent:
					[self error:
							'Trying to replace a clause in a layer which does not contain it.'].
			(self clausesCollectionForKey: keyOriginal) at: indexOriginal put:
					replacement.
			self storeClausesWithPredicateKey: keyOriginal]
		ifFalse:
			[self retractClause: original.
			self assertClause: replacement inProtocol: protocol ifAlreadyClassified:
					alreadyClassifiedBlock]