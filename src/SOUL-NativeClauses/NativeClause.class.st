Class {
	#name : #NativeClause,
	#superclass : #ResolvableTerm,
	#instVars : [
		'header'
	],
	#category : 'SOUL-NativeClauses'
}

{ #category : #'instance creation' }
NativeClause class >> newWith: header [
	
	^super new initializeWith: header
]

{ #category : #visitor }
NativeClause >> accept: aVisitor [
	
	^aVisitor nativeClauseVisit: self
]

{ #category : #access }
NativeClause >> getArgument: aNumber in: anEnv startAt: anIndex [
	
	| result |
	result := anEnv
		lookup: (header terms at: aNumber)
		startAt: anIndex.
	^result
		ifNil:
			[TermPointer
				term: (header terms at: aNumber)
				envIndex: anIndex]
		ifNotNil: [result]
]

{ #category : #access }
NativeClause >> header [
	
	^header
]

{ #category : #initialize }
NativeClause >> initializeWith: head [
	
	header := head
]

{ #category : #access }
NativeClause >> isNative [
	
	^true
]

{ #category : #printing }
NativeClause >> printOn: aStream [
	
	aStream write: '***native clause***'
]

{ #category : #resolving }
NativeClause >> resolveIn: anEnv startAt: anIndex [
	
	self error: 'Nativeclause has no #resolveIn:startAt: defined!'
]

{ #category : #reification }
NativeClause >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #unification }
NativeClause >> unifyWith: aTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^aTerm
		unifyWithNativeClause: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
NativeClause >> unifyWithVariable: aVariable inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^aVariable
		unifyWithNativeClause: self
		inEnv: anEnv
		myIndex: targetIndex
		hisIndex: sourceIndex
		inSource: (inSource xor: true)
]
