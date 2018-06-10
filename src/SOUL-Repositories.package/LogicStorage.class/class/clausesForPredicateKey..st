accessing-all
clausesForPredicateKey: predicateKey
	
	| clauses |
	"returns the clauses that are defined for the given predicatekey, in this layer and all sublayers"

	clauses := OrderedCollection new.
	clauses
		addAll:
			(self clausesStore
				at: predicateKey
				ifAbsent: [OrderedCollection new]).
	self subclasses
		do:
			[:subclass | clauses addAll: (subclass clausesForPredicateKey: predicateKey)].
	^clauses