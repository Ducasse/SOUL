add/del - runtime
retract: aPredicateKey
	
	| pred multi |
	"Retract all clauses with a particular predicatekey = predicate / multiplicity"

	pred := LogicStorage predicateOfKey: aPredicateKey.
	multi := LogicStorage multiplicityOfKey: aPredicateKey.
	^self retract: pred multiplicity: multi