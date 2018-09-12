entities
testIsClass1
	
	self processQuery: ' if succeeds([TestClass1] isClass)' description:
			'Is TestClass1 a class?'.
	self processQuery: ' if fails(1 isClass)' description:
			'Does isClass fail on an expression that is not a class?'.
	self processQuery: ' if succeeds([TestClass1 class] isClass)' description:
			'Is the meta class of TestClass1 a class?'