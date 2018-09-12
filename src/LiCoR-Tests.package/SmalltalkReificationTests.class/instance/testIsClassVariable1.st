entities
testIsClassVariable1
	
	self processQuery: ' if fails([#fooujhqdghjqdvsb] isClassVariable)'
		description: 'Does no class variable with this name exist?'.
	self processQuery: ' if succeeds(?V isClassVariable)' description:
			'Can the predicate be used to extract instance variable names?'.
	self processQuery: ' if succeeds(one([#mcivar1] isClassVariable))'
		description: 'Does a class variable with this name exist?'.
	self processQuery: ' if fails([#iv1] isClassVariable)' description:
			'Is iv1 not a class variable? (It is an instance variable.)'