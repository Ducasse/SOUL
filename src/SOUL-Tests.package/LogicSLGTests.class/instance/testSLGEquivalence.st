testing
testSLGEquivalence
	
	SoulFactory resetSLGTables.
	self
		processQuery: ' if shortpath(?X,?X)'
		resultsCheck:
			[:results | (results resultsForVariableNamed: 'X') size = 4]
		description: 'test all cyclic paths'.
	self
		processQuery: ' if shortpath(?X,?Y)'
		resultsCheck:
			[:results | (results resultsForVariableNamed: 'X') size = 16]
		description:
			'test that this call does not returns the results from ?X,?X'