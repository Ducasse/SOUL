entities
testIsProtocol1
	
	self processQuery: ' if succeeds(?Protocol isProtocol)' description:
			'Can the predicate be used to extract protocols?'.
	self processQuery: ' if succeeds([#accessing] isProtocol)' description:
			'Is accessing an existing method protocol?'