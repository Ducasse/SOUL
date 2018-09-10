comparison
testsmaller
	"smaller/2"

	
	self processQuery: ' if succeeds(smaller([5],[6]))' description:
			'Is 5 smaller than 6 ?'.
	self processQuery: ' if fails(smaller([6],[4]))' description:
			'Is 6 not smaller than 4 ?'.
	self processQuery: ' if fails(smaller([3],[3]))' description:
			'Is 3 not strict smaller than 3 ?'.
	self processQuery: ' if fails(smaller(?N,[5]))' description:
			'Does smaller/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(smaller([4],?M))' description:
			'Does smaller/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(smaller(?N,?M))' description:
			'Does smaller/2 fail when both arguments are unbound?'