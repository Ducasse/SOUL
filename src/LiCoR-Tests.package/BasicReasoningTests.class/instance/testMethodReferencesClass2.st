method body
testMethodReferencesClass2
	
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: foo inClass: [TestClass4],?Method methodReferencesClass: [Array]))'
		description: 'Verify that this method refers to the class Array.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: fooFullReference inClass: [TestClass4],?Method methodReferencesClass: [Array]))'
		description:
			'Verify that this method refers to the class Array (now with full reference).'.
	self processQuery:
			' if ?Method isMethodWithName: bar inClass: [TestClass4],fails(?Method methodReferencesClass: [Array])'
		description: 'Verify that this method does not refer to the class Array.'.
	self processQuery:
			' if succeeds(and(?Method isMethodWithName: bar inClass: [TestClass4],?Method methodReferencesClass: [Set]))'
		description: 'Verify that this method refers to the class Set.'.
	self
		processQuery:
			' if ?Method isMethodWithName: zork inClass: [TestClass4],?Method methodReferencesClass: ?Class'
		resultsCheck: [:results | results size = 3]
		description: 'Verify that this method refers to 3 classes.'.
	self processQuery:
			' if fails(and(?method isMethodWithName: method6 inClass: [TestClass5],?method methodReferencesClass: ?class))'
		description:
			'Verify that TestClass1>>method6 does not reference any class, even though it uses the global variable ThisIsAGlobalVariableThatDoesNotReferenceAClass'.
	self processQuery: ' if fails(foo methodReferencesClass: zork)'
		description:
			'Does the methodReferencesClass predicate handles bad information gracefully?'