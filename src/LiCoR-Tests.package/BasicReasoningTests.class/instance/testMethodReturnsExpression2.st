method body
testMethodReturnsExpression2
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?Method methodReturnsExpression: ?Exp))'
		description: 'This method has a single non-return, statement.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodReturnsExpression: ?Exp))'
		description: 'This method has a return statement.'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodReturnsExpression: ?Exp))'
		description: 'This method has no statements.'.
	self
		processQuery:
			' if ?Method isMethodWithName: [#complexWith:and:and:and:] inClass: [TestClassRoot],?Method methodReturnsExpression: ?Exp'
		resultsCheck: [:result | result size = 5]
		description: 'This method has multiple returns.'