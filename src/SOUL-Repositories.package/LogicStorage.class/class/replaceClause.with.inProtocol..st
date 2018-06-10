editing-local
replaceClause: original with: replacement inProtocol: protocol
	
	^self
		replaceClause: original
		with: replacement
		inProtocol: protocol
		ifAlreadyClassified: [:key :currentProtocol :newProtocol | false]