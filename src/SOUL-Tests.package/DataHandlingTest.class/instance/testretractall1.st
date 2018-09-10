the clause database
testretractall1
	"self run:#testretractall1"

	
	self repository assert: 'testretract2(a).testretract2(a)'.
	self processQuery:
			' if retractall(testretract2(a)),fails(testretract2(a))' description:
			'Are all clauses retracted correctly?'.
	self processQuery: ' if fails(retractall(?foo))' description:
			'We cannot retract unground terms'