list handling
testintersectionLists
	"self run:#testintersectionLists"

	"Wat zou hier het resultaat van moeten zijn ?!
		if intersectionLists(<<?a, ?b>,<?a, ?z>>, ?i)"

	
	self processQuery:
			' if succeeds(and(intersectionLists(<<[1],[2],[42]>,<[2],[3],[42]>,<[3],[4],[42]>>,?i),equals(?i,<[42]>)))'
		description: 'Can we find the intersection of three lists?'.
	self processQuery: ' if fails(intersectionLists(<<[1],[2]>,?V>,?i))'
		description:
			'Is it true that intersectionLists cannot contain variables as lists to intersect?'.
	self processQuery:
			' if fails(intersectionLists(<<[1],[2],[42]>,<[2],?,[42]>,<[3],[4],[42]>>,?i))'
		description:
			'Is it true that intersectionLists cannot even contain variables in the lists to intersect?'