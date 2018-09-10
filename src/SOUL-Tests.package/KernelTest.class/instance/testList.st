evaluator
testList
	"self run:#testList"

	
	self processQuery: ' if equals(<a,b,c>,<a,b,c>)' description:
			'Is the shorthand notation of list correct?'.
	self processQuery: ' if fails(equals(<a|b>,<a,b>))' description:
			'Is the cons-cel construction correct?'