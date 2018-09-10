term type checking
testcompound
	"self run:#testcompound"

	
	self processQuery: ' if compound(woman(maria))' description:
			'A simple compound'.
	self processQuery: ' if compound(woman(?x))' description:
			'A compound with variables'.
	self processQuery: ' if compound(<a,b,c>)' description:
			'A lists is a compound'.
	self processQuery: ' if compound(<kim>)' description:
			'A cons-pair is also a compound'.
	self processQuery: ' if fails(compound(?X))' description:
			'A variable is not a compound'.
	self processQuery: ' if fails(compound(hallo))' description:
			'An atom is not a compound'.
	self processQuery: ' if fails(compound(<>))' description:
			'An empty list is not a compound'