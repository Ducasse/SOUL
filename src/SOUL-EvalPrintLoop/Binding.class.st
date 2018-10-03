Class {
	#name : #Binding,
	#superclass : #Object,
	#instVars : [
		'var',
		'value'
	],
	#category : 'SOUL-EvalPrintLoop'
}

{ #category : #'instance creation' }
Binding class >> var: aVar value: aValue [
	
	^self new setVar: aVar setValue: aValue
]

{ #category : #printing }
Binding >> printOn: aStream [
	
	var printOn: aStream.
	aStream write: '-->'.
	value class == Environment
		ifTrue: [aStream write: '**env**']
		ifFalse: [value printOn: aStream]
]

{ #category : #initialize }
Binding >> setVar: aQSOULVariable setValue: aQSOULAbstractTerm [
	
	var := aQSOULVariable.
	value := aQSOULAbstractTerm
]

{ #category : #access }
Binding >> value [
	
	^value
]

{ #category : #access }
Binding >> variable [
	
	^var
]
