entities
testIsRootClass1
	
	self processQuery: ' if succeeds(?X isRootClass)' description:
			'Is there at least one root class?'.
	self processQuery: ' if fails([TestClass1] isRootClass)' description:
			'isRootClass is supposed to fail on a non rootclass'