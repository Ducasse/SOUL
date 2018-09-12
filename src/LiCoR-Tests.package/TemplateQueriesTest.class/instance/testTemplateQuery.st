testing template queries
testTemplateQuery
	self
		processQuery:
			' if ?method isMethodWithName:array inClass:[TestClass1],
			     stMethod(?method) {array ^array}'
		resultsCheck:
			[:results | 
			(results size =  1)]
		description: 'Matching a method'.
	
	self
		processQuery:
			' if ?method isMethodWithName:array inClass:[TestClass1],
			     stMethod(?method) {array ^?var}'
		resultsCheck:
			[:results | 
			(results size =  2)]
		description: 'Matching a method'.
		
	self
		processQuery:
			' if ?method isMethodWithName:array inClass:[TestClass1],
			     stMethod(?method) {?name ^array}'
		resultsCheck:
			[:results | 
			(results size =  1)]
		description: 'Matching a method'.
		
	self
		processQuery:
			' if ?method isMethodWithName:array inClass:[TestClass1],
			     stMethod(?method) {?name ^?name}'
		resultsCheck:
			[:results | 
			(results size =  1)]
		description: 'Matching a method'.