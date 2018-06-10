private - storage
gatherClauses
	
	| result |
	result := OrderedCollection new.
	self clausesStore values do: [:clauses | result addAll: clauses].
	^result