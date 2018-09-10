set handling operators
testdifference
	"difference/3"

	
	self processQuery:
			' if succeeds(difference(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x))' description:
			'Can the difference between two sets be computed?'.
	self processQuery:
			' if succeeds(and(difference(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x),equals(?x,<a,y,d>)))'
		description: 'Is the difference between two sets computed correctly?'.
	self processQuery:
			' if succeeds(difference(<a,e,y,f,u,r,d>,<e,k,f,r,u>,<a,y,d>))'
		description: 'Is the difference between two sets computed correctly?'.
	self processQuery:
			' if succeeds(difference(<a,e,y,f,u,r,d>,<g,k,h,m,s>,<a,e,y,f,u,r,d>))'
		description: 'Computing a difference for an empty intersection.'