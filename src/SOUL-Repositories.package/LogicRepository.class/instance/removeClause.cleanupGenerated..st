add/del - runtime
removeClause: aClause cleanupGenerated: aBoolean
	
	| pred multi address aCollection |
	"remove a clause from the database, the argument must be the same clause object as the one in the repository"

	pred := aClause predicate.
	multi := aClause multiplicity.
	address := self addressForPredicate: pred.
	aCollection := self clausesAt: address multiplicity: multi.
	aCollection
		remove: aClause
		ifAbsent: [self error: 'unknown error, tabled rules probably'].
	aBoolean
		ifTrue: [aClause isTabledRule ifTrue: [self removeTabledRule: aClause]]