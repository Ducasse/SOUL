Class {
	#name : #KeywordFunctor,
	#superclass : #MultiPartFunctor,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #comparing }
KeywordFunctor >> = anObject [
	
	^(anObject isKindOf: KeywordFunctor)
		ifTrue: [anObject keywords = keywords]
		ifFalse: [super = anObject]
]

{ #category : #visitor }
KeywordFunctor >> accept: aVisitor [
	
	^aVisitor keywordFunctorVisit: self
]

{ #category : #testing }
KeywordFunctor >> isKeywordFunctor [
	
	^true
]

{ #category : #accessing }
KeywordFunctor >> multiplicity [
	
	^keywords size
]

{ #category : #unification }
KeywordFunctor >> unifyWith: otherTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^otherTerm
		unifyWithKeywordFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not
]

{ #category : #unification }
KeywordFunctor >> unifyWithKeywordFunctor: otherKeyFunctor inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	self multiplicity = otherKeyFunctor multiplicity ifFalse: [^false].
	self keywords
		with: otherKeyFunctor keywords
		do:
			[:myKey :otherKey | 
			(myKey unifyWith: otherKey inEnv: anEnv myIndex: myIndex hisIndex: hisIndex
				inSource: inSource) ifFalse: [^false]].
	^true
]

{ #category : #unification }
KeywordFunctor >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^aVariable
		unifyWithKeywordFunctor: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: inSource not
]
