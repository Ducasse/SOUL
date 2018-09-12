method attributes
testIsParseTreeOfMethod2
	
	self processQuery: ' if succeeds(one(?tree isParseTreeOfMethod: ?method))'
		description: 'We do find a parse tree of a method'.
	self processQuery:
			' if equals(?method,[(MLI current methodsInClass: TestClassRoot)
	detect: [:m | m selector = #doNotOverride]]),?tree isParseTreeOfMethod: ?method,succeeds([?tree isKindOf: RBMethodNode])'
		description: 'Can we find the parse tree of TestClassRoot>>doNotOverride'