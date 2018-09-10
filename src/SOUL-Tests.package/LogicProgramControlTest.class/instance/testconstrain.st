sets of solutions
testconstrain
	"self run:#testconstrain"

	"constrain/2"

	"Can the author of constrain/2 (Roel?) please add some adequate tests for the predicate constrain/2 here?"

	
	self
		processQuery: ' if constrain(?c,[Smalltalk allClasses])'
		resultsCheck: [:results | results size = Smalltalk allClasses size]
		description: 'constrain/2'.
	self processQuery: ' if constrain([Object],[Smalltalk allClasses])'
		description: 'constrain/2'