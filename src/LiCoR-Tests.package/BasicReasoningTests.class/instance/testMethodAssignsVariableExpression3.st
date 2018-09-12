method body
testMethodAssignsVariableExpression3
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodAssignsVariable: newString expression: RBMessageNode(RBVariableNode(self),copy,<>)))'
		description: 'This method assigns to the local variable newString'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodAssignsVariable: ? expression: ?))'
		description: 'This method does not do any assignments'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodAssignsVariable: array expression: RBVariableNode(anArray)))'
		description: 'This method assigns to the instance variable array'