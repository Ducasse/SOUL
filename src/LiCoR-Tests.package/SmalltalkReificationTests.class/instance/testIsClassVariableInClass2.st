binary relations
testIsClassVariableInClass2
	
	self processQuery: ' if fails(?IV isClassVariableInClass: [TestClass3])'
		description: 'Does TestClass3 have class variables => no?'.
	self processQuery:
			' if succeeds(?IV isClassVariableInClass: [TestClass1])' description:
			'Does TestClass1 have at least one instance variable?'.
	self processQuery:
			' if succeeds([#mcivar1] isClassVariableInClass: [TestClass1])'
		description: 'Does TestClass1 have an class variable named mcivar1?'.
	self processQuery:
			' if fails([#fooujhqdghjqdvsb] isClassVariableInClass: [TestClass1])'
		description:
			'Does TestClass1 have no class variable with this absurd name?'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInClass: ?C)' description:
			'Are there classes with class variable named mcivar1?'.
	self processQuery: ' if succeeds(?IV isClassVariableInClass: ?C)'
		description:
			'Can we use the predicate isClassVariableInClass/2 with two arguments unbound?'.
	self processQuery: ' if fails(1 isClassVariableInClass: [TestClass1])'
		description:
			'Does the predicate isClassVariableInClass/2 fail when a number is provided as variable name?'.
	self processQuery: ' if fails([#iv1] isClassVariableInClass: 1)'
		description:
			'Does the predicate isClassVariableInClass/2 fail when a number is provided as class name?'