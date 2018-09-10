meta programming
testsucceeds
	"self run:#testsucceeds"

	"succeeds/1"

	
	self processQuery: ' if fails(succeeds(list([1])))' description:
			'Does succeeds fail in case of a negative result?'.
	self processQuery: ' if succeeds(succeeds(list(<>)))' description:
			'Does succeeds succeed in case of a positive result?'.
	self processQuery: ' if succeeds(and(equals(?X,7),equals([7 + ?X],?Y)))'
		description:
			'Does succeeds work when it contains a Smalltalk term containing a logic variable'