term type checking
teststring
	"self run: #teststring"

	"string/1"

	
	self processQuery: ' if fails(string(?X))' description:
			'Is a variable not a string?'.
	self processQuery: ' if fails(string(1))' description:
			'Is a number not a string?'.
	self processQuery: ' if fails(string([Object]))' description:
			'Is a Smalltalk class not a string?'.
	self processQuery: ' if succeeds(string(hallo))' description:
			'Is a symbol a string?'.
	self processQuery: ' if succeeds(string([#hallo]))' description:
			'Is a Smalltalk symbol a string?'.
	self processQuery: ' if succeeds(string([''hello there'']))' description:
			'Is a Smalltalk string a string?'