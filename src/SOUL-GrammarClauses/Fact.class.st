Class {
	#name : #Fact,
	#superclass : #ConcludableClause,
	#category : 'SOUL-GrammarClauses'
}

{ #category : #'instance creation' }
Fact class >> conclusion: aTerm [
	
	^self new conclusion: aTerm
]

{ #category : #visitor }
Fact >> accept: aVisitor [
	
	^aVisitor factVisit: self
]

{ #category : #initialize }
Fact >> conclusion: aTerm [
	
	super
		condition:
			(SoulFactory current makeTermSequence
				terms: OrderedCollection new
				containsCut: false)
		conclusion: aTerm
]

{ #category : #private }
Fact >> fixClean: fixVisitor [
	
	conclusion accept: fixVisitor
]

{ #category : #printing }
Fact >> prettyPrintOn: aStream scope: id [
	"see comment in AbstractClause"

	
	self prettyPrintCommentOn: aStream.
	conclusion prettyPrintOn: aStream scope: id
]

{ #category : #printing }
Fact >> printAsPrologOn: aStream [
	"TODO: not correct if fact contains positive or negative variables"

	
	conclusion printAsPrologOn: aStream scope: #asClause in: nil startAt: nil.
	aStream
		write: '.';
		cr
]

{ #category : #printing }
Fact >> printForCompileOn: aStream [
	"see comment in AbstractClause"

	
	aStream write: '(' , self class name , ' conclusion:( '.
	conclusion printForCompileOn: aStream.
	aStream write: '))'.
	self hasComment
		ifTrue:
			[aStream write: ' comment: ' , self comment storeString , '; yourself']
]

{ #category : #printing }
Fact >> printOn: aStream [
	"see comment in AbstractClause"

	
	self printCommentOn: aStream.
	conclusion printOn: aStream
]

{ #category : #access }
Fact >> usesPredicate: aPredicate multiplicity: aNumber [
	
	^false
]
