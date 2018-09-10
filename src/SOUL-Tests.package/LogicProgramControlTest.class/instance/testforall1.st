sets of solutions
testforall1
	"self run: #testforall1"

	"forall/1"

	
	self processQuery:
			' if succeeds(forall(and(member(?x,<[1],[2],[3]>),integer(?x))))'
		description:
			'For every member of a list of integers, is it indeed an integer?'.
	self processQuery: ' if fails(forall(member(?x,<>)))' description:
			'When the query to be tested is false, forall/1 should succeed. Indeed, in that case: for all solutions that satisfy this query (that is none) the true condition will succeed.'