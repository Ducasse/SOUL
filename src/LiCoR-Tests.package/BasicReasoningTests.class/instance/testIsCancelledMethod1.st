methods
testIsCancelledMethod1
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: anUnimplementedMethod inClass: [TestClass3],?method isCancelledMethod))'
		description:
			'checks whether Soul.TestClass3>>anUnimplementedMethod is an abstract method'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: ? inClass: [TestClass3],?method isCancelledMethod))'
		description: 'Can we find cancelled methods in class TestClass3?'