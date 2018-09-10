meta programming
testapply2
	"self run:#testapply2"

	
	self processQuery: ' if succeeds(apply(fact2,<onlyOccurence>))'
		description:
			'This should work because it is equivalent to calling fact2(onlyOccurence) which is supposed to work'.
	self processQuery: ' if succeeds(apply(fact2,<?x>))' description:
			'This should work because it is equivalent to calling fact2(?x) which is supposed to work'.
	self processQuery:
			' if succeeds(and(apply(fact2,<?x>),equals(?x,onlyOccurence)))'
		description:
			'This should work because it is equivalent to calling fact2(?x) which indeed returns onlyOccurence as a possible value for ?x'