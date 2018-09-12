methods
testMethodOverridesMethod2
	
	self processQuery:
			' if succeeds(and(?m1 isMethodWithName: foo inClass: [TestClass4],?m2 isMethodWithName: foo inClass: [TestClassRoot],?m1 methodOverridesMethod: ?m2))'
		description: 'Both arguments bound; success'.
	self processQuery:
			' if succeeds(and(?m1 isMethodWithName: foo inClass: [SubClass1],?m2 isMethodWithName: foo inClass: [TestClassRoot],?m1 methodOverridesMethod: ?m2))'
		description: 'Both arguments bound; indirect inheritance; success'.
	self processQuery:
			' if fails(and(?m1 isMethodWithName: foo inClass: [TestClass4],?m2 isMethodWithName: foo inClass: [TestClassRoot],?m2 methodOverridesMethod: ?m1))'
		description: 'Both arguments bound; failure'.
	self processQuery:
			' if succeeds(and(?m1 isMethodWithName: foo inClass: [TestClass4],?m1 methodOverridesMethod: ?m2,?m2 isMethodWithName: foo inClass: [TestClassRoot]))'
		description: 'First argument bound; success'.
	self processQuery:
			' if succeeds(and(?m2 isMethodWithName: foo inClass: [TestClassRoot],?m1 methodOverridesMethod: ?m2,?m1 isMethodWithName: foo inClass: [TestClass4]))'
		description: 'Second argument bound; success'