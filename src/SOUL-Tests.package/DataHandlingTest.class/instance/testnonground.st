term type checking
testnonground
	"nonground/1"

	
	self processQuery: ' if succeeds(nonground(?X))' description:
			'Is a variable not ground?'.
	self processQuery: ' if fails(nonground(<>))' description:
			'Is an empty list ground?'.
	self processQuery: ' if succeeds(nonground(<a,b,?x,d>))' description:
			'Is a list that contains a variable nonground?'.
	self processQuery: ' if fails(nonground(<a,b,c,d>))' description:
			'Is a fully instantiated list ground?'