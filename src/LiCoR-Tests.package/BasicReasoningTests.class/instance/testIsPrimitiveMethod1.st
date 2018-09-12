methods
testIsPrimitiveMethod1
	
	self processQuery:
			' if fails(and(?method isMethodWithName: anAbstractMethod inClass: [TestClass3],?method isPrimitiveMethod))'
		description:
			'checks that Soul.TestClass3>>anAbstractMethod is not a primitive method'.
	self processQuery:
			' if succeeds(and(?method isMethodWithName: [#==] inClass: [ProtoObject],?method isPrimitiveMethod))'
		description: 'checks that Object>>== is a primitive method'