Assertions
processQuery: anId resultsCheck: checkBlock description: descriptionString repository: aRepository
	"Note that the description is not used here, but is meant for subclasses  
	that allow to log extra information (for example to show the time it took 
	to process a query)."

	
	| results |
	"aString := self queryWithId: anId.
	self logicTimer beforeQuery: aString."
	results := (SoulFactory current evaluatorForLogicQuery eval: anId in:
			aRepository) allResults.
	self assert: (checkBlock value: results)	"self logicTimer afterQuery: results description: descriptionString"