set handling operators
testunion
	"union/3"

	
	self processQuery: ' if succeeds(union(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x))'
		description: 'Is it possible to compute the union of two sets?'.
	self processQuery:
			' if succeeds(union(<a,b,c,d>,<e,f,g,h>,<a,b,c,d,e,f,g,h>))'
		description: 'Is the union of two sets correctly computed?'.
	self processQuery:
			' if succeeds(union(<a,b,c,d>,<b,e,c,a,d>,<a,b,c,d,e>))' description:
			'Is the union of two sets correctly computed?'.
	self processQuery:
			' if succeeds(and(equals(?Set,<a,b,c,d>),union(?Set,<>,?Set)))'
		description: 'Is the union of a set with the empty set the same set?'.
	self processQuery:
			' if succeeds(and(equals(?Set,<a,b,c,d>),union(<>,?Set,?Set)))'
		description: 'Is the union of the empty set with a set the same set?'.
	self processQuery: ' if succeeds(union(<>,<>,<>))' description:
			'Is the union of two empty sets the empty set?'