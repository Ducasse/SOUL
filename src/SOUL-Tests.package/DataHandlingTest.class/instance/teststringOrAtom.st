pattern matching
teststringOrAtom
	"self run:#teststringOrAtom"

	
	self processQuery: ' if succeeds(stringOrAtom([''hallo'']))' description:
			'stringOrAtom succeeds when a string is given as input'.
	self processQuery: ' if succeeds(stringOrAtom(hallo))' description:
			'stringOrAtom succeeds when an atom is given as input'