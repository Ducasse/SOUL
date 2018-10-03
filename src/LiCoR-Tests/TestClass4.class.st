Class {
	#name : #TestClass4,
	#superclass : #TestClassRoot,
	#category : 'LiCoR-Tests'
}

{ #category : #'methods that reference classes' }
TestClass4 >> bar [
	
	^Set new
]

{ #category : #'methods that reference classes' }
TestClass4 >> foo [
	
	^Array new
]

{ #category : #'methods that reference classes' }
TestClass4 >> fooFullReference [
	
	^Array new
]

{ #category : #'methods that reference classes' }
TestClass4 >> zork [
	
	^Set new: (OrderedCollection with: Array)
]
