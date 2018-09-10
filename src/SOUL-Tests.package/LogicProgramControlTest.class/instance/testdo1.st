meta programming
testdo1
	"self run:#testdo1"

	"do/1"

	
	self processQuery: ' if do(writeLn([''Hallo'']))' description:
			'Does do/1 succeed when the action succeeds?'.
	self processQuery: ' if do(and(writeLn([''Hallo'']),[false]))'
		description: 'Does do/1 succeed even when the action fails?'.
	self
		processQuery:
			' if [LogicProgramControlTest resetDoTestMemory.
true],do([LogicProgramControlTest incrementDoTestMemory.
true])'
		resultsCheck: [:result | self class doTestMemory = 1]
		description: 'Does do/1 produce the expected side-effect?'.
	self
		processQuery:
			' if [LogicProgramControlTest resetDoTestMemory.
true],do(and([LogicProgramControlTest incrementDoTestMemory.
true],[false]))'
		resultsCheck: [:result | self class doTestMemory = 1]
		description:
			'Does do/1 produce the expected side-effect even when the action fails?'