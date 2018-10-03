Class {
	#name : #TestClassWithAttributedMethod,
	#superclass : #TestClassRoot,
	#category : 'LiCoR-Tests'
}

{ #category : #'attributed methods' }
TestClassWithAttributedMethod >> method1 [
	
	<test: #itsatest>
	
]

{ #category : #'attributed methods' }
TestClassWithAttributedMethod >> method2 [
	
	<symbol: #asymbol>
	<string: 'A String'>
	<x: 1 y: 2>
	<array: #(1 #a 'test')>
	
	
]
