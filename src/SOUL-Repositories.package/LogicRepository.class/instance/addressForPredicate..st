access
addressForPredicate: predicate
	"returns the lexical address assigned to a predicate. returns nil if no address was assigned to that predicate"

	
	^addressForPredicate
		at: predicate
		ifAbsent: [nil]