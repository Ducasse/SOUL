visiting terms
variableVisit: aVariable
	
	dictionary
		at: aVariable name
		ifAbsentPut:
			[counter := counter + 1.
			counter].
	aVariable setAddress: (dictionary at: aVariable name)