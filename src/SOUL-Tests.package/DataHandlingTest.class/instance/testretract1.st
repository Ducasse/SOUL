the clause database
testretract1
	"self run:#testretract1"

	
	self repository assert: 'testretract(a).testretract(b)'.
	self processQuery:
			' if retract(testretract(f)),exactlyOne(testretract(b))' description:
			'Is the first clause retracted correctly?'.
	self processQuery: ' if retract(testretract(b)),fails(testretract(b))'
		description: 'Is the second clause retracted correctly?'.
	self processQuery: ' if fails(retract(?foo))' description:
			'We cannot retract unground terms'