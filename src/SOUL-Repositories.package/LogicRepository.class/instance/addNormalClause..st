add/del - runtime
addNormalClause: aClause
	
	| pred multi address aCollection |
	"callback from the clause to add a normal clause to the repository"

	pred := aClause predicate.
	multi := aClause multiplicity.
	address := self storeAddressForPredicate: pred.
	aCollection := self clausesAt: address multiplicity: multi.
	aClause makeClean.
	aClause definitionRepository: self.
	aCollection add: aClause.
	self clausesAt: address multiplicity: multi put: aCollection