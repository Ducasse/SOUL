comparison
testsmallerOrEqual
	"smallerOrEqual/2"

	
	self processQuery: ' if succeeds(smallerOrEqual([5],[6]))' description:
			'Is 5 smaller than or equal to 6 ?'.
	self processQuery: ' if fails(smallerOrEqual([6],[4]))' description:
			'Is 6 not smaller than or equal to 4 ?'.
	self processQuery: ' if succeeds(smallerOrEqual([5],[5]))' description:
			'Is 5 smaller than or equal to 5 ?'.
	self processQuery: ' if fails(smallerOrEqual(?N,[5]))' description:
			'Does smallerOrEqual/2 fail when first argument is unbound?'.
	self processQuery: ' if fails(smallerOrEqual([4],?M))' description:
			'Does smallerOrEqual/2 fail when second argument is unbound?'.
	self processQuery: ' if fails(smallerOrEqual(?N,?M))' description:
			'Does smallerOrEqual/2 fail when both arguments are unbound?'.
	self processQuery: ' if succeeds(smallerOrEqual([5.0],[5]))' description:
			'Is 5.0 smaller than or equal to 5 ?'