evaluator
testnot
	"not/1"

	
	self processQuery: ' if succeeds(not(list([1])))' description:
			'Does not/1 succeed when the enclosed query fails?'.
	self processQuery: ' if fails(not(list(<>)))' description:
			'Does fails/1 fail when the enclosed query succeeds?'.
	self processQuery: ' if succeeds(not(not(list(<>))))' description:
			'Does negation of negation succeed when the enclosed query fails?'.
	self processQuery: ' if fails(not(not(list([1]))))' description:
			'Does negation of negation fail when the enclosed query fails?'