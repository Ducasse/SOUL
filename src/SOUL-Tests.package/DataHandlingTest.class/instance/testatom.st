term type checking
testatom
	"self run:#testatom"

	"atom/1"

	
	self processQuery: ' if fails(atom(?X))' description:
			'Does atom/1 fail for a variable?'.
	self processQuery: ' if succeeds(atom(<>))' description:
			'Does atom/1 succeed for a non-variable such as an empty list?'.
	self processQuery: ' if fails(atom(<a,b,?x,d>))' description:
			'Does atom/1 fail for a list?'.
	self processQuery: ' if succeeds(atom(hallo))' description:
			'Does atom/1 succeed for a symbol?'.
	self processQuery: ' if succeeds(atom(5))' description:
			'Does atom/1 succeed for a number?'.
	self processQuery: ' if succeeds(atom([''hallo'']))' description:
			'Does atom/1 succeed for a string?'.
	self processQuery: ' if succeeds(atom([Object]))' description:
			'Does atom/1 succeed for a Smalltalk class?'.
	self processQuery: ' if fails(atom(hallo(foo,bar)))' description:
			'Does atom/1 fail for a compound term?'.
	self processQuery: ' if fails(atom(hallo(?X,bar)))' description:
			'Does atom/1 fail for a compound term containing a variable?'