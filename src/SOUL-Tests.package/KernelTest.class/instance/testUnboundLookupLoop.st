evaluator
testUnboundLookupLoop
	"self run:#testUnboundLookupLoop"

	
	self processQuery: ' if succeeds(equals(?x,?x))' description:
			'Unbound variable lookup-loop test'