classes
testClassInheritsFrom2
	
	self
		processQuery: ' if ?SubClass classInheritsFrom: [TestClass1]'
		resultsCheck: [:results | results size = 2]
		description: 'Are there two classes in the hierarchy of TestClass1'.
	self processQuery:
			' if fails([TestClass1] classInheritsFrom: [TestClass1])' description:
			'Does TestClass1 belong to its own hierarchy?'.
	self processQuery:
			' if succeeds([SubClass1] classInheritsFrom: [TestClass1])' description:
			'Does SubClass1 belong to the hierarchy of TestClass1?'.
	self processQuery:
			' if succeeds([SubClass2] classInheritsFrom: [TestClass1])' description:
			'Does SubClass2 belong to the hierarchy of TestClass1?'.
	self
		processQuery: ' if ?SubClass classInheritsFrom: [TestClass2]'
		resultsCheck: [:results | results size = 0]
		description: 'There is no class inheriting from TestClass2'.
	self processQuery:
			' if fails([TestClass2] classInheritsFrom: [TestClass2])' description:
			'Does TestClass2 belong to its own hierarchy?'.
	self
		processQuery: ' if [SubClass1] classInheritsFrom: ?Root'
		resultsCheck: [:results | results size >= 2]
		description:
			'Are there at least two classes above SubClass1 (including SubClass1 itself)?'.
	self processQuery: ' if succeeds(one(?SubClass classInheritsFrom: ?Root))'
		description: 'Does classInheritsFrom:/2 work with two unbound arguments?'