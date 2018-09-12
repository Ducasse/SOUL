method body
testAreStatementsOfMethod2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],<?statement> areStatementsOfMethod: ?Method))'
		description: 'This method has a single statement.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?statements areStatementsOfMethod: ?Method,length(?statements,2)))'
		description: 'This method has two statements.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [SubClass1],<> areStatementsOfMethod: ?Method))'
		description: 'This method has no statements.'