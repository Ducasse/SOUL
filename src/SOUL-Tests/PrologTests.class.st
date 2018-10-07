"
test usage of SOUL as if it would be a Prolog
"
Class {
	#name : #PrologTests,
	#superclass : #TestCase,
	#category : #'SOUL-Tests'
}

{ #category : #tests }
PrologTests >> testMatrixTranspose [

	| clauses repository query result |

	clauses := {
		'transpose(<>, <>).
		transpose(<?F|?Fs>, ?Ts) if transpose(?F, <?F|?Fs>, ?Ts).

		transpose(<>, ?, <>).
		transpose(<?|?Rs>,?Ms, <?Ts|?Tss>) if 
			listsFirstsRests(?Ms, ?Ts, ?Ms1),
			transpose(?Rs, ?Ms1, ?Tss).
		
		listsFirstsRests(<>,<>,<>).
		listsFirstsRests(<<?F|?Os>|?Rest>, <?F|?Fs>, <?Os|?Oss>) if listsFirstsRests(?Rest, ?Fs, ?Oss)'.
	}.

	query := '
		if transpose(<<1,2,3>,<4,5,6>,<7,8,9>>,?result)'.

	repository := LogicRepositoryWithoutCleaning new.
	clauses do: [:clause | 
		repository addClauses: (SoulFactory current makeParser parse: clause) ].

	result := (SoulFactory current evaluatorForLogicQuery eval: query in:
				repository) allResults resultsForVariableNamed: #result.
	
	self assert: result size equals: 1.			
	self assert: result first asString equals: '<<[1],[4],[7]>,<[2],[5],[8]>,<[3],[6],[9]>>'
]

{ #category : #tests }
PrologTests >> testSimpleList [

	| clauses repository query result |

	clauses := {
		'first(?f,<?f|?rest>)'.
	}.

	query := '
		if first(?x,<a, b, c d>)'.

	repository := LogicRepositoryWithoutCleaning new.
	clauses do: [:clause | 
		repository addClauses: (SoulFactory current makeParser parse: clause) ].

	result := (SoulFactory current evaluatorForLogicQuery eval: query in:
				repository) allResults resultsForVariableNamed: #x.
				
	self assertCollection: (result collect: #smalltalkValue) hasSameElements: #(a).
]

{ #category : #tests }
PrologTests >> testSimpleVariables [

	| clauses repository query result |

	clauses := {
		'parent(a, b).
		parent(a, c).
		parent(a, d).
		male(b).
		male(d).
		female(c).
		son(?ch, ?p) if parent(?p,?ch), male(?ch)'.
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
