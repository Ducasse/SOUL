Class {
	#name : #TermPointer,
	#superclass : #Object,
	#instVars : [
		'envIndex',
		'term',
		'nextTerm'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
TermPointer class >> term: aTerm envIndex: anEnvIndex [
	
	^self new term: aTerm envIndex: anEnvIndex
]

{ #category : #'instance creation' }
TermPointer class >> term: aTerm envIndex: anEnvIndex nextTerm: aTermPointer [
	
	^self new term: aTerm envIndex: anEnvIndex nextTerm: aTermPointer
]

{ #category : #printing }
TermPointer >> displayString [
	
	^term displayString
]

{ #category : #access }
TermPointer >> envIndex [
	
	^envIndex
]

{ #category : #access }
TermPointer >> nextTerm [
	
	^nextTerm
]

{ #category : #access }
TermPointer >> nextTerm: anObject [
	
	nextTerm := anObject
]

{ #category : #printing }
TermPointer >> printOn: aStream [
	
	(term species == Environment
		or:
			[(term isKindOf: UppedObject)
				and: [term smalltalkValue species == Environment]])
		ifTrue: [aStream write: '**env**']
		ifFalse: [term printOn: aStream].
	aStream write: ' @ '.
	envIndex printOn: aStream.
	aStream write: ':'.
	nextTerm printOn: aStream
]

{ #category : #resolving }
TermPointer >> resolveIn: anEnv [
	
	^term resolveIn: anEnv startAt: envIndex
]

{ #category : #access }
TermPointer >> term [
	
	^term
]

{ #category : #initialize }
TermPointer >> term: aTerm envIndex: anEnvIndex [
	
	term := aTerm.
	envIndex := anEnvIndex
]

{ #category : #initialize }
TermPointer >> term: aTerm envIndex: anEnvIndex nextTerm: aTermPointer [
	
	term := aTerm.
	envIndex := anEnvIndex.
	nextTerm := aTermPointer
]
