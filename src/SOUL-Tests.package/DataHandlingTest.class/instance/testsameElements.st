list handling
testsameElements
	"sameElements/2"

	
	self processQuery: ' if succeeds(sameElements(<>,<>))' description:
			'Has the empty list the same elements as the empty list?'.
	self processQuery: ' if succeeds(sameElements(<a,b,c,d>,<d,c,a,b>))'
		description: 'Are two lists of symbols with permuted elements the same?'.
	self processQuery: ' if sameElements(<1,2,3>,<2,1,3>)' description:
			'Are two lists of numbers with permuted elements the same?'.
	self processQuery:
			' if succeeds(sameElements(<[1],[2],[3]>,<[2],[1],[3]>))' description:
			'Are two lists of numbers with permuted elements the same?'.
	self processQuery: ' if fails(sameElements(<a,b,c>,<d,a,b>))' description:
			'Are two lists with different elements unequal?'