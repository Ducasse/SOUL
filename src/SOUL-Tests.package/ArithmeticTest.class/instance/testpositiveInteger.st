type checking
testpositiveInteger
	"positiveInteger/1"

	
	self processQuery: ' if succeeds(positiveInteger([4]))' description:
			'Is the Smalltalk object 4 a positive integer?'.
	self processQuery: ' if succeeds(positiveInteger([0]))' description:
			'Is the Smalltalk object 0 a positive integer?'.
	self processQuery: ' if fails(positiveInteger([-2]))' description:
			'Is the Smalltalk object -2 NOT a positive integer?'.
	self processQuery: ' if succeeds(positiveInteger(4))' description:
			'Is the logic term 4 a positive integer?'.
	self processQuery: ' if fails(positiveInteger(?N))' description:
			'Does positiveInteger/1 fail when called with a variable?'.
	self processQuery: ' if fails(positiveInteger(bla))' description:
			'Is a logic term representing a symbol not a positive integer?'.
	self processQuery: ' if fails(positiveInteger([''bla'']))' description:
			'Is a Smalltalk string not a positive integer?'.
	self processQuery: ' if fails(positiveInteger([4.0]))' description:
			'Is 4.0 not a positive integer?'.
	self processQuery: ' if fails(positiveInteger([4.2]))' description:
			'Is 4.2 not a positive integer?'