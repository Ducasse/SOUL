Class {
	#name : #TestClass5,
	#superclass : #TestClassRoot,
	#category : 'LiCoR-Tests'
}

{ #category : #'commented methods' }
TestClass5 >> commentedMethod0 [
	
	^'This method has no comment'
]

{ #category : #'commented methods' }
TestClass5 >> commentedMethod1 [
	"This method has one comment"

	
	^'This method has one comment'
]

{ #category : #'commented methods' }
TestClass5 >> commentedMethod3 [
	
	| a  b | 
	"Smalltalk"
	^ 3 + 4 + 5 + 6 + 7	"is" 	"fun" 
]

{ #category : #protocol3 }
TestClass5 >> method6 [
	
	^ThisIsAGlobalVariableThatDoesNotReferenceAClass new
]

{ #category : #'todo methods' }
TestClass5 >> todoMethod1 [
	"TODO: Do not implement anything in this method."

	
	^3
]

{ #category : #'todo methods' }
TestClass5 >> todoMethod2 [
	
	self todo: 'Do not implement anything in this method.'.
	^5
]

{ #category : #'todo methods' }
TestClass5 >> todoMethod3 [
	"TODO: Do nothing."

	"TODO"

	
	self todo: 'Do nothing more.'
]
