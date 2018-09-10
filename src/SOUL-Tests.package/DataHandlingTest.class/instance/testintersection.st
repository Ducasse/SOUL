set handling operators
testintersection
	"intersection/3"

	
	self processQuery:
			' if succeeds(intersection(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x))'
		description: 'Can the intersection of two sets be computed?'.
	self processQuery:
			' if succeeds(and(intersection(<a,e,y,f,u,r,d>,<e,k,f,r,u>,?x),equals(?x,<e,f,u,r>)))'
		description: 'Is the intersection of two sets computed correctly?'.
	self processQuery:
			' if succeeds(intersection(<a,e,y,f,u,r,d>,<e,k,f,r,u>,<e,f,u,r>))'
		description: 'Is the intersection of two sets computed correctly?'.
	self processQuery:
			' if succeeds(intersection(<a,e,y,f,u,r,d>,<g,k,h,m,s>,<>))'
		description: 'Computing an empty intersection.'