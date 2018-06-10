add/del - runtime
retract: aPredicate multiplicity: multi
	
	| address clauses |
	"Retract all clauses with a particular predicate and multiplicity"

	address := self addressForPredicate: aPredicate.
	clauses := self clausesAt: address multiplicity: multi.
	clauses isEmpty
		ifFalse:
			[self
				clausesAt: address
				multiplicity: multi
				put: (clauses allButFirst: 1)].
	^true