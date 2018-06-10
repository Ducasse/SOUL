editing-local
assertClause: clause
	
	^self
		assertClause: clause
		inProtocol: self defaultProtocol
		ifAlreadyClassified: [:key :currentProtocol :newProtocol | false]