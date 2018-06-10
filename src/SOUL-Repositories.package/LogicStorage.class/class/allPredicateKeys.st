accessing-all
allPredicateKeys
	"Return all predicatekeys in this layer and all sublayers"

	
	| collection |
	collection := self predicateKeys.
	self allSubclasses do: [:cl | collection addAll: cl predicateKeys].
	^collection