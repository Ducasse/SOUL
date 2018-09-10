term type checking
testvar
	"var/1"

	
	self processQuery: ' if succeeds(var(?X))' description:
			'Does var/1 succeed for a variable?'.
	self processQuery: ' if fails(var(<>))' description:
			'Does var/1 fail for a non variable such as an empty list?'.
	self processQuery: ' if fails(var(<a,b,?x,d>))' description:
			'Does var/1 fail for a list (even when that list may contain variables)?'.
	self processQuery: ' if fails(var(<a,b,c,d>))' description:
			'Does var/1 fail for a fully instantiated list?'.
	self processQuery: ' if fails(var(hallo))' description:
			'Does var/1 fail for a symbol?'.
	self processQuery: ' if fails(var(5))' description:
			'Does var/1 fail for a number?'.
	self processQuery: ' if fails(var([TestClass1]))' description:
			'Does var/1 fail for a Smalltalk class?'