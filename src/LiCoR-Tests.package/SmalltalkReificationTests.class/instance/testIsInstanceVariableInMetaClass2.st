binary relations
testIsInstanceVariableInMetaClass2
	
	self processQuery:
			' if succeeds(one(and(?V isInstanceVariableInMetaClass: ?C,nonvar(?V),nonvar(?C))))'
		description:
			'Does isInstanceVariable:InMetaClass:/2 work with two variables?'.
	self processQuery:
			' if succeeds(and(?V isInstanceVariableInMetaClass: [TestClass1 class],nonvar(?V)))'
		description:
			'Does the meta class of TestClass1 have at least one instance variable?'.
	self processQuery:
			' if fails(?V isInstanceVariableInMetaClass: [TestClass3 class])'
		description:
			'Does the meta class of TestClass3 have no instance variables?'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInMetaClass: [TestClass1 class])'
		description:
			'Does the meta class of TestClass1 have an instance variable mcivar1?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClass: ?C,nonvar(?C)))'
		description:
			'Can we find a class of which the meta class has an instance variable named mcivar1?'