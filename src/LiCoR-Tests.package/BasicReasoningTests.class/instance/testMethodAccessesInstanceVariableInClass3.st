method body
testMethodAccessesInstanceVariableInClass3
	
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodAccessesInstanceVariable: newString inClass: ?Class))'
		description:
			'This method assigns to the local variable newString; not to an instance variable'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodAccessesInstanceVariable: array inClass: ?Class))'
		description: 'This method assigns to the instance variable array'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array] inClass: [TestClass1],?Method methodAccessesInstanceVariable: array inClass: [TestClass1]))'
		description: 'This method reads the instance variable array'