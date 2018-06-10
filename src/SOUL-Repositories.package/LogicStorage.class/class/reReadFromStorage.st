private - storage
reReadFromStorage
	
	| dummyInstance clauses key |
	dummyInstance := self new.
	self initClausesStore.
	self initPredicateMappings.
	self selectors
		do:
			[:selector | 
			clauses := (dummyInstance perform: selector) clauses.
			key := self predicateKeyofClause: clauses first.
			self clausesStore at: key put: clauses.
			self selectorToPredicateKeyMapping at: selector put: key].
	self notifyImplementationChange