Class {
	#name : #FakeSingleItemCollection,
	#superclass : #Object,
	#instVars : [
		'item'
	],
	#category : 'SOUL-SmalltalkSymbiosis'
}

{ #category : #'instance creation' }
FakeSingleItemCollection class >> on: anItem [
	
	^(anItem isKindOf: Boolean)
		ifTrue:
			[anItem	"Because of an optimisation in the VM for booleans and ifTrue:ifFalse:, the FakeSingleItemCollection trick doesn't work well for booleans, so just return the boolean and hope the programmer doesnt want to send collection messages to it :)"
]
		ifFalse: [self new zzzOn: anItem]
]

{ #category : #'collection faking' }
FakeSingleItemCollection >> allSatisfy: test [
	
	^test value: item
]

{ #category : #'collection faking' }
FakeSingleItemCollection >> at: idx [
	
	^idx = 1
		ifTrue: [item]
		ifFalse: [self error: 'collection contains only one element']
]

{ #category : #'collection faking' }
FakeSingleItemCollection >> do: aBlock [
	
	aBlock value: item
]

{ #category : #'message forwarding' }
FakeSingleItemCollection >> doesNotUnderstand: aMessage [
	^item
		perform: aMessage selector
		withArguments: aMessage arguments
]

{ #category : #'collection faking' }
FakeSingleItemCollection >> first [
	
	^item
]

{ #category : #initialization }
FakeSingleItemCollection >> zzzOn: anItem [
	
	item := anItem
]
