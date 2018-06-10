private - storage
storageChangedExternally: selector newCode: aCode
	
	| clauses key |
	clauses := (SoulFactory current makeParser parseAfterRemovingSelector: aCode)
		clauses.
	key := self predicateKeyofClause: clauses first.
	self clausesStore at: key put: clauses.
	self selectorToPredicateKeyMapping at: selector put: key.
	self notifyImplementationChange