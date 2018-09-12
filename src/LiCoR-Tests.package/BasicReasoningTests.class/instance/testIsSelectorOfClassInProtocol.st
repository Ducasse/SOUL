methods
testIsSelectorOfClassInProtocol
	
	self processQuery:
			' if succeeds(?Selector isSelectorOfClass: [TestClass1] inProtocol: ?Protocol)'
		description:
			'Can the predicate isSelectorOfClass:inProtocol:/3 be used to find all method names and protocols in a given class?'.
	self processQuery:
			' if succeeds([#method4] isSelectorOfClass: ?Class inProtocol: ?Protocol)'
		description:
			'Can the predicate isSelectorOfClass:inProtocol:/3 be used to find all classes and protocols that have a method with a given name?'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: ?Selector inClass: [TestClass1],?Selector isSelectorOfClass: ?Class inProtocol: ?Protocol,?Class equals: [TestClass1],?Protocol equals: [#protocol1]))'
		description:
			'Can the predicate isSelectorOfClass:inProtocol:/3 be used to find the class and protocol of a given selector?'