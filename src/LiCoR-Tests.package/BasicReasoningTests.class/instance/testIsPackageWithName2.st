naming
testIsPackageWithName2
	
	self processQuery:
			' if succeeds(and(?Package isPackageWithName: ?Name,nonvar(?Package),nonvar(?Name)))'
		description: 'Can we use packageWithName/2 with two arguments unbound?'.
	self processQuery:
			' if succeeds(and(?Package isPackageWithName: [''LiCoR-Tests''],nonvar(?Package)))'
		description: 'Can we find the package with a given name?'.
	self processQuery:
			' if succeeds(and([''LiCoR-Tests''] isPackageWithName: ?Name,nonvar(?Name),?Name equals: [''LiCoR-Tests'']))'
		description:
			'Can we find the name of an existing package, and is it the correct one?'