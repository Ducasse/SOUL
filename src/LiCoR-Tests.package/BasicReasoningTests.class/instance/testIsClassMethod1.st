methods
testIsClassMethod1
	
	self processQuery:
			' if succeeds(and(?method isMethodWithName: aClassMethod inClass: [TestClassRoot class],?method isClassMethod))'
		description:
			'checks whether Soul.TestClassRoot class>>aClassMethod is a class method'.
	self processQuery:
			' if fails(and(?method isMethodWithName: aMethod1 inClass: [TestClass3],?method isClassMethod))'
		description: 'checks whether Soul.TestClass3>>aMethod1 is a class method'