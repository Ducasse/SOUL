methods
testIsMethodInProtocol
	
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInProtocol: ?Protocol))'
		description:
			'Can the predicate isMethodInProtocol:/2 be used with the second argument variable?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInProtocol: ?Protocol,?Protocol equals: [#protocol1]))'
		description:
			'Can the predicate isMethodInProtocol:/2 be used with the second argument variable?'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClass: [TestClass1],?Method isMethodInProtocol: protocol1))'
		description:
			'Can the predicate isMethodInProtocol:/2 be used with the second argument bound?'