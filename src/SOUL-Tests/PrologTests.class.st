"
test usage of SOUL as if it would be a Prolog
"
Class {
	#name : #PrologTests,
	#superclass : #TestCase,
	#category : #'SOUL-Tests'
}

{ #category : #tests }
PrologTests >> testSimpleVariables [

	| clauses repository query result |

	clauses := {
		'parent(a, b)'.
		'parent(a, c)'.
		'parent(a, d)'.
		'male(b)'.
		'male(d)'.
		'female(c)'.
		'son(?ch, ?p) if parent(?p,?ch), male(?ch)'.
	}.

	query := '
		if son(?person,a)'.

	repository := LogicRepositoryWithoutCleaning new.
	clauses do: [:clause | 
		repository addClauses: (SoulFactory current makeParser parse: clause) ].

	result := (SoulFactory current evaluatorForLogicQuery eval: query in:
				repository) allResults resultsForVariableNamed: #person.
				
	self assertCollection: (result collect: #smalltalkValue) hasSameElements: #(b d).
]
