entities
testIsPackage1
	
	self processQuery: ' if succeeds([Smalltalk organization categories first] isPackage)'
		description: 'Can we check for an existing package?'.
	self
		processQuery: ' if ?package isPackage'
		resultsCheck: [:results | results size = Smalltalk organization categories size]
		description: 'Can we enumerate all packages?'.
	self processQuery: ' if fails([''Soul''] isPackage)' description:
			'Does package fail for the string ''Soul''?'