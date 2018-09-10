comparison
testgreaterOrEqual
	"greaterOrEqual/2"

	
	self processQuery: ' if succeeds(greaterOrEqual([6],[5]))' description:
			'Is 6 greater than or equal to 5 ?'.
	self processQuery: ' if succeeds(greaterOrEqual([3],[3]))' description:
			'Is 3 greater than or equal to 3 ?'.
	self processQuery: ' if fails(greaterOrEqual([5],[6]))' description:
			'Is 5 not greater than or equal to 6 ?'.
	self processQuery: ' if fails(greaterOrEqual(?N,[5]))' description:
			'Does greaterOrEqual/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(greaterOrEqual([4],?M))' description:
			'Does greaterOrEqual/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(greaterOrEqual(?N,?M))' description:
			'Does greaterOrEqual/2 fail when both arguments are unbound?'.
	self processQuery: ' if succeeds(greaterOrEqual([5.0],[5]))' description:
			'Is 5.0 greater than or equal to 5 ?'