meta programming
testifThenElse
	"self run:#testifThenElse"

	"ifThenElse/3"

	
	self processQuery:
			' if succeeds(and(equals(?X,0),ifThenElse(smaller(?X,1),equals(?Result,trueCase),equals(?Result,falseCase)),equals(?Result,trueCase)))'
		description: 'Does ifThenElse/3 succeed for the true case?'.
	self processQuery:
			' if succeeds(and(equals(?X,2),ifThenElse(smaller(?X,1),equals(?Result,trueCase),equals(?Result,falseCase)),equals(?Result,falseCase)))'
		description: 'Does ifThenElse/3 succeed for the false case?'