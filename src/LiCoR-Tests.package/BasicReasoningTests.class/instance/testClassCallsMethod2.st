classes
testClassCallsMethod2
	
	self processQuery:
			' if succeeds(and(?M isMethodWithName: methodWithAssignment inClass: [TestClassRoot],[TestClassRoot] classCallsMethod: ?M))'
		description:
			'Verify that this class calls a method named methodWithAssignment'