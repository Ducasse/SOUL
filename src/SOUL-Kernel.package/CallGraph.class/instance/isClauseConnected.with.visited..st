private
isClauseConnected: theClause with: aClause visited: aCollection
	
	| connectedTo |
	(aCollection contains: [:x | theClause = x])
		ifTrue: [^false]
		ifFalse: [aCollection add: theClause].
	theClause = aClause ifTrue: [^true].
	connectedTo := nodeMapping at: theClause.
	^connectedTo
		contains:
			[:x | self isClauseConnected: x with: aClause visited: aCollection]