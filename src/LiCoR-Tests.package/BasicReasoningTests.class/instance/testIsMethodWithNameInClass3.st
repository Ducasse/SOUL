naming
testIsMethodWithNameInClass3
	
	self
		processQuery:
			' if ?Method isMethodWithName: ?Selector inClass: [TestClass1]'
		resultsCheck: [:results | results size = 9]
		description:
			'Can the predicate be used with the first two arguments variable?'.
	self
		processQuery:
			' if ?Method isMethodWithName: [#method1] inClass: [TestClass1]'
		resultsCheck: [:results | results size = 1]
		description:
			'Can we use the predicate to find a method with a given name in a given class?'.
	self
		processQuery:
			' if ?Method isMethodInClass: [TestClass1],?Method isMethodWithName: ?Selector inClass: ?Class,?Class equals: [TestClass1],nonvar(?Selector)'
		resultsCheck: [:results | results size = 9]
		description:
			'Can we use the predicate to find the class and name of a given method?'