method body
testMethodReturnsBoolean2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: isNode inClass: [Node],?Method methodReturnsBoolean: [true]))'
		description: 'This method return true'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: isNode inClass: [Tree],?Method methodReturnsBoolean: [false]))'
		description: 'This method return false'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodReturnsBoolean: ?))'
		description: 'This method returns a complex statement'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [SubClass1],?Method methodReturnsBoolean: ?))'
		description: 'This method does not return anything'