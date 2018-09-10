generate
testcollectionMember
	"self run:#testcollectionMember"

	
	self
		processQuery: ' if collectionMember(?x,[#(1 2 3) asOrderedCollection])'
		resultsCheck: [:results | results size = 3]
		description: 'Check the pure generative function'.
	self
		processQuery:
			' if equals(?x,dummy),collectionMember(1,[#(1 2 3) asOrderedCollection])'
		resultsCheck: [:results | results size = 1]
		description: 'Can we also use a non-variable as first argument?'.
	self
		processQuery: ' if collectionMember(?x,[#(1 2)])'
		resultsCheck: [:results | results size = 2]
		description: 'Tests whether collectionMember can be used on an Array'.
	self
		processQuery:
			' if collectionMember(?x,[#(#(1) #(2))]),collectionMember(?y,?x)'
		resultsCheck: [:results | results size = 2]
		description:
			'Tests whether collectionMember can be used on the result of a collectionMember call.'.
	self
		processQuery:
			' if collectionMember(?x,[#(#(1) #(2))]),collectionMember(?y,[?x])'
		resultsCheck: [:results | results size = 2]
		description:
			'Tests whether collectionMember can be used on the result of a collectionMember call when a Smalltalk term is used to pass the second collection. (note: this test has been used to expose a particularly nasty problem in Squeak caused by Squeak''s limitations on blocks. KG)'.
	self
		processQuery:
			' if collectionMember(?x,[#(#(1 2 3) #(4 5 6) #(7 8 9 10))]),collectionMember(?y,[?x])'
		resultsCheck: [:results | results size = 10]
		description: 'Tests a more extensive variation of the above test.'