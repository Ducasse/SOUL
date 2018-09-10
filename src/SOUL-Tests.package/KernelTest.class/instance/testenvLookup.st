natives
testenvLookup
	
	self processQuery:
			' if envLookup(?var,?result),equals([?result term],?var),equals([?result envIndex],1)'
		description:
			'Does envLookup return the termApp object for a variable correctly?'.
	self processQuery:
			' if envLookup(const,?result),equals([?result term name],const),equals([?result envIndex],1)'
		description:
			'Does envLookup return the termApp object for a constant correctly?'