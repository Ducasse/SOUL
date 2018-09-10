basic arithmetic
testproduct
	"self run:#testproduct"

	"product/3"

	
	self processQuery: ' if succeeds(product([4],[3],[12]))' description:
			'Is 4 * 3 = 12 ?'.
	self processQuery:
			' if succeeds(and(product(?N,[3],[12]),equals(?N,[4])))' description:
			'Is 4 the solution of the equation x * 3 = 12 ?'.
	self processQuery:
			' if succeeds(and(product([4],?N,[12]),equals(?N,[3])))' description:
			'Is 3 the solution of the equation 4 * x = 12 ?'.
	self processQuery:
			' if succeeds(and(product([4],[3],?M),equals(?M,[12])))' description:
			'Is x = 12 if 4 * 3 = 12 ?'.
	self processQuery: ' if fails(product([4],[3],[2]))' description:
			'Is 4 * 3 not equal to 2?'.
	self processQuery: ' if fails(product(?N,?M,?R))' description:
			'Does substraction fail when all arguments are unbound?'