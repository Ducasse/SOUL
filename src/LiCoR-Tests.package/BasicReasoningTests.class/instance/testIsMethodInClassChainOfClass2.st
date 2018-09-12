methods
testIsMethodInClassChainOfClass2
	
	self processQuery:
			' if succeeds(and(?Method isMethodInClassChainOfClass: [TestClass1],?Method isMethodWithName: array))'
		description: 'The class implements the method directly'.
	self processQuery:
			' if succeeds(and(?Method isMethodInClassChainOfClass: [TestClass1],?Method isMethodWithName: foo))'
		description: 'The class implements the method indirectly'.
	self processQuery:
			' if fails(and(?Method isMethodInClassChainOfClass: [TestClass1],?Method isMethodWithName: DOESNOTEXIST))'
		description: 'Method that does not exist'