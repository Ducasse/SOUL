basic arithmetic
testadd
	"add/3"

	
	self processQuery:
			' if succeeds(and(add([8],[9],?resulta),equals(?resulta,[17])))'
		description: 'Is 8 + 9 = 17 ?'.
	self processQuery: ' if succeeds(and(add(?n1,[2],[-1]),equals(?n1,[-3])))'
		description: 'Is -3 the solution of the equation x + 2 = -1 ?'.
	self processQuery: ' if succeeds(and(add([3],?m1,[5]),equals(?m1,[2])))'
		description: 'Is 2 the solution of the equation 3 + x = 5 ?'.
	self processQuery: ' if succeeds(add([4],[5],[9]))' description:
			'Is 4 + 5 = 9 ?'.
	self processQuery: ' if succeeds(add([-1],[-2],[-3]))' description:
			'Is -1 + -2 = -3 ?'.
	self processQuery: ' if fails(add(?N,?M,?R))' description:
			'Does addition fail when all arguments are unbound?'.
	self processQuery: ' if fails(add([4],[5],[10]))' description:
			'Is 4 + 5 not equal to 10?'