entities
testIsMetaClass1
	
	self
		processQuery: ' if ?C isMetaClass'
		resultsCheck:
			[:results | results size = MLI current allMetaClassEntities size]
		description: 'There are as many meta classes as expected'.
	self processQuery: ' if succeeds([TestClass1 class] isMetaClass)'
		description: 'Is <Soul.SoulTests.TestClass1 class> a meta class?'.
	self processQuery: ' if fails([TestClass1] isMetaClass)' description:
			'Is Soul.SoulTests.TestClass1 NOT a meta class?'.
	self processQuery: ' if fails(1 isMetaClass)' description:
			'Is a number NOT a meta class?'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),equals(?MC,[?C class]),forall(?MC isMetaClass,not(?MC isBaseClass))))'
		description:
			'Is no meta class a base class? (restricted to the hierarchy of TestClassRoot for performance reasons)'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),equals(?MC,[?C class]),forall(?MC isMetaClass,?MC isClass)))'
		description:
			'Is every meta class a class? (restricted to the hierarchy of TestClassRoot for performance reasons)'