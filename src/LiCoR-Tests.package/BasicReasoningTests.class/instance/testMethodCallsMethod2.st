method body
testMethodCallsMethod2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?Method methodCallsMethod: ?M2,?M2 isMethodWithName: methodWithAssignment,!))'
		description:
			'Verify that this method calls a method named methodWithAssignment'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: methodWithSend inClass: [TestClassRoot],?M isMethodWithName: methodWithAssignment inClass: [TestClassRoot],?Method methodCallsMethod: ?M2))'
		description:
			'Verify that this method calls a method named methodWithAssignment'