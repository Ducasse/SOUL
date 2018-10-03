"
An EmptyListConstant is the special kind of constant to denote empty (logic) lists
"
Class {
	#name : #EmptyListConstant,
	#superclass : #Constant,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #'instance creation' }
EmptyListConstant class >> new [
	
	^super new setName: #<>
]

{ #category : #comparing }
EmptyListConstant >> = anObject [
	
	^anObject species == EmptyListConstant
]

{ #category : #visitor }
EmptyListConstant >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor emptyListConstantVisit: self
]

{ #category : #converting }
EmptyListConstant >> asDCGConditionFor: counter [
	
	| tokens1var tokens2var terminals |
	terminals := OrderedCollection new.
	self listDo: [:aTerm | terminals add: aTerm].
	tokens1var := SoulFactory current makeVariable
		name: 'tokens' , counter asString.
	tokens2var := SoulFactory current makeVariable
		name: 'tokens' , (counter + 1) asString.
	^SoulFactory current makeCompound
		functor: (Constant name: #equals)
		termSequence:
			(TermSequence terms: (OrderedCollection with: tokens1var with: tokens2var))
]

{ #category : #enumeration }
EmptyListConstant >> collectIn: anEnv startAt: anIndex [
	
	^Set new
]

{ #category : #testing }
EmptyListConstant >> isEmpty [
	
	^true
]

{ #category : #slgtesting }
EmptyListConstant >> isSLGEquivalentTo: aTerm [
	
	^aTerm isSLGEquivalentToEmptyList: self
]

{ #category : #slgtesting }
EmptyListConstant >> isSLGEquivalentToEmptyList: anEmptyListConstant [
	
	^true
]

{ #category : #enumeration }
EmptyListConstant >> listDo: aBlock [
	"see comment in ListTerm"
	
	
]

{ #category : #printing }
EmptyListConstant >> listPrintOn: aStream [
	"this method is called if we are printed inside of a list (we are an 
	emptylistconstant, so we should not be printed)"
	
	
]

{ #category : #printing }
EmptyListConstant >> prettyListPrintOn: aStream scope: id [
	"this method is called if we are printed inside of a list (we are an 
	emptylistconstant, so we should not be printed)"
	
	
]

{ #category : #printing }
EmptyListConstant >> printAsPrologListOn: aStream scope: id in: env startAt: idx [
	"this method is called if we are printed inside of a list (we are an 
	emptylistconstant, so we should not be printed)"
	
	
]

{ #category : #printing }
EmptyListConstant >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	aStream write: '[]'
]

{ #category : #printing }
EmptyListConstant >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' new'
]

{ #category : #reification }
EmptyListConstant >> soulDownIn: anEnv startAt: anIndex [
	"Down of an emptyList is the emptyList"

	
	^self
]

{ #category : #reification }
EmptyListConstant >> transitiveLookupIn: anEnv startAt: anIndex [
	"See comment in AbstractTerm"

	
	^self
]

{ #category : #unification }
EmptyListConstant >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm
		unifyWithEmptyListConstant: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not
]

{ #category : #unification }
EmptyListConstant >> unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^true
]

{ #category : #unification }
EmptyListConstant >> unifyWithSmalltalkTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aTerm unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: hisIndex
		hisIndex: myIndex inSource: inSource
]

{ #category : #unification }
EmptyListConstant >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	| val |
	val := anObject soulDownIn: anEnv startAt: hisIndex.
	^((val isKindOf: SequenceableCollection)
		and: [(val isKindOf: CharacterArray) not])
		ifTrue: [^val isEmpty]
		ifFalse:
			[^super unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex
				hisIndex: hisIndex inSource: inSource]
]

{ #category : #unification }
EmptyListConstant >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"we group all unfication with variables in the Variable class"

	
	^aVariable
		unifyWithEmptyListConstant: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]
