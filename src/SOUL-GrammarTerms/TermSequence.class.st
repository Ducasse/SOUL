"
This class is used to represent sequences of terms inside compoundterms, lists, etc...

Instance Variables:
	collection	<(LinkedList of: AbstractTerm) | (List of: AbstractTerm) | (OrderedCollection of: AbstractTerm) | (RunArray of: AbstractTerm) | (SlidingInterval of: AbstractTerm)>	description of collection
	containsCut	<Boolean>	description of containsCut


"
Class {
	#name : #TermSequence,
	#superclass : #AbstractTerm,
	#instVars : [
		'collection',
		'containsCut'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
TermSequence class >> new [
	
	^self terms: OrderedCollection new
]

{ #category : #'instance creation' }
TermSequence class >> term: term [
	
	^self terms: (OrderedCollection with: term)
]

{ #category : #'instance creation' }
TermSequence class >> term: term1 term: term2 [
	
	^self terms: (OrderedCollection with: term1 with: term2)
]

{ #category : #'instance creation' }
TermSequence class >> term: term1 term: term2 term: term3 [
	
	^self terms: (OrderedCollection with: term1 with: term2 with: term3)
]

{ #category : #'instance creation' }
TermSequence class >> term: term1 term: term2 term: term3 term: term4 [
	
	^self
		terms:
			(OrderedCollection with: term1 with: term2 with: term3 with: term4)
]

{ #category : #'instance creation' }
TermSequence class >> terms: aCollection [
	
	^self terms: aCollection containsCut: false
]

{ #category : #'instance creation' }
TermSequence class >> terms: aCollection containsCut: boolean [
	
	^super new setTerms: aCollection containsCut: boolean
]

{ #category : #visitor }
TermSequence >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor termSequenceVisit: self
]

{ #category : #parsing }
TermSequence >> addChildrenFirst: aChild [
	"used by the parser"

	
	^collection addFirst: aChild first
]

{ #category : #parsing }
TermSequence >> addChildrenInitial: aCollection [
	"used by the parser"

	
	collection := aCollection
]

{ #category : #parsing }
TermSequence >> addTermFirst: aTerm [
	"used by the parser"

	
	(aTerm isKindOf: Cut) ifTrue: [containsCut := true].
	self terms addFirst: aTerm
]

{ #category : #access }
TermSequence >> containsCut [
	
	^containsCut
]

{ #category : #access }
TermSequence >> containsCut: boolean [
	
	containsCut := boolean
]

{ #category : #enumeration }
TermSequence >> do: aBlock [
	
	collection do: aBlock
]

{ #category : #enumeration }
TermSequence >> do: aBlock separatedBy: block2 [
	
	collection do: aBlock separatedBy: block2
]

{ #category : #slgtesting }
TermSequence >> isSLGEquivalentTo: aTerm [
	
	^aTerm isSLGEquivalentToTermSequence: self
]

{ #category : #slgtesting }
TermSequence >> isSLGEquivalentToTermSequence: aTermSequence [
	
	| myTerms otherTerms otherTerm |
	myTerms := self terms.
	otherTerms := aTermSequence terms.
	myTerms size = otherTerms size ifFalse: [^false].
	myTerms
		doWithIndex:
			[:term :index | 
			otherTerm := otherTerms at: index.
			(term isSLGEquivalentTo: otherTerm) ifFalse: [^false]].	"even when all the individual terms match we still need to check cases like this:
	path(?X,?Y) vs path(?X,?X). The first one gives every path, the latter should return cycles"

	^(aTermSequence isVariantOf: self) and: [self isVariantOf: aTermSequence]
]

{ #category : #slgtesting }
TermSequence >> isVariantOf: aTermSequence [
	"we assume that both sequences are already SLGEquivalent"

	
	| myTerms otherTerms otherTerm dict |
	myTerms := self terms.
	otherTerms := aTermSequence terms.
	dict := Dictionary new.
	myTerms
		doWithIndex:
			[:term :index | 
			otherTerm := otherTerms at: index.
			term isVariable
				ifTrue:
					[dict
						at: term name
						ifAbsent:
							[dict
								at: term name
								put: otherTerm name].
					dict
						at: term name
						ifPresent: [:name | name = otherTerm name ifFalse: [^false]]]].
	^true
]

{ #category : #printing }
TermSequence >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractTerm"

	
	id = #asClause
		ifTrue:
			[aStream tab.
			collection
				do: [:term | term prettyPrintOn: aStream scope: #asClause]
				separatedBy:
					[aStream write: ','.
					aStream crtab]]
		ifFalse:
			[collection
				do: [:term | term prettyPrintOn: aStream scope: #asTerm]
				separatedBy: [aStream write: ',']]
]

{ #category : #printing }
TermSequence >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	id = #asClause
		ifTrue:
			[collection
				do:
					[:term | term printAsPrologOn: aStream scope: #asClause in: env startAt: idx]
				separatedBy:
					[aStream write: ','.
					aStream crtab]]
		ifFalse:
			[collection
				do:
					[:term | term printAsPrologOn: aStream scope: #asTerm in: nil startAt: nil]
				separatedBy: [aStream write: ',']]
]

{ #category : #printing }
TermSequence >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' terms: (OrderedCollection new '.
	self terms
		do:
			[:currentClause | 
			aStream write: 'add:('.
			currentClause printForCompileOn: aStream.
			aStream write: ')']
		separatedBy: [aStream write: ';'].
	aStream write: ';yourself) containsCut: ' , self containsCut asString
]

{ #category : #printing }
TermSequence >> printOn: aStream [
	"see comment in AbstractTerm"

	
	collection
		do: [:term | term printOn: aStream]
		separatedBy: [aStream write: ',']
]

{ #category : #scoping }
TermSequence >> recursiveDefinitionRepository: aRepository [
	
	self definitionRepository: aRepository.
	collection do: [:each | each recursiveDefinitionRepository: aRepository]
]

{ #category : #enumeration }
TermSequence >> reverseDo: aBlock [
	
	collection reverseDo: aBlock
]

{ #category : #initialize }
TermSequence >> setTerms: aCollection containsCut: aBoolean [
	
	collection := aCollection.
	containsCut := aBoolean
]

{ #category : #access }
TermSequence >> size [
	
	^collection size
]

{ #category : #reification }
TermSequence >> soulDownIn: anEnv startAt: anIndex [
	
	^TermSequence
		terms:
			(collection
				collect:
					[:aSubTerm | (aSubTerm soulDownIn: anEnv startAt: anIndex) soulUp])
		containsCut: containsCut
]

{ #category : #reification }
TermSequence >> soulUp: anEnv [
	
	^self
]

{ #category : #access }
TermSequence >> terms [
	
	^collection
]

{ #category : #access }
TermSequence >> terms: aCollection [
	
	collection := aCollection
]

{ #category : #reification }
TermSequence >> transitiveLookupIn: anEnv startAt: anIndex [
	
	| newSubTerms |
	newSubTerms := OrderedCollection new.
	self
		do:
			[:aTerm | newSubTerms add: (aTerm transitiveLookupIn: anEnv startAt: anIndex)].
	^self class
		terms: newSubTerms
		containsCut: self containsCut
]

{ #category : #unification }
TermSequence >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithTermSequence: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
TermSequence >> unifyWithTermSequence: other inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"transfered"

	
	collection size = other terms size ifFalse: [^false].
	collection
		with: other terms
		do:
			[:myTerm :otherTerm | 
			(myTerm unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex:
					hisIndex inSource: inSource) ifFalse: [^false]].
	^true
]

{ #category : #access }
TermSequence >> usesPredicate: aPredicate multiplicity: aNumber [
	
	collection
		do:
			[:aTerm | (aTerm usesPredicate: aPredicate multiplicity: aNumber) ifTrue: [^true]].
	^false
]
