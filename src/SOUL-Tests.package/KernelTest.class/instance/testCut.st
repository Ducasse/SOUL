evaluator
testCut
	"self run:#testCut"

	
	self repository assert:
			'foo(?x) if equals(a,?x),!.foo(?x) if equals(?x,b)'.
	self
		processQuery: ' if succeeds(foo(a))'
		description: 'Does the cut work?'
		repository: self repository.
	self
		processQuery: ' if foo(?x)'
		resultsCheck: [:results | results size = 1]
		description: 'Does the cut work?'
		repository: self repository.
	self
		processQuery: ' if succeeds(foo(b))'
		description: 'Does the cut work?'
		repository: self repository.
	self
		processQuery: ' if member(?x,<1,2,3>),testcutonfinal(?c)'
		resultsCheck: [:results | results size = 9]
		description: 'Does the cut work when the last clause contains the cut?'.
	self repository retractAll: 'foo/1'