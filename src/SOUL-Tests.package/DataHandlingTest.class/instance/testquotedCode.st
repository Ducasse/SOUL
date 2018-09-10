term type checking
testquotedCode
	"self run: #testquotedCode"

	
	self processQuery: ' if quotedCode({a b c})' description:
			'Detect quotedcode as quotedcode?'.
	self processQuery: ' if not(quotedCode(foo))' description:
			'Fail if not quotedcode?'.
	self processQuery: ' if not(quotedCode(?x))' description:
			'Fail if not quotedcode?'