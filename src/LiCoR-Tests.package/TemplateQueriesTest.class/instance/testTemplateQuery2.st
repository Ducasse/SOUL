testing template queries
testTemplateQuery2
	self
		processQuery:
			' if ?method isMethodWithName: [#method3:] inClass:[TestClass1],
			     stMethod(?method) {method3: arg 
										^self method1
												ifTrue: [arg first]
												ifFalse: [arg asSet]}'
		resultsCheck:
			[:results | 
			(results size =  1)]
		description: 'Matching a method with arguments'.
	
	