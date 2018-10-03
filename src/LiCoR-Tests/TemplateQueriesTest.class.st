Class {
	#name : #TemplateQueriesTest,
	#superclass : #LiCoRTests,
	#category : 'LiCoR-Tests'
}

{ #category : #Private }
TemplateQueriesTest >> repository [
	
	^ SoulFactory liCorRepository
]

{ #category : #'testing template queries' }
TemplateQueriesTest >> testScanner [
	self
		processQuery:
			' if scan(stMethod,[''?name ?var := 123. ^true''],?tokens)'
		resultsCheck:
			[:results | 
			(results resultsForVariableNamed: 'tokens') first asString ='<xSoulVariable([#''?name'']),xSoulVariable([#''?var'']),colon([#'':'']),binary([#=]),number([123]),period([#''.'']),upArrow([#''^'']),word([#true])>']
		description: 'Does the scanner return the correct tokens?'
		repository:(SoulFactory repository: #parsing)
]

{ #category : #'testing template queries' }
TemplateQueriesTest >> testTemplateQuery [
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
]

{ #category : #'testing template queries' }
TemplateQueriesTest >> testTemplateQuery2 [
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
	
	
]
