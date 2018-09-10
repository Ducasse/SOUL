testing
testCasesFromPaper
	
	| basicPathBlock |
	SoulFactory resetSLGTables.
	basicPathBlock := [:results | 
	(results resultsForVariableNamed: 'X') size = 3
		and:
			[((results resultsForVariableNamed: 'X') collect: [:x | x smalltalkValue])
				asOrderedCollection sort = #(#b #c #d) asOrderedCollection]].
	self processQuery: ' if tabledpath(a,?X)' resultsCheck: basicPathBlock
		description: 'test all the paths from a, first case from paper'.
	self
		processQuery: ' if tabledpath(aa,?X)'
		resultsCheck:
			[:results | (results resultsForVariableNamed: 'X') size = 268]
		description:
			'test all the paths from aa, first case from paper (should take a couple of seconds)'.
	self processQuery: ' if drpath(a,?X)' resultsCheck: basicPathBlock
		description:
			'tests all the paths from a, using the double recursive predicate. Used to test the passing around of variables, 2nd case of the paper'.
	self
		processQuery: ' if diff(?X)'
		resultsCheck:
			[:results | 
			(results resultsForVariableNamed: 'X') size = 2
				and:
					[((results resultsForVariableNamed: 'X') collect: [:x | x smalltalkValue])
						asOrderedCollection sort = #(#b #c) asOrderedCollection]]
		description:
			'test 3rd case of the paper with negation (not through recursion)'.
	self
		processQuery: ' if win(?X)'
		resultsCheck:
			[:results | 
			(results resultsForVariableNamed: 'X') size = 1
				and:
					[((results resultsForVariableNamed: 'X') collect: [:x | x smalltalkValue])
						asOrderedCollection sort = #(#c) asOrderedCollection]]
		description:
			'test 4th case of the paper with negation (through recursion)'