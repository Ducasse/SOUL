Class {
	#name : #MessageFunctor,
	#superclass : #MultiPartFunctor,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #comparing }
MessageFunctor >> = anObject [
	
	^(anObject isKindOf: MessageFunctor)
		ifTrue: [anObject keywords = keywords]
		ifFalse: [super = anObject]
]

{ #category : #visitor }
MessageFunctor >> accept: aVisitor [
	
	^aVisitor messageFunctorVisit: self
]

{ #category : #testing }
MessageFunctor >> isMessageFunctor [
	
	^true
]

{ #category : #converting }
MessageFunctor >> messageSelector [
	"UGLY: this assumes the keyword is a constant, it might also be a variable ..."

	
	^(keywords
		inject: ''
		into: [:concatenated :keyword | concatenated , keyword name , ':'])
		asSymbol
]

{ #category : #accessing }
MessageFunctor >> multiplicity [
	
	^keywords size + 1
]

{ #category : #unification }
MessageFunctor >> unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^otherTerm unifyWithMessageFunctor: self inEnv: anEnv myIndex: hisIndex
		hisIndex: myIndex inSource: inSource
]

{ #category : #unification }
MessageFunctor >> unifyWithMessageFunctor: otherMessageFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	self multiplicity = otherMessageFunctor multiplicity ifFalse: [^false].
	self keywords
		with: otherMessageFunctor keywords
		do:
			[:myKey :otherKey | 
			(myKey unifyWith: otherKey inEnv: anEnv myIndex: myIndex hisIndex: hisIndex
				inSource: inSource) ifFalse: [^false]].
	^true
]

{ #category : #unification }
MessageFunctor >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^anObject
		unifyWithMessageFunctor: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
MessageFunctor >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aVariable
		unifyWithMessageFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not
]
