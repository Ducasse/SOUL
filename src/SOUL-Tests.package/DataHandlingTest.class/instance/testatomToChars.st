pattern matching
testatomToChars
	"self run:#testatomToChars"

	
	self processQuery: ' if succeeds(atomToChars(hello,?x))' description:
			'Generate a list of characters from a given atom'.
	self processQuery:
			' if succeeds(atomToChars(hello,<[#h],[#e],[#l],[#l],[#o]>))'
		description:
			'I dont understand why this one gives an error. There is something weird going on here...'.
	self processQuery: ' if succeeds(atomToChars([#hello],?x))' description:
			'Generate a list of characters from a given atom'.
	self processQuery:
			' if succeeds(atomToChars(hello,<[#h],[#e],[#l],[#l],[#o]>))'
		description: 'Does this also work when all arguments are bound?'.
	self processQuery: ' if fails(atomToChars(?atom,?x))' description:
			'Predicate fails when ?atom is not bound'.
	self processQuery:
			' if fails(atomToChars(?atom,<[#h],[#e],[#l],[#l],[#o]>))' description:
			'Predicate fails when ?atom is not bound'