term type checking
testnonvar
	"nonvar/1"

	
	self processQuery: ' if fails(nonvar(?X))' description:
			'Does nonvar/1 fail for a variable?'.
	self processQuery: ' if succeeds(nonvar(<>))' description:
			'Does nonvar/1 succeed for a non variable such as an empty list?'.
	self processQuery: ' if succeeds(nonvar(<a,b,?x,d>))' description:
			'Does nonvar/1 succeed for a list (even when that list may contain variables)?'.
	self processQuery: ' if succeeds(nonvar(<a,b,c,d>))' description:
			'Does nonvar/1 succeed for a fully instantiated list?'.
	self processQuery: ' if succeeds(nonvar(hallo))' description:
			'Does nonvar/1 succeed for a symbol?'.
	self processQuery: ' if succeeds(nonvar(5))' description:
			'Does nonvar/1 succeed for a number?'.
	self processQuery: ' if succeeds(nonvar([TestClass1]))' description:
			'Does nonvar/1 succeed for a Smalltalk class?'