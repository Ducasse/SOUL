accessing-all
allPredicateKeysIn: protocol
	"Return all predicatekeys in this layer and all sublayers"

	
	| collection |
	collection := (self predicateKeysIn: protocol) asOrderedCollection.
	self subclasses
		do: [:cl | collection addAll: (cl allPredicateKeysIn: protocol)].
	^collection