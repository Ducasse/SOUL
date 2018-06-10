add/del - from storage
addClauses: aCollection
	
	aCollection do: [:aClause | self addClause: aClause]	"The following code assumes that all clauses have the same predicate _and_ multiplicity

	| address result multiplicity pred |
	pred := aCollection first predicate.
	multiplicity := aCollection first multiplicity.
	pred
	address := self storeAddressForPredicate: pred.
	aCollection do:[:clause | clause makeClean. clause definitionRepository: self].
	result := self clausesAt: address multiplicity: multiplicity.
	result isEmpty
		ifTrue: [self clausesAt: address multiplicity: multiplicity put: aCollection]
		ifFalse: [self clausesAt: address multiplicity: multiplicity put: result , aCollection]"