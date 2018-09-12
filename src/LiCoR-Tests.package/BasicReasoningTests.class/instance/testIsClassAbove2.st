classes
testIsClassAbove2
	
	self processQuery: ' if fails([TestClass1] isClassAbove: [TestClass1])'
		description: 'A class not be above itself.'.
	self processQuery: ' if fails([SubClass1] isClassAbove: [TestClass1])'
		description: 'Is SubClass1 not in the hierarchy above TestClass1?'.
	self processQuery: ' if [TestClass1] isClassAbove: [SubClass1]'
		description: 'Is TestClass1 in the hierarchy above SubClass1?'.
	self processQuery:
			' if fails(and(?root isRootClass,?SuperClass isClassAbove: ?root))'
		description: 'There are no classes above a root class.'.
	self processQuery: ' if succeeds(?SuperClass isClassAbove: ?Class)'
		description: 'Does isClassAbove:/2 work with two unbound arguments?'