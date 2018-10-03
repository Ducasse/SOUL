Class {
	#name : #SoulReflectionLayer,
	#superclass : #LogicPrimitives,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #repositories }
SoulReflectionLayer >> bindRepositoryM2 [

bindRepository(?variable,?repository) if 
	getRepository(?rep),[?rep bind: ?variable with: ?repository.
true]
]

{ #category : #testclauses }
SoulReflectionLayer >> blaM0 [

bla if 
	go(a),!.
bla if 
	test(b)
]

{ #category : #clauses }
SoulReflectionLayer >> clauseM2 [

clause(?head,?body) if 
	clause(?head,?body,?)
]

{ #category : #terms }
SoulReflectionLayer >> deifyM2 [

deify(?var,?term) if 
	getEnv(?env,?),envLookup(?term,?termPointer),envLookup(?var,?varPointer),[| theIndex theTerm fixer |
fixer := FixVisitor new.
?termPointer term isUppedObject
	ifTrue: [theTerm := ?termPointer term soulDownIn: nil startAt: nil]
	ifFalse: [theTerm := ?termPointer term].
theTerm accept: fixer.
theIndex := ?env startUnify: fixer maxIndex + 1.
theTerm
	unifyWith: ?varPointer term
	inEnv: ?env
	myIndex: theIndex
	hisIndex: ?varPointer envIndex
	inSource: false]
]

{ #category : #repositories }
SoulReflectionLayer >> existsInRepositoryM1 [

"This predicate only works with simple predicates"

existsInRepository(?Head) if 
	getRepository(?repository),equals(?clauses,[| addr clauses mult |
addr := ?repository
	addressForPredicate: ?Head functor smalltalkValue asString.
addr == nil
	ifTrue: [#()]
	ifFalse:
		[mult := ?Head multiplicity.
		clauses := ?repository normalAddressLookup: addr multiplicity: mult.
		clauses collect: [:aClause | aClause conclusion]]]),succeeds(member(?Head,?clauses))
]

{ #category : #testclauses }
SoulReflectionLayer >> fooM0 [

foo if 
	bla,!.
foo if 
	test(b)
]

{ #category : #repositories }
SoulReflectionLayer >> getRepositoryM2 [

getRepository(?variableName,?repository) if 
	getRepository(?rep),equals(?repository,[?rep lookupBindingFor: ?variableName])
]

{ #category : #testclauses }
SoulReflectionLayer >> goM1 [

go(b)
]

{ #category : #terms }
SoulReflectionLayer >> newVarM1 [

"Create a new variable on the stack at runtime. This is useful if a new variable needs to be created that was not there at compile time"

newVar(?x) if 
	var(?x),getEnv(?env,?),envLookup(?x,?xpointer),[| startIndex variable |
startIndex := ?env startUnify: 1.
variable := HiddenVariable name: SoulFactory uniqueName.
variable setAddress: 0.
variable
	unifyWith: ?xpointer term
	inEnv: ?env
	myIndex: startIndex
	hisIndex: ?xpointer envIndex
	inSource: true.
true]
]

{ #category : #terms }
SoulReflectionLayer >> newVarM2 [

"Create a new variable on the stack at runtime. This is useful if a new variable needs to be created that was not there at compile time"

newVar(?name,?x) if 
	var(?x),getEnv(?env,?),envLookup(?x,?xpointer),[| startIndex variable |
startIndex := ?env startUnify: 1.
variable := HiddenVariable name: ?name , SoulFactory uniqueCounter asString.
variable setAddress: 0.
variable
	unifyWith: ?xpointer term
	inEnv: ?env
	myIndex: startIndex
	hisIndex: ?xpointer envIndex
	inSource: true.
true]
]

{ #category : #repositories }
SoulReflectionLayer >> repositoryM1 [

"repository(?rep)"

repository(?rep) if 
	member(?rep,[SoulFactory repositoryNames collect: [:name | SoulFactory repository: name]])
]

{ #category : #repositories }
SoulReflectionLayer >> repositoryNameM2 [

"repositoryName(?rep,?name)"

repositoryName(?rep,?name) if 
	repository(?rep),equals(?name,[?rep name])
]

{ #category : #repositories }
SoulReflectionLayer >> resetRepositoryNamedM1 [

"resetRepositoryNamed(LogicRoot)

resets a given repository"

resetRepositoryNamed(+?repositoryName) if 
	repositoryName(?rep,?repositoryName),[?rep reset.
true]
]

{ #category : #testclauses }
SoulReflectionLayer >> testM1 [

test(b)
]
