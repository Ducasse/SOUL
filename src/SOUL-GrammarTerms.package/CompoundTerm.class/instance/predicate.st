access
predicate
	"See comment in AbstractTerm"

	
	^self functor isIndexable
		ifTrue: [self functor asPredicateNameInEnv: nil startAt: nil]
		ifFalse: [nil]