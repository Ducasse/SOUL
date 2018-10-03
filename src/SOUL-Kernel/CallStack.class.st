Class {
	#name : #CallStack,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'currentIndex'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
CallStack class >> new [
	
	^(super new: 6000) initialize
]

{ #category : #'instance creation' }
CallStack class >> newFrom: aStack [
	
	^self new initializeFrom: aStack
]

{ #category : #printing }
CallStack >> asFrameList [
	
	| list |
	list := List new.
	(1 to: currentIndex - 1) do: [:index | list add: (self at: index)].
	^list reverse
]

{ #category : #copying }
CallStack >> clone [
	
	^self class newFrom: self
]

{ #category : #access }
CallStack >> cut [
	
	| frame |
	[frame := self pop.
	frame isEmpty
		ifFalse: [frame cuttop]
		ifTrue:
			[self push: frame.
			true]] whileFalse
]

{ #category : #'initialize-release' }
CallStack >> initialize [
	
	currentIndex := 1
]

{ #category : #'initialize-release' }
CallStack >> initializeFrom: aStack [
	
	currentIndex := aStack size + 1.
	(1 to: currentIndex - 1)
		do:
			[:i | 
			self
				at: i
				put: (aStack at: i)]
]

{ #category : #testing }
CallStack >> isEmpty [
	
	^currentIndex == 1
]

{ #category : #access }
CallStack >> pop [
	
	currentIndex := currentIndex - 1.
	^self at: currentIndex
]

{ #category : #printing }
CallStack >> printOn: aStream [
	
	aStream
		print: self class;
		nextPutAll: ' ['.
	(1 to: currentIndex - 1)
		do: [:index | (self at: index) printOn: aStream]
		separatedBy: [aStream nextPutAll: ', '].
	aStream nextPut: $]
]

{ #category : #access }
CallStack >> push: anElement [
	
	self at: currentIndex put: anElement.
	currentIndex := currentIndex + 1
]

{ #category : #access }
CallStack >> size [
	
	^currentIndex - 1
]

{ #category : #access }
CallStack >> top [
	
	^self at: currentIndex - 1
]
