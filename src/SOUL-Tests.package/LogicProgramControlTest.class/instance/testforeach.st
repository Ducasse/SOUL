sets of solutions
testforeach
	"self run: #testforeach"

	"foreach/2"

	
	self processQuery: ' if succeeds(foreach(<1,2,3>,write))' description:
			'Does this print 123 on the Transcript?'