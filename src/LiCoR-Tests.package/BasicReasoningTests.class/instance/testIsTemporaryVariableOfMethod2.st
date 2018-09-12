method body
testIsTemporaryVariableOfMethod2
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: method4 inClass: [TestClass1],?V isTemporaryVariableOfMethod: ?Method))'
		description: 'This method has no temporary variables'.
	self
		processQuery:
			' if ?Method isMethodWithName: commentedMethod3 inClass: [TestClass5],?V isTemporaryVariableOfMethod: ?Method'
		resultsCheck: [:result | result size = 2]
		description: 'This method has two temporary variables'