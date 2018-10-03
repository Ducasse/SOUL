Class {
	#name : #HornClause,
	#superclass : #Object,
	#instVars : [
		'condition',
		'containsCut',
		'envSize',
		'comment'
	],
	#category : 'SOUL-GrammarClauses'
}

{ #category : #'signal constants' }
HornClause class >> errorSignal [
	
	^SoulError
]

{ #category : #visitor }
HornClause >> accept: aVisitor [
	
	self subclassResponsibility
]

{ #category : #access }
HornClause >> additionalClausesForDefinitionRepository [
	
	| clauses |
	clauses := OrderedCollection new.
	condition terms
		do:
			[:term | 
			term additionalClausesForDefinitionRepository
				ifNotNil: [:c | clauses addAll: c]].
	^clauses
]

{ #category : #printing }
HornClause >> asPrettyString [
	
	| aStream |
	aStream := TextStream on: Text new.
	self prettyPrintOn: aStream scope: #asClause.
	^aStream contents
]

{ #category : #printing }
HornClause >> asProlog [
	
	| stream |
	stream := WriteStream on: String new.
	self printAsPrologOn: stream.
	^stream contents
]

{ #category : #access }
HornClause >> comment [
	
	^comment ifNil: ['']
]

{ #category : #access }
HornClause >> comment: aComment [
	"Empty comments are stored as nil, saves us from having to store an empty string object"

	
	comment := aComment = ''
		ifTrue: [nil]
		ifFalse: [aComment]
]

{ #category : #access }
HornClause >> condition [
	
	^condition
]

{ #category : #initialize }
HornClause >> condition: aCondition [
	
	condition := aCondition.
	containsCut := aCondition containsCut 
]

{ #category : #access }
HornClause >> containsCut [
	
	^containsCut
]

{ #category : #scoping }
HornClause >> definitionRepository [
	
	^self condition definitionRepository
]

{ #category : #scoping }
HornClause >> definitionRepository: aRepository [
	
	self condition recursiveDefinitionRepository: aRepository
]

{ #category : #access }
HornClause >> envSize [
	
	^envSize
]

{ #category : #private }
HornClause >> fixClean: fixVisitor [
	
	self subclassResponsibility
]

{ #category : #testing }
HornClause >> hasComment [
	
	^comment isNil not
]

{ #category : #testing }
HornClause >> isNative [
	
	^false
]

{ #category : #resolving }
HornClause >> makeClean [
	"produce a clean copy of this clause (variables having a proper memory 
	location) "

	
	| fixer |
	fixer := FixVisitor new.
	self fixClean: fixer.
	self setEnvSize: fixer maxIndex + 1
]

{ #category : #printing }
HornClause >> prettyPrintCommentOn: aStream [
	
	| temp |
	aStream withAttribute:(TextColor gray) do:[
	self printCommentOn: aStream]
]

{ #category : #printing }
HornClause >> prettyPrintOn: aStream scope: id [
	
	self printOn: aStream
]

{ #category : #printing }
HornClause >> printAsPrologOn: aStream [
	
	self subclassResponsibility
]

{ #category : #printing }
HornClause >> printCommentOn: aStream [
	
	self hasComment
		ifTrue:
			[aStream
				nextPutAll: '"' , (comment copyReplaceAll: '"' with: '""') , '"';
				cr;
				cr]
]

{ #category : #scoping }
HornClause >> recursiveDefinitionRepository: aRepository [
	
	self definitionRepository: aRepository
]

{ #category : #private }
HornClause >> setEnvSize: anInteger [
	
	envSize := anInteger
]

{ #category : #access }
HornClause >> usesPredicate: aPredicate multiplicity: aNumber [
	
	self condition
		do:
			[:term | (term usesPredicate: aPredicate multiplicity: aNumber) ifTrue: [^true]].
	^false
]
