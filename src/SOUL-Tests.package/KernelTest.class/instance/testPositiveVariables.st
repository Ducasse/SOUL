evaluator
testPositiveVariables
	
	self repository assert: 'testPosVariable(+?x)'.
	self processQuery: ' if testPosVariable(a)' description:
			'The most simple case for positive variables'.
	self processQuery: ' if not(testPosVariable(?a))' description:
			'The most simple case for positive variables'.
	self processQuery: ' if equals(?x,a),testPosVariable(?x)' description:
			'The second simplest case for positive variables'.
	self processQuery:
			' if equals(?x,?y),not(testPosVariable(?x)),not(testPosVariable(?y))'
		description: 'The second simplest case for positive variables'.
	self processQuery: ' if equals(?x,a),equals(?x,?y),testPosVariable(?y)'
		description: 'The third simplest case for positive variables'.
	self repository retractAll: 'testPosVariable/1'.
	self repository assert: 'testing(2)'.
	self repository assert: 'testPosVariable(+?x) if testing(?x)'.
	self processQuery: ' if testPosVariable(2)' description:
			'Do positive variables still work when used in a rule'.
	self repository retractAll: 'testPosVariable/1'.
	self repository retractAll: 'testing/1'