output
testwriteLn
	"self run: #testwriteLn"

	"writeLn/1"

	
	self processQuery: ' if succeeds(writeLn(hello))' description:
			'Does this print the string hello on the Transcript and then go to a new line?'