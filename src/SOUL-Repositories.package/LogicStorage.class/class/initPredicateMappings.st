initialize
initPredicateMappings
	
	| clause |
	"construct the table of selector -> predicates mappings. this is used by the clause browser"

	selectorToPredicateKey := Dictionary new.
	self selectors
		do:
			[:sel | 
			clause := (self new perform: sel) clauses first.
			selectorToPredicateKey
				at: sel
				put: (self predicateKeyofClause: clause)]