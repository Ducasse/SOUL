basic arithmetic
testadd1
	"add1/2"

	
	self processQuery: ' if succeeds(add1([8],[9]))' description:
			'Is 8 + 1 = 9 ?'.
	self processQuery: ' if fails(add1([9],[11]))' description:
			'Is 9 + 1 not equal to 11 ?'.
	self processQuery: ' if succeeds(and(add1(?n1,[2]),equals(?n1,[1])))'
		description: 'Is x = 1 if x + 1 = 2 ?'.
	self processQuery: ' if succeeds(and(add1([3],?m1),equals(?m1,[4])))'
		description: 'Is x = 4 if 3 + 1 = x ?'