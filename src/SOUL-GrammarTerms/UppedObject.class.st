"
This class is used to represent smalltalk objects in a logic program (and in the logic parsetree)

"
Class {
	#name : #UppedObject,
	#superclass : #ResolvableTerm,
	#instVars : [
		'smalltalkValue'
	],
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
UppedObject class >> up: anObject [
	
	^self new setSmalltalkValue: anObject
]

{ #category : #comparing }
UppedObject >> = anObject [
	
	^(anObject isKindOf: UppedObject)
		ifTrue: [anObject smalltalkValue = self smalltalkValue]
		ifFalse: [super = anObject]
]

{ #category : #visitor }
UppedObject >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor objectVisit: self
]

{ #category : #converting }
UppedObject >> asDCGConclusionWithSize: aSize [
	
	^SoulFactory current makeCompound
		functor: self
		termSequence:
			(TermSequence
				terms:
					(OrderedCollection
						with: (SoulFactory current makeVariable name: 'tokens1')
						with: (SoulFactory current makeVariable name: 'tokens' , aSize asString)))
]

{ #category : #converting }
UppedObject >> asDCGConditionFor: counter [
	
	| terms |
	terms := OrderedCollection new.
	terms
		add: (SoulFactory current makeVariable name: 'tokens' , counter asString).
	terms
		add:
			(SoulFactory current makeVariable name: 'tokens' , (counter + 1) asString).
	^SoulFactory current makeCompound
		functor: self
		termSequence: (TermSequence terms: terms)
]

{ #category : #converting }
UppedObject >> asPredicateNameInEnv: anEnv startAt: anIndex [
	
	^smalltalkValue asString
]

{ #category : #converting }
UppedObject >> asSourceStringIn: anEnv startAt: anIndex [
	
	^smalltalkValue asSourceString
]

{ #category : #printing }
UppedObject >> displayString [
	
	^smalltalkValue displayString
]

{ #category : #slgtesting }
UppedObject >> isSLGEquivalentTo: aTerm [
	
	^aTerm isSLGEquivalentToUppedObject: self
]

{ #category : #slgtesting }
UppedObject >> isSLGEquivalentToUppedObject: anUppedObject [
	^anUppedObject = self
]

{ #category : #testing }
UppedObject >> isUppedObject [
	
	^true
]

{ #category : #printing }
UppedObject >> listPrintOn: aStream [
	"this method is called if we are printed inside a list"

	
	aStream write: ','.
	self printOn: aStream
]

{ #category : #printing }
UppedObject >> prettyPrintAsFunctorOn: aStream scope: id [
	
	id = #asClause
		ifTrue:
			[aStream withAttribute:(TextEmphasis bold) do:[aStream write: smalltalkValue asString]] ifFalse:[aStream write: smalltalkValue asString.]
]

{ #category : #printing }
UppedObject >> prettyPrintAsKeywordOn: aStream scope: id [
	
	id = #asClause
		ifTrue:
			[aStream withAttribute:(TextEmphasis bold) do:[aStream write: smalltalkValue asString]] ifFalse:[aStream write: smalltalkValue asString.]
]

{ #category : #printing }
UppedObject >> printAsFunctorOn: aStream [
	
	aStream nextPutAll: smalltalkValue asString
]

{ #category : #printing }
UppedObject >> printAsPrologListOn: aStream scope: scope in: env startAt: idx [
	"this method is called if we are printed inside a list"

	
	aStream write: ','.
	self printAsPrologOn: aStream scope: scope in: env startAt: idx
]

{ #category : #printing }
UppedObject >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	smalltalkValue printAsPrologOn: aStream scope: id in: env startAt: idx
]

{ #category : #printing }
UppedObject >> printOn: aStream [
	"see comment in QSOULAbstractTerm"

	
	aStream write: '['.
	smalltalkValue printOn: aStream.
	aStream write: ']'
]

{ #category : #resolving }
UppedObject >> resolveIn: anEnv startAt: anIndex [
	
	| resolveBlock resolveBlockArgs |
	resolveBlockArgs := OrderedCollection new.
	resolveBlockArgs add: nil.
	resolveBlock := [:arg | 
	(self smalltalkValue isKindOf: Boolean)
		ifFalse:
			[self error: 'SmallTalkClauses should always evaluate to true or false!'].
	self smalltalkValue
		ifTrue:
			[ResolutionResult
				condition: SoulFactory current makeTermSequence new
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]].
	^NativeResolver onBlock: resolveBlock withArguments: resolveBlockArgs
]

{ #category : #initialize }
UppedObject >> setSmalltalkValue: anObject [
	
	smalltalkValue := anObject
]

{ #category : #access }
UppedObject >> smalltalkValue [
	
	^smalltalkValue
]

{ #category : #reification }
UppedObject >> soulDownIn: anEnv startAt: anIndex [
	"downing an uppedObject to the SmallTalk environment is returning my  
	wrapped value"

	
	^smalltalkValue
]

{ #category : #reification }
UppedObject >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #unification }
UppedObject >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	
	^aTerm
		unifyWithUppedObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
UppedObject >> unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^(smalltalkValue isKindOf: SequenceableCollection)
		and: [smalltalkValue isEmpty]
]

{ #category : #unification }
UppedObject >> unifyWithKeywordFunctor: term inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^self smalltalkValue asString = term asString
]

{ #category : #unification }
UppedObject >> unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| list |
	^((smalltalkValue isKindOf: SequenceableCollection)
		and: [(smalltalkValue isKindOf: CharacterArray) not])
		ifTrue:
			[list := ListTerm newFromCollection: smalltalkValue.
			list unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex:
					hisIndex inSource: inSource]
		ifFalse: [false]
]

{ #category : #unification }
UppedObject >> unifyWithMessageFunctor: term inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^self smalltalkValue asString = term asString
]

{ #category : #unification }
UppedObject >> unifyWithQuotedCodeTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm
		unifyWithUppedObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not
]

{ #category : #unification }
UppedObject >> unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with a SmallTalkTerm if the result of this smalltalkterm unifies 
	with me"

	
	^self
		unifyWithUppedObject:
			(anSTTerm soulDownIn: anEnv startAt: hisIndex) soulUp
		inEnv: anEnv
		myIndex: myIndex
		hisIndex: hisIndex
		inSource: inSource
]

{ #category : #unification }
UppedObject >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with another object if my downed versions are equal"

	
	^(self soulDownIn: anEnv startAt: myIndex)
		= (anObject soulDownIn: anEnv startAt: hisIndex)
]

{ #category : #unification }
UppedObject >> unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	| list |
	^((smalltalkValue isKindOf: SequenceableCollection)
		and: [(smalltalkValue isKindOf: String) not])
		ifTrue:
			[list := ListTerm newFromCollection: smalltalkValue.
			list unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex:
					sourceIndex hisIndex: targetIndex inSource: inSource]
		ifFalse: [false]
]

{ #category : #unification }
UppedObject >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithUppedObject: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #access }
UppedObject >> usesPredicate: aPredicate multiplicity: aNumber [
	
	^false
]
