method attributes
testIsSourceCodeOfMethod2
	
	self processQuery:
			' if succeeds(one(?code isSourceCodeOfMethod: ?method))' description:
			'We do find the source code of a method'.
	self processQuery:
			' if equals(?method,[(MLI current methodsInClass: TestClassRoot)
	detect: [:m | m selector = #doNotOverride]]),?code isSourceCodeOfMethod: ?method,succeeds([?code asString =
		(TestClassRoot>>#doNotOverride) getSource ])' description:
			'Can we find the source code of TestClassRoot>>doNotOverride'