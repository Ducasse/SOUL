testing
testCasesFromXSB
	
	SoulFactory resetSLGTables.
	self
		processQuery: ' if mutRetA(?X,?Y)'
		resultsCheck: [:results | results size = 8]
		description: 'mutual recursion'