binary relations
testIsInstanceVariableInMetaClassChainOf2
	"self run: #testinstanceVariableInMetaClassChain2"

	
	self processQuery:
			' if succeeds(one(and(?V isInstanceVariableInMetaClassChainOf: ?C,nonvar(?V),nonvar(?C))))'
		description: 'Can we find solutions?'.
	self processQuery:
			' if succeeds(and(?V isInstanceVariableInMetaClassChainOf: [SubClass1 class],nonvar(?V)))'
		description:
			'Does the meta class of SubClass1 have at least one instance variable (either directly or indirectly)?'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInMetaClassChainOf: [TestClass1 class])'
		description:
			'Does the meta class of TestClass1 have an instance variable mcivar1 (either directly or indirectly)? (This is the trivial case because the meta class of TestClass1 itself declares the instance variable.'.
	self processQuery:
			' if succeeds([#mcivar1] isInstanceVariableInMetaClassChainOf: [SubClass1 class])'
		description:
			'Does the meta class of SubClass1, which does not declare any instance variables, indirectly have an instance variable mcivar1?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClassChainOf: ?C,nonvar(?C)))'
		description:
			'Can we find a class of which the meta class has an instance variable mcivar1 (either directly or indirectly)?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClassChainOf: ?C,nonvar(?C),?C equals: [TestClass1 class]))'
		description:
			'Can we find a class of which the meta class (directlty or indirectly) has an instance variable mcivar1 (either directly or indirectly), and is TestClass1 one of the returned results?'.
	self processQuery:
			' if succeeds(and([#mcivar1] isInstanceVariableInMetaClassChainOf: ?C,nonvar(?C),?C equals: [SubClass1 class]))'
		description:
			'Can we find a class of which the meta class (directlty or indirectly) has an instance variable mcivar1 (either directly or indirectly), and is SubClass1 one of the returned results?'