"
It is important for the tests that TestClass1 declares the following instance variables:
	array	<SequenceableCollection>
	iv1		<ArithmeticValue | CPointer>
	iv2		<Object>
and that its meta class declares the following instance variables:
	mcivar1	<Object>
Do not change (i.e. remove or rename) any of these variables!

"
Class {
	#name : #TestClass1,
	#superclass : #TestClassRoot,
	#instVars : [
		'iv1',
		'iv2',
		'array'
	],
	#classVars : [
		'CV1',
		'CV2',
		'Waiting'
	],
	#classInstVars : [
		'mcivar1'
	],
	#category : 'LiCoR-Tests'
}

{ #category : #'instance creation' }
TestClass1 class >> withDefaultName [
	
	^self withName: 'Dummy name for testing indirect creation'
]

{ #category : #'instance creation' }
TestClass1 class >> withName: aString [
	
	^self new name: aString
]

{ #category : #accessing }
TestClass1 >> array [
	"An accessor for the instance variable array. Added for the typing tests (#typeByAccessor needs an accessor)"

	
	^array
]

{ #category : #accessing }
TestClass1 >> array: anArray [
	"A mutator for the instance variable array. Added for the typing tests (#typeByAssignment needs a mutator)"

	
	array := anArray
]

{ #category : #protocol1 }
TestClass1 >> method1 [
	
	^self method2: 3
]

{ #category : #protocol1 }
TestClass1 >> method2: anInteger [
	
	^anInteger
]

{ #category : #protocol2 }
TestClass1 >> method3: arg [
	
	^self method1
		ifTrue: [arg first]
		ifFalse: [arg asSet]
]

{ #category : #protocol2 }
TestClass1 >> method4 [
	"Added for the typing tests. The assigment should be detected when using #typeByExactAssignment. The messages send to array can be used by #typeBySend."

	
	array := Array new.
	array at: 1 put: $a.
	^array first
]

{ #category : #protocol2 }
TestClass1 >> method5 [
	"Added for the typing tests. Uses a mutator to set array to a new instance of SegmentedCollection. Sends messages to the accessor array to test #typeByAccessorSend."

	
	self array: SegmentedCollection new.
	self array at: 1 put: $b.
	^self array first
]

{ #category : #accessing }
TestClass1 >> sumWith: anInteger [
	"Just to have some methods that are sent to iv1"

	
	^iv1 + anInteger
]

{ #category : #accessing }
TestClass1 >> withShadowing [
	
	| array |
	array := 3.
	^array + 1
]
