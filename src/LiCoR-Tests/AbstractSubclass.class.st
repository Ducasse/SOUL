Class {
	#name : #AbstractSubclass,
	#superclass : #TestClass3,
	#category : 'LiCoR-Tests'
}

{ #category : #'instance creation' }
AbstractSubclass class >> new [
	"Answer a newly created and initialized instance."

	
	^super new initialize
]

{ #category : #testing }
AbstractSubclass >> anAbstractMethod [
	" *** This method was defined by Soul.TestClass3 as a subclass responsibility.
	Replace its body with a proper implementation. *** "

	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #testing }
AbstractSubclass >> anotherAbstractMethod [
	" *** This method was defined by Soul.TestClass3 as a subclass responsibility.
	Replace its body with a proper implementation. *** "

	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #'initialize-release' }
AbstractSubclass >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	
	super initialize.	" *** Replace this comment with the appropriate initialization code *** "

	^self
]
