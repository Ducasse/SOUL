evaluator
testDynamicPredicate
	"Test the dynamic predicate for failure"

	
	self
		processQuery: ' if fails(testDynamicPredicate)'
		description: 'Dynamic Predicate test'
		repository: self repository.	"Test a non-dynamic predicate for error"

	[self
		processQuery: ' if notTestDynamicPredicate'
		description: 'Dynamic Predicate test'
		repository: self repository]
		on: Error
		do: [:ex | true]