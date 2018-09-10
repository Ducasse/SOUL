comparison
testzero
	"zero/1"

	
	self processQuery: ' if succeeds(zero([0]))' description:
			'Is the Smalltalk integer 0 zero?'.
	self processQuery: ' if fails(zero([4]))' description:
			'Is the Smalltalk number 4 not zero?'.
	self processQuery: ' if succeeds(zero(0))' description:
			'Is the logic constant 0 zero?'.
	self processQuery: ' if fails(zero(4))' description:
			'Is the logic constant 4 not zero?'.
	self processQuery: ' if succeeds(and(zero(?N),equals(?N,[0])))'
		description: 'Is 0 filled in when zero/1 is called with a variable?'