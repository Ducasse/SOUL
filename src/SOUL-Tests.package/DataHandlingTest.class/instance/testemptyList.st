list handling
testemptyList
	"emptyList/1"

	
	self processQuery: ' if succeeds(emptyList(<>))' description:
			'Is <> the notation for an empty list?'.
	self processQuery: ' if fails(emptyList(<1,2,3>))' description:
			'Is <1,2,3> not an empty list?'.
	self processQuery: ' if succeeds(and(emptyList(?var),equals(?var,<>)))'
		description:
			'When calling emptyList with a variable, is the variable bound to <>?'.
	self processQuery:
			' if succeeds(and(equals(<a>,?x),equals(?x,<?y|?z>),emptyList(?z)))'
		description: 'Is the tail of a singleton-list empty?'