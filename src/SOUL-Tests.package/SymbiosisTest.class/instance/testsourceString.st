quotedCode
testsourceString
	"self run:#testsourceString"

	
	self processQuery: ' if sourceString({simpele test},[''simpele test''])'
		description: 'Is a quotedcode converted correctly?'.
	self processQuery:
			' if sourceString({simpele test},?c),equals(?c,[''simpele test''])'
		description: 'Is a quotedcode converted correctly?'.
	self processQuery:
			' if sourceString(?c,[''simpele test'']),equals(?c,{simpele test})'
		description: 'Is a string converted correctly?'