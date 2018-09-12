method body
testMethodSendsSelector2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodSendsSelector: zork))'
		description: 'Verify that this method sends message #zork'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodSendsSelector: copy))'
		description: 'Verify that this method sends message #copy'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: foo inClass: [TestClassRoot],?Method methodSendsSelector: HIGHLYUNLIKELY))'
		description:
			'Verify that this method does not send message #HIGHLYUNLIKELY'.
	self processQuery:
			' if fails(and(?Method isMethodWithName: methodWithSimpleReturn inClass: [TestClassRoot],?Method methodSendsSelector: ?s))'
		description: 'Verify that this method does not send any messages'