Test Interface
afterQuery: results description: descriptionString
	"A query was run, and the results are in 'results'. Output the description and the time it took. Remember the time it took for the current case (the total for the case will be the sum for all its individual queries)"

	
	| took |
	took := results timeTaken.
	self addToCurrentCaseCount: took.
	self output: descriptionString took: took