output
testnewline
	"self run: #testnewline"

	"newline/0"

	
	self processQuery: ' if succeeds(newline(?dummy))' description:
			'Does this bring the cursor to a new line on the Transcript?'