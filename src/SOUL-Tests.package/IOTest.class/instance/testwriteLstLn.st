output
testwriteLstLn
	"self run: #testwriteLstLn"

	"writeLstLn/1"

	
	self processQuery: ' if succeeds(writeLstLn(<a,b,c>))' description:
			'Does this write the elements a, b, c one after the other on the Transcript and then go to a new line?'