output
testwriteLnLst
	"self run: #testwriteLnLst"

	"writeLnLst/1"

	
	self processQuery: ' if succeeds(writeLnLst(<a,b,c>))' description:
			'Does this write the elements a, b, c on separate lines of the Transcript?'