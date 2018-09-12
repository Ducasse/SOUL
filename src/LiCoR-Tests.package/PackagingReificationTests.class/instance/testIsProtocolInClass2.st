binary relations
testIsProtocolInClass2
	
	self processQuery:
			' if succeeds(and(?Protocol isProtocolInClass: ?Class,nonvar(?Protocol),nonvar(?Class)))'
		description:
			'Can the predicate isProtocolInClass:/2 be used to find all protocols of all classes?'.
	self processQuery:
			' if succeeds(and(?Protocol isProtocolInClass: ?Class,?Protocol isProtocol,?Class isClass))'
		description:
			'Is the result produced by the predicate isProtocolInClass:/2 of the expected type?'.
	self processQuery:
			' if succeeds([#protocol1] isProtocolInClass: [TestClass1])'
		description:
			'Can the predicate isProtocolInClass:/2 be used to check that a given protocol belongs to a given class?'.
	self processQuery: ' if succeeds([#protocol1] isProtocolInClass: ?Class)'
		description:
			'Can the predicate isProtocolInClass:/2 be used to find all classes with a given protocol?'.
	self
		processQuery: ' if ?protocol isProtocolInClass: [TestClass1]'
		resultsCheck: [:results | results size = 3]
		description: 'Can we ask for the protocols that are in a class?'.
	self processQuery: ' if fails(?protocol isProtocolInClass: foo)'
		description:
			'Does this predicate fail when given the wrong kind of parameters?'.
	self processQuery: ' if fails(theprotocolthatshouldnotexist isProtocolInClass: ?class)' description:
			'Does this predicate fail when given the wrong kind of parameters?'.
	self processQuery: ' if fails(foo isProtocolInClass: foo)' description:
			'Does this predicate fail when given the wrong kind of parameters?'