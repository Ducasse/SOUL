printing on Transcript
testprologoutput
	"newline/0"

	"write/1"

	"writeLn/1"

	"This test should print out the following on the Transcript: 
	Language: It`s a virus. 
	-- Laurie Anderson.
	"

	
	self processQuery:
			' if succeeds(and(write([''Language: It`s a virus.'']),newline(?dummy),writeLn([''-- Laurie Anderson.'']),write([''The above should have printed nice!''])))'
		description: 'Does this print something nice on the Transcript?'