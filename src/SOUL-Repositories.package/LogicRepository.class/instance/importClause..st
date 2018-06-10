private
importClause: aClause
	"import a clause to this database, this happens when a repositoryvariable is bound to this repository and the other repository contains callclauses"

	
	| pred aCollection address multi |
	pred := aClause predicate.
	multi := aClause multiplicity.
	address := self storeAddressForPredicate: pred.
	aCollection := self clausesAt: address multiplicity: multi.
	aCollection add: aClause.
	self clausesAt: address multiplicity: multi put: aCollection