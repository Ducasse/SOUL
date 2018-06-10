add/del - runtime
retractAll: aPredicate multiplicity: multi
	
	| address |
	"Retract all clauses with a particular predicate and multiplicity"

	address := self addressForPredicate: aPredicate.
	self
		clausesAt: address
		multiplicity: multi
		put: OrderedCollection new.
	^true