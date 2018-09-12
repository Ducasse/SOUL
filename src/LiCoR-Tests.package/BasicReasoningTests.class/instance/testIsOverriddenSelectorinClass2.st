methods
testIsOverriddenSelectorinClass2
	
	self processQuery:
			' if succeeds(foo isOverriddenSelectorInClass: [TestClass4])'
		description: 'foo is overridden'.
	self processQuery:
			' if fails(foo isOverriddenSelectorInClass: [TestClassRoot])'
		description: 'foo is not overridden'.
	self processQuery:
			' if fails(foobar isOverriddenSelectorInClass: [TestClass4])'
		description: 'selector does not exist'.
	self processQuery:
			' if succeeds(foo isOverriddenSelectorInClass: [SubClass1])'
		description: 'indirect (one class in the hierarchy in between) override'