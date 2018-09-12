binary relations
testIsInstanceVariableInClassChainOf2
	
	self processQuery:
			' if succeeds(and(?IV isInstanceVariableInClassChainOf: [TestClass1],nonvar(?IV)))'
		description:
			'Does TestClass1 have an instance variable in its class chain? (This is a trivial case as TestClass1 implements instance variables itself.)'.
	self processQuery:
			' if succeeds(and(?IV isInstanceVariableInClassChainOf: [SubClass1],nonvar(?IV)))'
		description:
			'Does SubClass1, which does not declare any instance variables itself, indirectly has an instance variable?'.
	self processQuery:
			' if fails(?IV isInstanceVariableInClassChainOf: [TestClass3])'
		description:
			'Does TestClass3, nor any of its superclasses declare instance variables?'.
	self processQuery:
			' if succeeds([#iv2] isInstanceVariableInClassChainOf: [TestClass1])'
		description:
			'Does TestClass1 have the instance variable iv2 in its class chain? (This is a trivial case as TestClass1 implements the instance variable itself.)'.
	self processQuery:
			' if succeeds([#iv2] isInstanceVariableInClassChainOf: [SubClass2])'
		description:
			'Does SubClass2, which does not declare any instance variables itself, indirectly has an instance variable iv2?'.
	self processQuery:
			' if fails([#fooujhqdghjqdvsb] isInstanceVariableInClassChainOf: [SubClass2])'
		description:
			'Does Subclass2 have no (direct or indirect) instance variable fooujhqdghjqdvsb?'.
	self processQuery:
			' if succeeds(and([#array] isInstanceVariableInClassChainOf: ?C,nonvar(?C)))'
		description:
			'Can we use the predicate to extract classes that (directly or indirectly) have a given instance variable name?'.
	self processQuery:
			' if succeeds(and([#iv2] isInstanceVariableInClassChainOf: ?C,nonvar(?C),equals(?C,[TestClass1])))'
		description:
			'When using instanceVariableInClassChain/2 with the class unbound, does it return the class that (directly) declares the instance variable?'.
	self processQuery:
			' if succeeds(and([#iv2] isInstanceVariableInClassChainOf: ?C,nonvar(?C),equals(?C,[SubClass2])))'
		description:
			'When using instanceVariableInClassChain/2 with the class unbound, can it return a classes that indirectly has the instance variable?'.
	self processQuery:
			' if succeeds(and(?IV isInstanceVariableInClassChainOf: ?C,nonvar(?IV),nonvar(?C)))'
		description: 'Can we use the predicate with two arguments unbound?'