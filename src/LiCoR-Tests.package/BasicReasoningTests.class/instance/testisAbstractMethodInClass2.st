methods
testisAbstractMethodInClass2
	
	self processQuery:
			' if succeeds(and(?method isAbstractMethodInClass: [TestClass3],?method isMethodWithName: anAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anAbstractMethod is an abstract method'.
	self processQuery:
			' if succeeds(and(?method isAbstractMethodInClass: [TestClass3],?method isMethodWithName: anotherAbstractMethod))'
		description:
			'checks whether Soul.TestClass3>>anotherAbstractMethod is an abstract method'