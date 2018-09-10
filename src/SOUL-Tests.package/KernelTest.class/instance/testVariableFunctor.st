evaluator
testVariableFunctor
	
	self repository assert: 'foo(?functor(?functor))'.
	self repository assert: 'bla(a)'.
	self
		processQuery: ' if succeeds(foo(bla(bla)))'
		description: 'Variable functor test'
		repository: self repository.
	self
		processQuery: ' if succeeds(and(equals(?name,bla),?name(a)))'
		description: 'Variable functor test'
		repository: self repository.
	self repository retractAll: 'bla/1'.
	self repository retractAll: 'foo/1'