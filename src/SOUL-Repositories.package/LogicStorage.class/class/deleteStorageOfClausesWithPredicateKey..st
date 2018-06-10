private - storage
deleteStorageOfClausesWithPredicateKey: key
	
	| selector |
	selector := self selectorForPredicateKey: key.
	self removeSelector: selector