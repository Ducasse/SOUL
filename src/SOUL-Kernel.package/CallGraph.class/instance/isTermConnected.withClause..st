testing
isTermConnected: aTerm withClause: aClause
	
	| result |
	result := self isConnected: aTerm withClause: aClause.
	^result