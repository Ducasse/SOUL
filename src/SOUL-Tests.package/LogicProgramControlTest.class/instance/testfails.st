meta programming
testfails
	"self run:#testfails"

	"fails/1"

	
	self processQuery: ' if succeeds(fails(list([1])))' description:
			'Does fails succeed in case of a negative result?'.
	self processQuery: ' if fails(fails(list(<>)))' description:
			'Does fails fail in case of a positive result?'