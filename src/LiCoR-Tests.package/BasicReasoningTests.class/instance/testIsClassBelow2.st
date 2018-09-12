classes
testIsClassBelow2
	
	self
		processQuery: ' if ?SubClass isClassBelow: [TestClass1]'
		resultsCheck: [:results | results size = 2]
		description:
			'Are there three classes in the hierarchy BELOW TestClass1 (i.e. all descendants of TestClass1 excluding itself.'.
	self
		processQuery: ' if ?SubClass isClassBelow: [TestClass3]'
		resultsCheck: [:results | results size = 3]
		description: 'Are there three classes in the hierarchy BELOW TestClass3'.
	self processQuery: ' if fails([TestClass1] isClassBelow: [TestClass1])'
		description: 'A class not be below itself.'.
	self processQuery: ' if succeeds([SubClass1] isClassBelow: [TestClass1])'
		description: 'Is SubClass1 in the hierarchy below TestClass1?'.
	self processQuery: ' if succeeds([SubClass2] isClassBelow: [TestClass1])'
		description: 'Is SubClass2 in the hierarchy below TestClass1?'.
	self processQuery: ' if fails(?SubClass isClassBelow: [TestClass2])'
		description: 'There no classes in the hierarchy BELOW TestClass2.'.
	self
		processQuery: ' if [SubClass1] isClassBelow: ?Root'
		resultsCheck: [:results | results size >= 3]
		description:
			'Are there at least three classes ABOVE SubClass1 (excluding SubClass1 itself)?'.
	self processQuery: ' if succeeds(?SubClass isClassBelow: ?Root)'
		description: 'Does classBelow/2 work with two unbound arguments?'.
	