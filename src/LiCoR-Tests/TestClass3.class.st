"
It is important for the tests that this class does not implement any instance variables,
nor does its meta class. Do not add any!

Subclasses must implement the following messages:
	testing
		anAbstractMethod
		anotherAbstractMethod


"
Class {
	#name : #TestClass3,
	#superclass : #TestClassRoot,
	#category : 'LiCoR-Tests'
}

{ #category : #testing }
TestClass3 >> aMethod1 [
	"Do not change the implementation of this method. It is used for testing!"

	
	self anAbstractMethod
]

{ #category : #testing }
TestClass3 >> aMethod2 [
	"Do not change the implementation of this method. It is used for testing!"

	
	self anotherAbstractMethod
]

{ #category : #testing }
TestClass3 >> aMethod3 [
	"Do not change the implementation of this method. It is used for testing!"

	
	self anUnimplementedMethod
]

{ #category : #testing }
TestClass3 >> aMethod4 [
	"Do not change the implementation of this method. It is used for testing!"

	
	self danglingMethodCall
]

{ #category : #testing }
TestClass3 >> anAbstractMethod [
	"Do not change the implementation of this method. It is used for testing!"

	
	self subclassResponsibility
]

{ #category : #testing }
TestClass3 >> anUnimplementedMethod [
	"Do not change the implementation of this method. It is used for testing!"

	
	self shouldNotImplement
]

{ #category : #testing }
TestClass3 >> anotherAbstractMethod [
	"Do not change the implementation of this method. It is used for testing!"

	
	^self subclassResponsibility
]
