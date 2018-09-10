generate
testmember
	"self run:#testmember"

	
	self
		processQuery: ' if member(?x,[#(1 2 3) asOrderedCollection])'
		resultsCheck: [:results | results size = 3]
		description: 'Check the pure generative function'.
	self
		processQuery:
			' if equals(?x,dummy),member(1,[#(1 2 3) asOrderedCollection])'
		resultsCheck: [:results | results size = 1]
		description: 'Can we also use a non-variable as first argument?'