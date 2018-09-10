basic arithmetic
testsub
	"sub/3"

	
	self processQuery: ' if succeeds(sub([4],[3],[1]))' description:
			'Is 4 - 3 = 1 ?'.
	self processQuery: ' if succeeds(and(sub(?N1,[3],[1]),equals(?N1,[4])))'
		description: 'Is 4 the solution of the equation x - 3 = 1 ?'.
	self processQuery: ' if succeeds(and(sub([4],?N2,[1]),equals(?N2,[3])))'
		description: 'Is 3 the solution of the equation 4 - x = 1 ?'.
	self processQuery: ' if succeeds(and(sub([4],[3],?M),equals(?M,[1])))'
		description: 'Is x = 1 if 4 - 3 = x ?'.
	self processQuery: ' if fails(sub([4],[3],[2]))' description:
			'Is 4 - 3 not equal to 2?'.
	self processQuery: ' if fails(sub(?N,?M,?R))' description:
			'Does substraction fail when all arguments are unbound?'