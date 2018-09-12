binary relations
testIsMetaClassOf2
	
	self processQuery:
			' if succeeds([TestClass1 class] isMetaClassOf: [TestClass1])'
		description:
			'Is <Soul.SoulTests.TestClass1 class> the meta class of Soul.SoulTests.TestClass1?'.
	self processQuery:
			' if succeeds([TestClass1 class class] isMetaClassOf: [TestClass1 class])'
		description:
			'Is <Soul.SoulTests.TestClass1 class class> the meta class of Soul.SoulTests.TestClass1 class?'.
	self processQuery:
			' if succeeds(forall([TestClass1 class] isMetaClassOf: ?C,equals(?C,[TestClass1])))'
		description:
			'Is <Soul.SoulTests.TestClass1 class> the only meta class of Soul.SoulTests.TestClass1?'.
	self processQuery:
			' if succeeds(forall(?M isMetaClassOf: [TestClass1],equals(?M,[TestClass1 class])))'
		description:
			'Is Collection the only base class of <Soul.SoulTests.TestClass1 class>?'