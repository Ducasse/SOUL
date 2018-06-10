editing-local
assertClauses: clauses
	
	^self
		assertClauses: clauses
		inProtocol: self defaultProtocol
		ifAlreadyClassified: [:key :currentProtocol :newProtocol | false]