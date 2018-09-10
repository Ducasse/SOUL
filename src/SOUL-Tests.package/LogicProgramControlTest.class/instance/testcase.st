meta programming
testcase
	"self run:#testcase"

	
	self processQuery:
			' if equals(?X,0),case(cond(smaller(?X,1),equals(?Result,firstCase)),cond(smaller(?X,4),equals(?Result,secondCase)),cond([true],equals(?Result,thirdCase))),equals(?Result,firstCase)'
		description: 'Does case succeed for the first case?'.
	self processQuery:
			' if equals(?X,2),case(cond(smaller(?X,1),equals(?Result,firstCase)),cond(smaller(?X,4),equals(?Result,secondCase)),cond([true],equals(?Result,thirdCase))),equals(?Result,secondCase)'
		description: 'Does case succeed for the second case?'.
	self processQuery:
			' if equals(?X,5),case(cond(smaller(?X,1),equals(?Result,firstCase)),cond(smaller(?X,4),equals(?Result,secondCase)),cond([true],equals(?Result,thirdCase))),equals(?Result,thirdCase)'
		description: 'Does case succeed for the last case?'.
	self
		processQuery:
			' if equals(?X,0),[LogicProgramControlTest resetDoTestMemory.
true],case(cond(smaller(?X,1),[LogicProgramControlTest incrementDoTestMemory.
true]),cond(smaller(?X,4),[LogicProgramControlTest incrementDoTestMemory.
true]),cond([true],[LogicProgramControlTest incrementDoTestMemory.
true]))'
		resultsCheck: [:result | self class doTestMemory = 1]
		description: 'Check that the case indeed executes only the first action'