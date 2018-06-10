editing-local
assertClause: clause inProtocol: protocol ifAlreadyClassified: alreadyClassifiedBlock
	
	^self
		assertClauses: (OrderedCollection with: clause)
		inProtocol: protocol
		ifAlreadyClassified: alreadyClassifiedBlock