"
CallGraph has not been commented.  The comment should state the purpose of the class and also explain any unobvious aspects of the implementation.

Instance Variables
	nodeMapping	<Dictionary> maps termName/multiplicity to an index
	nodes	<(Array of: (JavaArray | SequenceableCollection))>	2dim array with boolean if idxA calls idxB


"
Class {
	#name : #CallGraph,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'nodeMapping',
		'clauseNames'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
CallGraph class >> withClauses: aCollection [
	
	| graph |
	graph := CallGraph new withClauses: aCollection.
	^graph
]

{ #category : #private }
CallGraph >> getAllConnected: anInteger [
	
	| res |
	res := OrderedCollection new.
	(nodes at: anInteger) doWithIndex: [:e :i | e isNil ifFalse: [res add: i]].
	^res
]

{ #category : #private }
CallGraph >> getConnected: anInteger with: anotherInteger [
	
	^(nodes at: anInteger) at: anotherInteger
]

{ #category : #private }
CallGraph >> getIndex: termString [
	
	^nodeMapping
		at: termString
		ifAbsent: [nil]
]

{ #category : #private }
CallGraph >> initializeNodesWith: anInteger [
	
	nodes := Array new: anInteger.
	1
		to: anInteger
		do:
			[:x | 
			nodes
				at: x
				put: (Array new: anInteger)]
]

{ #category : #private }
CallGraph >> isClauseConnected: theClause with: aClause visited: aCollection [
	
	| connectedTo |
	(aCollection contains: [:x | theClause = x])
		ifTrue: [^false]
		ifFalse: [aCollection add: theClause].
	theClause = aClause ifTrue: [^true].
	connectedTo := nodeMapping at: theClause.
	^connectedTo
		contains:
			[:x | self isClauseConnected: x with: aClause visited: aCollection]
]

{ #category : #private }
CallGraph >> isConnected: aTerm withClause: aClause [
	
	| res termString clausesImplementingTerm |
	termString := aTerm functor asString , aTerm multiplicity asString.
	res := OrderedCollection new.
	clausesImplementingTerm := clauseNames
		at: termString
		ifAbsent: [^res].
	clausesImplementingTerm
		do:
			[:theClause | 
			(self
				isClauseConnected: theClause
				with: aClause
				visited: OrderedCollection new) ifTrue: [res add: theClause]].
	^res
]

{ #category : #testing }
CallGraph >> isTermConnected: aTerm withClause: aClause [
	
	| result |
	result := self isConnected: aTerm withClause: aClause.
	^result
]

{ #category : #private }
CallGraph >> processClause: aClause [
	
	aClause condition
		do: [:aTerm | self processTerm: aTerm fromClause: aClause]
]

{ #category : #private }
CallGraph >> processClauses: aCollection [
	
	aCollection do: [:aClause | self processClause: aClause]
]

{ #category : #private }
CallGraph >> processComplexTerm: aTerm fromClause: aClause [
	
	aTerm termSequence
		do: [:term | self processTerm: term fromClause: aClause]
]

{ #category : #private }
CallGraph >> processTerm: aTerm fromClause: aClause [
	
	| functor funcMul coll |
	aTerm isCompoundTerm
		ifTrue:
			[functor := aTerm functor asString.
			(#('not' 'or' 'and') contains: [:x | x = functor])
				ifTrue: [^self processComplexTerm: aTerm fromClause: aClause].
			funcMul := functor , aTerm multiplicity asString.
			coll := nodeMapping at: aClause.
			coll
				addAll:
					(clauseNames
						at: funcMul
						ifAbsent:
							[Transcript show: 'ignored unknown term in CallGraph: ' , funcMul.
							OrderedCollection new])]
]

{ #category : #'initialize-release' }
CallGraph >> withClauses: aCollection [
	
	| coll |
	nodeMapping := Dictionary new.
	clauseNames := Dictionary new.
	aCollection
		do:
			[:aClause | 
			| name |
			name := aClause conclusion functor asString
				, aClause conclusion multiplicity asString.
			coll := clauseNames
				at: name
				ifAbsent:
					[clauseNames
						at: name
						put: OrderedCollection new].
			coll add: aClause.
			nodeMapping
				at: aClause
				put: OrderedCollection new].
	self processClauses: aCollection
]
