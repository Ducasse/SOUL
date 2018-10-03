Class {
	#name : #Query,
	#superclass : #HornClause,
	#instVars : [
		'variables'
	],
	#category : 'SOUL-GrammarClauses'
}

{ #category : #'instance creation' }
Query class >> condition: aQuery [
	
	^self new condition: aQuery
]

{ #category : #visitor }
Query >> accept: aVisitor [
	
	^aVisitor queryVisit: self
]

{ #category : #parsing }
Query >> addChildrenInitial: aCollection [
	
	super condition: aCollection first
]

{ #category : #private }
Query >> addConditionsInFront: aCollection [
	
	condition terms: aCollection , condition terms
]

{ #category : #private }
Query >> fetchVariables [
	
	| dict variableVisitor |
	dict := Dictionary new.
	variableVisitor := SoulFactory current makeNamedVariableVisitor
		doBlock:
			[:var | 
			dict
				at: var name
				ifAbsentPut: [var]].
	condition accept: variableVisitor.
	^dict asOrderedCollection
]

{ #category : #private }
Query >> fixClean: fixVisitor [
	
	condition do: [:each | each accept: fixVisitor]
]

{ #category : #printing }
Query >> prettyPrintOn: aStream scope: id [
	
	| temp |
	self prettyPrintCommentOn: aStream.
	aStream withAttributes:(Array with:(TextColor red) with:(TextEmphasis bold)) do: [	aStream write: 'if '].
	condition prettyPrintOn: aStream scope: id
]

{ #category : #printing }
Query >> printForCompileOn: aStream [
	
	aStream write: self class name , ' condition: ('.
	condition printForCompileOn: aStream.
	aStream write: ')'
]

{ #category : #printing }
Query >> printOn: aStream [
	
	aStream write: ' if '.
	super condition printOn: aStream
]

{ #category : #access }
Query >> variableNamed: aString [
	
	^self variables
		detect: [:each | each name = aString]
		ifNone:
			[self
				error:
					'Variable ''?' , aString , ''' not found in query: ''' , self printString ,
							'''']
]

{ #category : #access }
Query >> variables [
	
	variables
		ifNil:
			[variables := self fetchVariables.
			^variables].
	^variables
]

{ #category : #private }
Query >> variables: vars [
	
	variables := vars
]
