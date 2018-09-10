type checking
testnumber
	"number/1"

	
	self processQuery: ' if succeeds(number([4]))' description:
			'Is the Smalltalk object 4 a number?'.
	self processQuery: ' if succeeds(integer(4))' description:
			'Is the logic term 4 a number?'.
	self processQuery: ' if fails(number(?N))' description:
			'Does number/1 fail when called with a variable?'.
	self processQuery: ' if fails(number(bla))' description:
			'Is a logic term representing a symbol not a number?'.
	self processQuery: ' if fails(integer([''bla'']))' description:
			'Is a Smalltalk string not an integer?'.
	self processQuery: ' if succeeds(number([4.0]))' description:
			'Is 4.0 a number?'.
	self processQuery: ' if succeeds(number([-21.54]))' description:
			'Is -21.54 a number?'