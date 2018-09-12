methods
testAreArgumentsOfMethod2
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: array inClass: [TestClass1],<> areArgumentsOfMethod: ?method))'
		description: 'checks whether Soul.TestClass1>>array has no arguments'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: [#array:] inClass: [TestClass1],<RBVariableNode(anArray)> areArgumentsOfMethod: ?method))'
		description:
			'checks whether Soul.TestClass1>>array: has a single argument called anArray'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: [#complexWith:and:and:and:] inClass: [TestClassRoot],<RBVariableNode(modifiers),RBVariableNode(bindings),RBVariableNode(specificImports),RBVariableNode(generalImports)> areArgumentsOfMethod: ?method))'
		description:
			'checks whether Soul.TestClassRoot>>complexWith:and:and:and: has a four arguments'