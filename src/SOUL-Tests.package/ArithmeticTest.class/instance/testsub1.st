basic arithmetic
testsub1
	"sub1/2"

	
	self processQuery: ' if succeeds(sub1([4],[3]))' description:
			'Is 4 - 1 = 3 ?'.
	self processQuery: ' if fails(sub1([4],[2]))' description:
			'Is 4 - 1 not equal to 2 ?'.
	self processQuery: ' if succeeds(and(sub1(?N1,[3]),equals(?N1,[4])))'
		description: 'Is x = 4 if x - 1 = 3 ?'.
	self processQuery: ' if succeeds(and(sub1([4],?N2),equals(?N2,[3])))'
		description: 'Is x = 3 if 4 - 1 = x ?'