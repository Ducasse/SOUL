Class {
	#name : #FixVisitor,
	#superclass : #SimpleTermVisitor,
	#instVars : [
		'dictionary',
		'counter'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
FixVisitor class >> new [
	
	^super new initialize
]

{ #category : #'instance creation' }
FixVisitor class >> newWithStartIndex: anIndex [
	
	^super new initialize: anIndex
]

{ #category : #accessing }
FixVisitor >> addVariables: aCollection [
	
	aCollection
		do:
			[:aVar | 
			dictionary
				at: aVar name
				put: aVar address]
]

{ #category : #'visiting terms' }
FixVisitor >> delayedVariableVisit: aVariable [
	
	self variableVisit: aVariable
]

{ #category : #initialize }
FixVisitor >> initialize [
	
	dictionary := Dictionary new.
	counter := -1
]

{ #category : #initialize }
FixVisitor >> initialize: aCounter [
	
	dictionary := Dictionary new.
	counter := aCounter - 1
]

{ #category : #accessing }
FixVisitor >> maxIndex [
	
	^counter
]

{ #category : #'visiting terms' }
FixVisitor >> quotedCodeTermVisit: aQuotedCodeBlock [
	
	aQuotedCodeBlock variables do: [:var | var accept: self].
	aQuotedCodeBlock content do: [:var | var accept: self]
]

{ #category : #'visiting terms' }
FixVisitor >> smalltalkTermVisit: anSTTerm [
	
	| vars |
	vars := anSTTerm variables.
	(1 to: vars size) do: [:index | (vars at: index) accept: self]
]

{ #category : #'visiting terms' }
FixVisitor >> variableVisit: aVariable [
	
	dictionary
		at: aVariable name
		ifAbsentPut:
			[counter := counter + 1.
			counter].
	aVariable setAddress: (dictionary at: aVariable name)
]
