entities
testIsClassCategory1
	
	self processQuery: ' if succeeds(?Category isClassCategory)' description:
			'Can the predicate be used to extract categories?'.
	self processQuery: ' if succeeds([#''Kernel-Objects''] isClassCategory)'
		description: 'Is Kernel-Objects an existing class category?'