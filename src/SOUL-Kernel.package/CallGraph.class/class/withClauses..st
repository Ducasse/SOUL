instance creation
withClauses: aCollection
	
	| graph |
	graph := CallGraph new withClauses: aCollection.
	^graph