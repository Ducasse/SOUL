method body
testIsStatementOfMethod2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],RBMessageNode(RBMessageNode(RBVariableNode(self),methodWithAssignment,<>),first,<>) isStatementOfMethod: ?Method))'
		description: 'This method has a single statement.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],RBReturnNode(?) isStatementOfMethod: ?Method))'
		description: 'This method has a return statement.'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Statement isStatementOfMethod: ?Method))'
		description: 'This method has no statements.'