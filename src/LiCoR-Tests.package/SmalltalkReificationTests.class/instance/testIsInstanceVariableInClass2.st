binary relations
testIsInstanceVariableInClass2
	
	self processQuery:
			' if fails(?IV isInstanceVariableInClass: [TestClass3])' description:
			'Does TestClass3 have no instance variables?'.
	self processQuery:
			' if succeeds(?IV isInstanceVariableInClass: [TestClass1])' description:
			'Does TestClass1 have at least one instance variable?'.
	self processQuery:
			' if succeeds([#iv1] isInstanceVariableInClass: [TestClass1])'
		description: 'Does TestClass1 have an instance variable named iv1?'.
	self processQuery:
			' if fails([#fooujhqdghjqdvsb] isInstanceVariableInClass: [TestClass1])'
		description:
			'Does TestClass1 have no instance variable with this absurd name?'.
	self processQuery: ' if succeeds([#iv1] isInstanceVariableInClass: ?C)'
		description:
			'Can we use the predicate instanceVariableInClass/2 to extract classes with a give instance variable name?'.
	self processQuery: ' if succeeds(?IV isInstanceVariableInClass: ?C)'
		description:
			'Can we use the predicate instanceVariableInClass/2 with two arguments unbound?'.
	self processQuery: ' if fails(1 isInstanceVariableInClass: [TestClass1])'
		description:
			'Does the predicate instanceVariableInClass/2 fail when a number is provided as variable name?'.
	self processQuery: ' if fails([#iv1] isInstanceVariableInClass: 1)'
		description:
			'Does the predicate instanceVariableInClass/2 fail when a number is provided as class name?'