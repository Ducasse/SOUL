binary relations
testIsMethodInClass2
	
	self
		processQuery:
			' if ?method isMethodInClass: [TestClass1],?method isMethod'
		resultsCheck: [:results | results size = 9]
		description:
			'Can we extract all methods from a class and are they all methods?'.
	self processQuery:
			' if one(?m isMethod),?m isMethodInClass: ?class,equals([?m fromClass],?class)'
		description: 'Can we extract the class from a method?'.
	self processQuery:
			' if one(?m isMethod),equals([?m fromClass],?class),?m isMethodInClass: ?class'
		description: 'Can we check a methodInClass relation?'.
	self processQuery: ' if succeeds(?method isMethodInClass: ?class)'
		description: 'Can we extract methodInClass relations?'.
	self processQuery:
			' if fails(and(?method isMethodInClass: [TestClass1],?method isMethodInClass: [AbstractTerm]))'
		description: 'Can we check if a method is not in class'.
	self processQuery:
			' if fails(and(foo isMethodInClass: ?class,?method isMethodInClass: foo,foo isMethodInClass: foo))'
		description:
			'Does methodInClass fail when given something else than a method or a class?'.
	self processQuery:
			' if one(?method1 isMethod),?method1 isMethodInClass: ?class,findall(?method2,?method2 isMethodInClass: ?class,?list),member(?method1,?list)'
		description:
			'Basic sanity test for methodInClass: all solutions when ?method is bound should also be solutions when ?method is unbound.'