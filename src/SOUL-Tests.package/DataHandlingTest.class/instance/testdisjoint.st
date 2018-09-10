set handling checks
testdisjoint
	"disjoint/2"

	
	self processQuery: ' if succeeds(disjoint(<a,b,c>,<d,g,f,h>))'
		description: 'Are two sets disjoint?'.
	self processQuery: ' if succeeds(disjoint(<>,<d,g,f,h>))' description:
			'Is the empty set disjoint with another one?'.
	self processQuery: ' if succeeds(disjoint(<a,b,c>,<>))' description:
			'Is a set disjoint with the empty set?'.
	self processQuery: ' if succeeds(disjoint(<>,<>))' description:
			'Are two empty sets disjoint?'.
	self processQuery: ' if fails(disjoint(<a,b,c>,<d,e,b,f>))' description:
			'Are two sets not disjoint?'