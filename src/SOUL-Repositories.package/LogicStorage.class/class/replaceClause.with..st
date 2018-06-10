editing-local
replaceClause: original with: replacement
	
	^self
		replaceClause: original
		with: replacement
		inProtocol:
			(self protocolOfPredicate: (self predicateKeyofClause: original))