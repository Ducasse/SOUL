evaluator
testVariablesAsConditions
	
	self processQuery: ' if equals(?y,5),equals(?x,equals(?y,5)),?x'
		description:
			'Basic test to verify that variables can be used as conditions.'.
	self processQuery: ' if metaFact(?fact),?fact' description:
			'Test to verify that a variable can be used as condition when bound to a term coming from a fact.'.
	self processQuery: ' if and(equals(?x,equals(?y,6)),?x)' description:
			'Test to verify if using variables as conditions works in meta predicates such as "and" as well.'	"TODO: This following test fails!"
	"	self processQuery: 'if succeeds(equals(?x,equals(?y,6)),?x)'
		description: 'Test to verify if using variables as conditions works in meta predicates such as succeeds as well.'."