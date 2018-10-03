Class {
	#name : #UnaryMessageFunctor,
	#superclass : #AbstractTerm,
	#instVars : [
		'message'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
UnaryMessageFunctor class >> message: message [
	
	^self new message: message
]

{ #category : #'instance creation' }
UnaryMessageFunctor class >> name: aName [
	
	^self message: (SoulFactory current makeConstant name: aName)
]

{ #category : #visitor }
UnaryMessageFunctor >> accept: aVisitor [
	
	^aVisitor unaryMessageFunctorVisit: self
]

{ #category : #converting }
UnaryMessageFunctor >> asPredicateNameInEnv: anEnv startAt: idx [
	
	^message asPredicateNameInEnv: anEnv startAt: idx
]

{ #category : #testing }
UnaryMessageFunctor >> isUnaryMessageFunctor [
	
	^true
]

{ #category : #accessing }
UnaryMessageFunctor >> message [
	
	^message
]

{ #category : #initialization }
UnaryMessageFunctor >> message: msg [
	
	message := msg
]

{ #category : #converting }
UnaryMessageFunctor >> messageSelector [
	
	^message name asSymbol
]

{ #category : #accessing }
UnaryMessageFunctor >> multiplicity [
	
	^1
]

{ #category : #accessing }
UnaryMessageFunctor >> name [
	
	^self message name
]

{ #category : #printing }
UnaryMessageFunctor >> prettyPrintOn: aStream scope: id [
	
	| temp attributes|
	attributes := OrderedCollection with:(TextColor black).
	id = #asClause
		ifTrue:
			[attributes add:TextEmphasis bold].
	aStream withAttributes: attributes do: [self printOn: aStream].
	
]

{ #category : #printing }
UnaryMessageFunctor >> printAsPrologFunctorOn: aStream scope: id in: env startAt: idx [
	"TODO: What if it is a variable?"

	
	aStream write: self name
]

{ #category : #printing }
UnaryMessageFunctor >> printForCompileOn: aStream [
	
	aStream write: self class name , ' message: ('.
	message printForCompileOn: aStream.
	aStream write: ')'
]

{ #category : #printing }
UnaryMessageFunctor >> printOn: aStream [
	
	^message printOn: aStream
]

{ #category : #scoping }
UnaryMessageFunctor >> recursiveDefinitionRepository: repository [
	
	super recursiveDefinitionRepository: repository.
	message recursiveDefinitionRepository: repository
]

{ #category : #reification }
UnaryMessageFunctor >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self class message: (message transitiveLookupIn: anEnv startAt: anIndex)
]

{ #category : #unification }
UnaryMessageFunctor >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm
		unifyWithUnaryMessageFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
UnaryMessageFunctor >> unifyWithUnaryMessageFunctor: unaryFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"transfered"

	
	^self message
		unifyWith: unaryFunctor message
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource
]

{ #category : #unification }
UnaryMessageFunctor >> unifyWithUppedObject: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm
		unifyWithUnaryMessageFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
UnaryMessageFunctor >> unifyWithVariable: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm
		unifyWithUnaryMessageFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]
