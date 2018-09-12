methods
testIsMethodOfClassInProtocol
	
	self processQuery:
			' if succeeds(?Method isMethodInClass: [TestClass1] inProtocol: ?Protocol)'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find all methods and protocols in a given class?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInClass: ?Class inProtocol: ?Protocol))'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find the class and protocol of a given method?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInClass: ?Class inProtocol: ?Protocol,?Protocol equals: [#protocol1]))'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find the class and protocol of a given method?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInClass: ?Class inProtocol: protocol1))'
		description:
			'Can the predicate isMethodInClass:inProtocol:/3 be used to find the class and protocol of a given method?'