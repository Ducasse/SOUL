method body
testMethodWithUniqueStatement2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?Method methodWithUniqueStatement: RBMessageNode(RBMessageNode(RBVariableNode(self),methodWithAssignment,<>),first,<>)))'
		description: 'This method has a single statement.'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodWithUniqueStatement: ?Statement))'
		description: 'This method has multiple statements'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodWithUniqueStatement: ?Statement))'
		description: 'This method has no statements.'