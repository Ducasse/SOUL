list handling
testreverse
	"reverse/2"

	
	self processQuery:
			' if succeeds(reverse(<[4],[3],[2],[1]>,<[1],[2],[3],[4]>))'
		description:
			'Does reverse work correctly with two instantiated arguments?'.
	self processQuery: ' if succeeds(reverse(?L,<1,2,3,4>))' description:
			'Does reverse work with first argument unbound?'.
	self processQuery:
			' if succeeds(and(reverse(?L,<1,2,3,4>),equals(?L,<4,3,2,1>)))'
		description: 'Does reverse work correctly with first argument unbound?'.
	self processQuery: ' if succeeds(reverse(<1,2,3,4>,?L))' description:
			'Does reverse work with second argument unbound?'.
	self processQuery:
			' if succeeds(and(reverse(<1,2,3,4>,?L),equals(?L,<4,3,2,1>)))'
		description: 'Does reverse work correctly with second argument unbound?'