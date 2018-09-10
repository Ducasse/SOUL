list handling
testlength
	"self run:#testlength"

	"This default test, which always fails, was generated automatically.
	 Please replace with an adequate test of predicate length!"

	
	self processQuery: ' if succeeds(length(<[1],[2],[3]>,3))' description:
			'checks whether the length of a list of length 3 is well-calculated'.
	self processQuery:
			' if succeeds(and(length(<[1],[2],[3]>,?x),equals(?x,3)))' description:
			'checks whether the length of a list of length 3 is well-calculated'.
	self processQuery: ' if succeeds(length(<>,0))' description:
			'has the empty list length 0?'.
	self processQuery: ' if length(?list,[5]),equals(?list,<?,?,?,?,?>)'
		description:
			'can the predicate be used to generate a list of a given length?'.
	self processQuery:
			' if not(succeeds(length(?l,3),equals(?l,<?x,?x,?x>),equals(?l,<1,2,3>)))'
		description: 'is the resulting list not filled with anonymous variables?'