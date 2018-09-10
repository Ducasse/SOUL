term type checking
testground
	"self run:#testground"

	
	self processQuery: ' if fails(ground(?X))' description:
			'Is a variable not ground?'.
	self processQuery: ' if fails(ground(?))' description:
			'Is an unnamed variable not ground?'.
	self processQuery: ' if succeeds(ground(<>))' description:
			'Is an empty list ground?'.
	self processQuery: ' if fails(ground(<a,b,?x,d>))' description:
			'Is a list that contains a variable ground?'.
	self processQuery: ' if fails(ground(<a,b,?,d>))' description:
			'Is a list that contains an unnamed variable ground?'.
	self processQuery: ' if succeeds(ground(<a,b,c,d>))' description:
			'Is a fully instantiated list ground?'