methods
testIsAbstractMethod1
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: anAbstractMethod inClass: [TestClass3],?method isAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anAbstractMethod is an abstract method'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: anotherAbstractMethod inClass: [TestClass3],?method isAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anotherAbstractMethod is an abstract method'.
	self processQuery:
			' if fails(and(?method isMethodWithName: aMethod1 inClass: [TestClass3],?method isAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>aMethod1 is an abstract method'