entities
testIsInstanceVariable1
	
	self processQuery: ' if succeeds([#iv1] isInstanceVariable)' description:
			'Does an instance variable with this name exist?'.
	self processQuery: ' if fails([#fooujhqdghjqdvsb] isInstanceVariable)'
		description: 'Does no instance variable with this name exist?'.
	self processQuery: ' if succeeds(one(?IV isInstanceVariable))'
		description:
			'Can the predicate be used to extract instance variable names?'.
	self processQuery: ' if fails([#mcivar1] isInstanceVariable)' description:
			'Is mcivar1 not an instance variable? (It is a class variable.)'