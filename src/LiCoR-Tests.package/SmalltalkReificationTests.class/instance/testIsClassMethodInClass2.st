binary relations
testIsClassMethodInClass2
	
	self
		processQuery:
			' if ?method isClassMethodInClass: [TestClass1],?method isMethod'
		resultsCheck: [:results | results size = 2]
		description:
			'Can we extract all class methods from a class and are they all methods?'.
	self processQuery:
			' if ?m isMethod,?m isClassMethodInClass: ?class,!,equals([?m fromClass],[?class class])'
		description: 'Can we extract the class from a class method?'.
	self processQuery: ' if succeeds(?method isClassMethodInClass: ?class)'
		description: 'Can we extract classMethodInClass relations?'.
	self processQuery:
			' if fails(and(?method isClassMethodInClass: [TestClass1],?method isClassMethodInClass: [AbstractTerm]))'
		description: 'Can we check if a method is not in class'.
	self processQuery:
			' if fails(and(foo isClassMethodInClass: ?class,?method isClassMethodInClass: foo,foo isClassMethodInClass: foo))'
		description:
			'Does methodInClass fail when given something else than a method or a class?'.
	self processQuery:
			' if ?method1 isMethod,?method1 isClassMethodInClass: ?class,!,findall(?method2,?method2 isClassMethodInClass: ?class,?list),member(?method1,?list)'
		description:
			'Basic sanity test for classMethodInClass: all solutions when ?method is bound should also be solutions when ?method is unbound.'