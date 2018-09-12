classes
testIsSubclassOf2
	
	self processQuery: ' if succeeds([SubClass1] isSubclassOf: [TestClass1])'
		description: 'Is SubClass1 a subclass of TestClass1?'.
	self processQuery: ' if fails([TestClass1] isSubclassOf: [SubClass1])'
		description: 'Is TestClass1 not a subclass of SubClass1?'.
	self
		processQuery: ' if [SubClass1] isSubclassOf: ?C'
		resultsCheck: [:results | results size = 1]
		description: 'Is SubClass1 the subclass of a unique superclass?'.
	self processQuery:
			' if fails(and([MLI current allRootClassEntities] contains: ?Root,?Root isSubclassOf: ?C))'
		description:
			'Does the predicate subclassOf/2 fail for the rootclasses as subclass?'.
	self processQuery: ' if succeeds(?C isSubclassOf: [TestClass1])'
		description: 'Does TestClass1 have at least one subclass?'.
	self processQuery: ' if succeeds(one(?C isSubclassOf: ?S))' description:
			'Can the predicate subclassOf/2 be used with two arguments unbound?'