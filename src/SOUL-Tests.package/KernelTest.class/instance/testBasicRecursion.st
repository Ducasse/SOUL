evaluator
testBasicRecursion
	"self run:#testBasicRecursion"

	
	self repository assert: 'plus(pair(d,?x),?y,pair(d,?z)) if plus(?x,?y,?z)'.
	self repository assert: 'plus(zero,?x,?x)'.
	self
		processQuery: ' if plus(?x,?y,pair(d,pair(d,pair(d,zero))))'
		resultsCheck: [:results | results size = 4]
		description: 'Basic recursion test'
		repository: self repository.
	self
		processQuery:
			' if plus(pair(d,pair(d,pair(d,zero))),zero,pair(d,pair(d,pair(d,zero))))'
		description: 'Basic recursion test'
		repository: self repository.
	self
		processQuery:
			' if plus(pair(d,zero),pair(d,pair(d,zero)),pair(d,pair(d,pair(d,zero))))'
		description: 'Basic recursion test'
		repository: self repository.
	self
		processQuery:
			' if plus(pair(d,pair(d,zero)),pair(d,zero),pair(d,pair(d,pair(d,zero))))'
		description: 'Basic recursion test'
		repository: self repository.
	self repository retractAll: 'plus/3'