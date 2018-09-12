classes
testIsClassInHierarchyOf2
	
	self
		processQuery: ' if ?SubClass isClassInHierarchyOf: [TestClass1]'
		resultsCheck: [:results | results size = 3]
		description:
			'Are there three classes in the hierarchy of TestClass1 (i.e. TestClass1 itself and two subclasses?'.
	self processQuery:
			' if succeeds([TestClass1] isClassInHierarchyOf: [TestClass1])'
		description: 'Does TestClass1 belong to its own hierarchy?'.
	self processQuery:
			' if succeeds([SubClass1] isClassInHierarchyOf: [TestClass1])'
		description: 'Does SubClass1 belong to the hierarchy of TestClass1?'.
	self processQuery:
			' if succeeds([SubClass2] isClassInHierarchyOf: [TestClass1])'
		description: 'Does SubClass2 belong to the hierarchy of TestClass1?'.
	self
		processQuery: ' if ?SubClass isClassInHierarchyOf: [TestClass2]'
		resultsCheck: [:results | results size = 1]
		description:
			'Is there one class in the hierarchy of TestClass2 (i.e. only TestClass2 itself)'.
	self processQuery:
			' if succeeds([TestClass2] isClassInHierarchyOf: [TestClass2])'
		description: 'Does TestClass2 belong to its own hierarchy?'.
	self processQuery:
			' if fails(and(?SubClass isClassInHierarchyOf: [TestClass2],not(?SubClass equals: [TestClass2])))'
		description: 'Does TestClass2 only contain itself in its hierarchy?'.
	self
		processQuery: ' if [SubClass1] isClassInHierarchyOf: ?Root'
		resultsCheck: [:results | results size >= 3]
		description:
			'Are there at least three classes above SubClass1 (including SubClass1 itself)?'.
	self processQuery:
			' if succeeds(one(?SubClass isClassInHierarchyOf: ?Root))' description:
			'Does isClassInHierarchyOf:/2 work with two unbound arguments?'