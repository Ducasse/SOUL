Assertions
processQuery: aString description: descriptionString repository: aRepository
	"This method is exactly the same as processQuery:resultsCheck:description: 
	except that the resultcheck is left out. It is replaced by a default check 
	that the result was successful."

	
	self
		processQuery: aString
		resultsCheck: [:results | results success]
		description: descriptionString
		repository: aRepository