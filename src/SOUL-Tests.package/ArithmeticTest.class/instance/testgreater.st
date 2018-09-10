comparison
testgreater
	"greater/2"

	
	self processQuery: ' if succeeds(greater([6],[5]))' description:
			'Is 6 greater than 5 ?'.
	self processQuery: ' if fails(greater([5],[6]))' description:
			'Is 5 not greater than 6 ?'.
	self processQuery: ' if fails(greater([3],[3]))' description:
			'Is 3 not strict greater than 3 ?'.
	self processQuery: ' if fails(greater(?N,[5]))' description:
			'Does greater/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(greater([4],?M))' description:
			'Does greater/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(greater(?N,?M))' description:
			'Does greater/2 fail when both arguments are unbound?'