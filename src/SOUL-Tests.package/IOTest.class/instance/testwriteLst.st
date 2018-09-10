output
testwriteLst
	"self run: #testwriteLst"

	"writeLst/1"

	
	self processQuery: ' if succeeds(writeLst(<a,b,c>))' description:
			'Does this write the elements a, b, c one after the other on the Transcript?'