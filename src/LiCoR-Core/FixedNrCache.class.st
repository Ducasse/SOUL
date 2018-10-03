"
I contain the protocol for a general cache, in which it is possible to add elements under a certain key, to check whether elements/keys are contained, or to remove elements/keys
"
Class {
	#name : #FixedNrCache,
	#superclass : #Model,
	#instVars : [
		'elements',
		'order',
		'maxSize'
	],
	#category : 'LiCoR-Core'
}

{ #category : #'adding-removing' }
FixedNrCache >> at: aKey ifAbsentPut: elementCreationBlock [
	"If it exists, return the element from the cache. If it doesn't not exist, evaluate the 
	block and add abd return the element it describes"

	
	| element |
	^(self includesKey: aKey)
		ifTrue: [self basicAt: aKey]
		ifFalse:
			[self
				at: aKey
				put: (element := elementCreationBlock value).
			element]
]

{ #category : #'adding-removing' }
FixedNrCache >> at: aKey put: anElement [
	"add anElement, possibly after first removing another element (depending on the policy used)"

	
	self preAdd: anElement.
	self basicAt: aKey put: anElement
]

{ #category : #private }
FixedNrCache >> basicAt: aKey [
	
	^self elements
		at: aKey
		ifAbsent:
			[self halt: 'Element Does not Exists in Cache... '.
			^self]
]

{ #category : #private }
FixedNrCache >> basicAt: aKey put: anElement [
	"Add the element to the cache under the given key. Also keep track of the order 
	(add aKey to the end of order)"

	
	self elements at: aKey put: anElement.
	self order add: aKey
]

{ #category : #private }
FixedNrCache >> basicRemoveKey: aKey [
	"remove aKey from the receiver. Assume it exists. Also remove it from the order"

	
	self elements removeKey: aKey.
	self order remove: aKey
]

{ #category : #'adding-removing' }
FixedNrCache >> clear [
	"clear the contents of the receiver"

	
	self elements keys copy do: [:key | self basicRemoveKey: key].
	order := nil
]

{ #category : #accessing }
FixedNrCache >> currentSize [
	"return the current size of the receiver"

	
	^self elements size
]

{ #category : #defaults }
FixedNrCache >> defaultMaxSize [
	
	^self class defaultMaxSize
]

{ #category : #'private-accessing' }
FixedNrCache >> elements [
	
	^elements isNil
		ifTrue: [elements := self elementsClass new]
		ifFalse: [elements]
]

{ #category : #defaults }
FixedNrCache >> elementsClass [
	
	^Dictionary
]

{ #category : #testing }
FixedNrCache >> includes: anElement [
	"returns true if anElement is in the cache, and false otherwise."

	
	^self elements includes: anElement
]

{ #category : #testing }
FixedNrCache >> includesKey: aKey [
	"returns true if an the given key is in the cache, and false otherwise."

	
	^self elements includesKey: aKey
]

{ #category : #private }
FixedNrCache >> isRemovalNecessaryFor: anElement [
	"return whether it is necessary to remove 1 or more elements before adding the 
	argument"

	
	^self elements size >= self maxSize
]

{ #category : #private }
FixedNrCache >> keyFor: anElement [
	"return the key for anElement. Assume anElement exists"

	
	^self elements keyAtValue: anElement
]

{ #category : #'private-accessing' }
FixedNrCache >> maxSize [
	
	^maxSize isNil
		ifTrue: [maxSize := self defaultMaxSize]
		ifFalse: [maxSize]
]

{ #category : #'private-accessing' }
FixedNrCache >> maxSize: aNumber [
	"set the maximum size to the argument. If necessary, shorten the current 
	elements to accomodate this new maximum size"

	
	maxSize := aNumber.
	[self currentSize > self maxSize] whileTrue: [self removeOldest]
]

{ #category : #'private-accessing' }
FixedNrCache >> order [
	"return the order. This is an OrderedCollection containing the order in which 
	keys were added"

	
	^order isNil
		ifTrue: [order := self orderClass new]
		ifFalse: [order]
]

{ #category : #defaults }
FixedNrCache >> orderClass [
	
	^OrderedCollection
]

{ #category : #private }
FixedNrCache >> preAdd: anElement [
	"perform the necessary changes in the structure knowing that anElement is 
	going to be added. Do not add this element yet !"

	
	(self isRemovalNecessaryFor: anElement)
		ifTrue:
			["remove an element to make room for the one that is going to be added"

			self removeFor: anElement]
]

{ #category : #'adding-removing' }
FixedNrCache >> remove: anElement [
	"remove the element from the cache, if it exists. If it does not exist, do nothing"

	
	self removeKey: (self keyFor: anElement)
]

{ #category : #private }
FixedNrCache >> removeFor: anElement [
	"called if it is necessary to make room for a new elements that is going to be 
	added. Do not do an empty check, because the elements are not empty (or 
	this method would not have been called)"

	
	self removeOldest
]

{ #category : #'adding-removing' }
FixedNrCache >> removeKey: aKey [
	"remove the key from the cache, if it exists. If it does not exist, do nothing"

	
	(self includesKey: aKey) ifTrue: [self basicRemoveKey: aKey]
]

{ #category : #private }
FixedNrCache >> removeOldest [
	"remove the oldest element added (this could mean different things according 
	to the policy of the cache)"

	"By default I take the oldest key (the first one added), and remove it and its 
	value from the cache"

	
	self basicRemoveKey: self order first
]

{ #category : #'adding-removing' }
FixedNrCache >> replace: oldElement with: newElement [
	"find and replace oldElement with newElement (if it exists; otherwise do nothing)"

	
	(self includes: oldElement)
		ifTrue:
			[self
				at: (self keyFor: oldElement)
				put: newElement]
]
