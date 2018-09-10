set handling checks
testsubSet
	"subSet/2"

	
	self processQuery: ' if succeeds(subSetOf(<a,b,c>,<d,a,c,b,f>))'
		description: 'Is a certain set a subset of another one?'.
	self processQuery: ' if fails(subSetOf(<a,b,q,c>,<d,a,c,b,f>))'
		description: 'Is a certain set no subset of another one?'.
	self processQuery: ' if succeeds(subSetOf(<>,<d,a,c,b,f>))' description:
			'Is the empty set a subset of another set?'.
	self processQuery: ' if succeeds(subSetOf(<>,<>))' description:
			'Is the empty set a subset of itself?'