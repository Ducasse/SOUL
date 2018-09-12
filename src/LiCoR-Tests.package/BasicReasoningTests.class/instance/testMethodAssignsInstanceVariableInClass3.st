method body
testMethodAssignsInstanceVariableInClass3
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodAssignsInstanceVariable: newString inClass: ?Class))'
		description:
			'This method assigns to the local variable newString; not to an instance variable'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodAssignsInstanceVariable: newString inClass: ?Class))'
		description: 'This method does not do any assignments'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodAssignsInstanceVariable: array inClass: ?Class))'
		description: 'This method assigns to the instance variable array'