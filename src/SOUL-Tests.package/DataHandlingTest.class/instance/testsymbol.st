term type checking
testsymbol
	"self run: #testsymbol"

	"symbol/1"

	
	self processQuery: ' if fails(symbol(?X))' description:
			'Is a variable not a symbol?'.
	self processQuery: ' if fails(symbol(1))' description:
			'Is a number not a symbol?'.
	self processQuery: ' if fails(symbol([Object]))' description:
			'Is a Smalltalk class not a symbol?'.
	self processQuery: ' if succeeds(symbol(hallo))' description:
			'Check shortcut notation for symbol'.
	self processQuery: ' if succeeds(symbol([#hallo]))' description:
			'Is #hallo a symbol ?'.
	self processQuery: ' if fails(symbol([''hello there'']))' description:
			'Is a Smalltalk string not a symbol?'