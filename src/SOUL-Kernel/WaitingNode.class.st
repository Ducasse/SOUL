Class {
	#name : #WaitingNode,
	#superclass : #Object,
	#instVars : [
		'callId',
		'variables',
		'delayedPrimitives',
		'delayedNegatedPrimitives',
		'continuation'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
WaitingNode class >> callId: aNumber variables: aString delayedPrimitives: aCollection delayedNegatedPrimitives: anotherCollection continuation: anotherString [
	
	^self new callId: aNumber variables: aString delayedPrimitives:
			aCollection delayedNegatedPrimitives: anotherCollection continuation:
			anotherString
]

{ #category : #accessing }
WaitingNode >> callId [
	
	^callId
]

{ #category : #'initialize-release' }
WaitingNode >> callId: aNumber variables: aString delayedPrimitives: aCollection delayedNegatedPrimitives: anotherCollection continuation: anotherString [
	
	callId := aNumber.
	variables := aString.
	delayedPrimitives := aCollection.
	delayedNegatedPrimitives := anotherCollection.
	continuation := anotherString
]

{ #category : #accessing }
WaitingNode >> continuation [
	
	^continuation
]

{ #category : #accessing }
WaitingNode >> delayedNegatedPrimitives [
	
	^delayedNegatedPrimitives
]

{ #category : #accessing }
WaitingNode >> delayedPrimitives [
	
	^delayedPrimitives
]

{ #category : #accessing }
WaitingNode >> variables [
	
	^variables
]
