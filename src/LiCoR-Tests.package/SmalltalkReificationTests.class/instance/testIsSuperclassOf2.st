binary relations
testIsSuperclassOf2
	
	self processQuery:
			' if succeeds([TestClass1] isSuperclassOf: [SubClass1])' description:
			'Is TestClass1 the superclass of SubClass1?'.
	self processQuery: ' if fails([SubClass1] isSuperclassOf: [TestClass1])'
		description: 'Is SubClass1 not the superclass of TestClass1?'.
	self
		processQuery: ' if ?C isSuperclassOf: [SubClass1]'
		resultsCheck: [:results | results size = 1]
		description: 'Does SubClass1 have a unique superclass?'.
	self processQuery: ' if succeeds([TestClass1] isSuperclassOf: ?C)'
		description: 'Does TestClass1 have at least one subclass?'.
	self processQuery: ' if succeeds(?S isSuperclassOf: ?C)' description:
			'Can the predicate be used with two arguments unbound?'