evaluator
testFactsInMultipleClasses
	"self run:#testFactsInMultipleClasses"

	
	self
		processQuery: ' if fact3(?X)'
		resultsCheck: [:results | results size = 4]
		description:
			'Are all definitions of a predicate found when its definition is spread over multiple classes?'