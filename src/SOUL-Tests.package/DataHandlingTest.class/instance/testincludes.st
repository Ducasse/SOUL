set handling checks
testincludes
	"includes/2"

	
	self processQuery: ' if succeeds(includes(c,<d,a,c,b,f>))' description:
			'Does a certain element belong to a set?'.
	self processQuery: ' if fails(includes(q,<d,a,c,b,f>))' description:
			'Does a certain element not belong to a set?'.
	self
		processQuery: ' if includes(?El,<d,a,c,b,f>)'
		resultsCheck: [:results | results size = 5]
		description: 'Find all elements that belong to some set'.
	self processQuery: ' if fails(includes(q,<>))' description:
			'Does a certain element not belong to the empty set?'.
	self processQuery: ' if fails(includes(?E,<>))' description:
			'Does nothing belong to the empty set?'