type checking
teststrictPositiveInteger
	"positiveInteger/1"

	
	self processQuery: ' if succeeds(strictPositiveInteger([4]))' description:
			'Is the Smalltalk object 4 a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([0]))' description:
			'Is the Smalltalk object 0 NOT a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger(0))' description:
			'Is the logic constant 0 NOT a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([-2]))' description:
			'Is the Smalltalk object -2 NOT a strict positive integer?'.
	self processQuery: ' if succeeds(strictPositiveInteger(4))' description:
			'Is the logic term 4 a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger(?N))' description:
			'Does strictPositiveInteger/1 fail when called with a variable?'.
	self processQuery: ' if fails(strictPositiveInteger(bla))' description:
			'Is a logic term representing a symbol not a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([''bla'']))'
		description: 'Is a Smalltalk string not a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([4.0]))' description:
			'Is 4.0 not a strict positive integer?'.
	self processQuery: ' if fails(strictPositiveInteger([4.2]))' description:
			'Is 4.2 not a strict positive integer?'