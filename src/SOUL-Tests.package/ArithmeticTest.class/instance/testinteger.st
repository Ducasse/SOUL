type checking
testinteger
	"integer/1"

	
	self processQuery: ' if succeeds(integer([4]))' description:
			'Is the Smalltalk object 4 an integer?'.
	self processQuery: ' if succeeds(integer(4))' description:
			'Is the logic term 4 an integer?'.
	self processQuery: ' if fails(integer(?N))' description:
			'Does integer/1 fail when called with a variable?'.
	self processQuery: ' if fails(integer(bla))' description:
			'Is a logic term representing a symbol not an integer?'.
	self processQuery: ' if fails(integer([''bla'']))' description:
			'Is a Smalltalk string not an integer?'.
	self processQuery: ' if fails(integer([4.0]))' description:
			'Is 4.0 not an integer?'.
	self processQuery: ' if fails(integer([4.2]))' description:
			'Is 4.2 not an integer?'