entities
testIsBaseClass1
	
	self
		processQuery: ' if ?c isBaseClass'
		resultsCheck:
			[:results | results size = MLI current allBaseClassEntities size]
		description:
			'Is the number of returned base classes equal to what is expected?'.
	self processQuery: ' if succeeds([TestClass1] isBaseClass)' description:
			'Is TestClass1 a base class?'.
	self processQuery: ' if fails(1 isBaseClass)' description:
			'Does baseClass/1 fail for an expression that is not a base class?'.
	self processQuery: ' if fails([TestClass1 class] isBaseClass)'
		description: 'Is the meta class of TestClass1 NOT a base class?'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),forall(?C isBaseClass,not(?C isMetaClass))))'
		description:
			'Is no base class a meta class? (restricted to TestClassRoot hierarchy for performance reasons)'.
	self processQuery:
			' if succeeds(and(member(?C,[TestClassRoot allSubclasses]),forall(?C isBaseClass,?C isClass)))'
		description:
			'Is every base class a class? (restricted to TestClassRoot hierarchy for performance reasons)'