Class {
	#name : #LogicSLGTests,
	#superclass : #LogicTests,
	#category : 'SOUL-Tests'
}

{ #category : #'instance creation' }
LogicSLGTests class >> new [
	"Answer a newly created and initialized instance."

	
	^super new initialize
]

{ #category : #testing }
LogicSLGTests >> testBasicTransformations [
	
	| tabledRules generated callGraph |
	SoulFactory resetSLGTables.
	tabledRules := OrderedCollection new.
	tabledRules
		addAll:
			(SoulParser parse:
					'tabled tabledpath(?x,?y) if 
			tabledpath(?x,?z),edge(?z,?y).
		tabled tabledpath(?x,?y) if 
			edge(?x,?y)') clauses.
	callGraph := CallGraph withClauses: tabledRules.
	generated := TabledRule transformTabledRules: tabledRules withCallGraph:
			callGraph.
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'tabledpath\(\?x,\?y\)\s+if\s+\s*\s*slg\(tabledpath\(\?x,\?y\)\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'slgtabledpath\(\?Id,\?x,\?y\)\s+if\s+slgcall\(\?Id,<\?x,\?y>,tabledpath\(\?x,\?z\),\s*\[.*\]\s*,\s*cont0tabledpath\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'cont0tabledpath\(\?Id,<\?x,\?y>,tabledpath\(\?x,\?z\),\?D\)\s+if\s+edge\(\?z,\?y\),\s*answer\(\?Id,tabledpath\(\?x,\?y\),\?D\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'slgtabledpath\(\?Id,\?x,\?y\)\s+if\s+edge\(\?x,\?y\),\s*answer\(\?Id,tabledpath\(\?x,\?y\),\[.*\]\)'])
]

{ #category : #testing }
LogicSLGTests >> testCasesFromPaper [
	
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
]

{ #category : #testing }
LogicSLGTests >> testCasesFromXSB [
	
	SoulFactory resetSLGTables.
	self
		processQuery: ' if mutRetA(?X,?Y)'
		resultsCheck: [:results | results size = 8]
		description: 'mutual recursion'
]

{ #category : #testing }
LogicSLGTests >> testNotTransformations [
	
	| tabledRules generated callGraph |
	SoulFactory resetSLGTables.
	tabledRules := OrderedCollection new.
	tabledRules
		addAll:
			(SoulParser parse:
					'tabled tabledpath(?x,?y) if 
			tabledpath(?x,?z),edge(?z,?y).
		tabled tabledpath(?x,?y) if 
			edge(?x,?y).
		tabled diff(?N) if 
			tabledpath(a,?N),not(tabledpath(c,?N))') clauses.
	callGraph := CallGraph withClauses: tabledRules.
	generated := (tabledRules at: 3) slgTransformWith: tabledRules
		withCallGraph: callGraph.
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'slgdiff\(\?Id,\?N\)\s+if\s+slgcall\(\?Id,<\?N>,tabledpath\(a,\?N\),\[.*\],cont0diff\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'cont0diff\(\?Id,<\?N>,tabledpath\(a,\?N\),\?D\)\s+if\s+slgnot\(\?Id,<\?N>,tabledpath\(c,\?N\),\[.*\],cont1diff\)']).
	self
		assert:
			(generated
				contains:
					[:rule | 
					(rule asString reject: [:x | x = Character cr]) matchesRegex:
							'cont1diff\(\?Id,<\?N>,\?D\)\s+if\s+answer\(\?Id,diff\(\?N\),\?D\)'])
]

{ #category : #testing }
LogicSLGTests >> testSLGEquivalence [
	
	SoulFactory resetSLGTables.
	self
		processQuery: ' if shortpath(?X,?X)'
		resultsCheck:
			[:results | (results resultsForVariableNamed: 'X') size = 4]
		description: 'test all cyclic paths'.
	self
		processQuery: ' if shortpath(?X,?Y)'
		resultsCheck:
			[:results | (results resultsForVariableNamed: 'X') size = 16]
		description:
			'test that this call does not returns the results from ?X,?X'
]
