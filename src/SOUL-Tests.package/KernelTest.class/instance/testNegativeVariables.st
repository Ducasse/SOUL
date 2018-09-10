evaluator
testNegativeVariables
	
	self processQuery: ' if testNegVariable(?a)' description:
			'The most simple case for negative variables'.
	self processQuery: ' if not(testNegVariable(a))' description:
			'The most simple case for negative variables'.
	self processQuery: ' if equals(?x,?a),testNegVariable(?x)' description:
			'The second simplest case for negative variables'.
	self processQuery: ' if equals(?x,a),not(testNegVariable(?x))'
		description: 'The second simplest case for negative variables'.
	self processQuery: ' if testNegVariable(2,?y),equals(?y,2)' description:
			'Do negative variables still work when used in a rule'