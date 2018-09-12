method body
testMethodReadsInstanceVariableInClass3
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: [#array] inClass: [TestClass1],?Method methodReadsInstanceVariable: array inClass: [TestClass1]))'
		description: 'This method reads the instance variable array'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: [#sumWith:] inClass: [TestClass1],?Method methodReadsInstanceVariable: anInteger inClass: [TestClass1]))'
		description: 'anInteger is an argument'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: [#withShadowing] inClass: [TestClass1],?Method methodReadsInstanceVariable: array inClass: [TestClass1]))'
		description: 'array is shadowed'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: [#array:] inClass: [TestClass1],?Method methodReadsInstanceVariable: array inClass: [TestClass1]))'
		description: 'array is written to; not read'