soul auto saved
compoundM1

"tested by KM on 2002/04/04

compound(+-?Term) tests for a compound term. It succeeds if ?Term is a compound term and fails otherwise."

compound(&Term) if 
	[&Term isKindOf: CompoundTerm]