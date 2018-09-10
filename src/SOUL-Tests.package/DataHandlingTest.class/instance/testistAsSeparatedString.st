string handling
testistAsSeparatedString
	"self run:#testlistAsSeparatedString"

	"listAsSeparatedString/3"

	
	self processQuery:
			' if succeeds(listAsSeparatedString(<>,['' ''],['''']))' description:
			'Is the empty list converted in an empty string (regardless of the separator)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo>,['' ''],[''foo'']))'
		description:
			'Is a single symbol converted into a string containing just that symbol (regardless of the separator)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo,bar>,['' ''],[''foo bar'']))'
		description:
			'Is a list of two symbols converted into a list containing those two symbols with a space in between (when the separator is a space)?'.
	self processQuery:
			' if succeeds(listAsSeparatedString(<foo,bar,zork>,['' ''],[''foo bar zork'']))'
		description:
			'Is a list of three symbols converted into a list containing those three symbols with a space between each two symbols (when the separator is a space)?'