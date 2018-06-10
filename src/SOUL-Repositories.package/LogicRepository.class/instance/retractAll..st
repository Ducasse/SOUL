add/del - runtime
retractAll: aPredicateKey
	
	| pred multi |
	"Retract all clauses with a particular predicatekey = predicate / multiplicity"

	pred := LogicStorage predicateOfKey: aPredicateKey.
	multi := LogicStorage multiplicityOfKey: aPredicateKey.
	^self retractAll: pred multiplicity: multi