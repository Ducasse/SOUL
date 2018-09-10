sets of solutions
testnodup
	"self run:#testnodup"

	"nodup/1"

	
	self
		processQuery: ' if nodup(member(?x,<1,2,3,1>))'
		resultsCheck: [:results | results size = 3]
		description:
			'Does nodup/1 behave as expected when query contains free variables?'.
	self processQuery: ' if fails(nodup(member(4,<1,2,3,1>)))' description:
			'Does nodup/1 fail when the tested query fails?'