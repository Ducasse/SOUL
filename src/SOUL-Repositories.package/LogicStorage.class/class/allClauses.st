accessing-all
allClauses
	"Return all clauses in this layer and all sublayers"

	
	| collection |
	collection := self gatherClauses.
	self allSubclasses do: [:cl | collection addAll: cl gatherClauses].
	^collection