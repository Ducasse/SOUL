output
testwrite
	"self run: #testwrite"

	"write/1"

	
	self processQuery: ' if succeeds(write(hello))' description:
			'Does this print the string hello on the Transcript?'