Class {
	#name : #LexicalAddressVisitor,
	#superclass : #SimpleTermVisitor,
	#instVars : [
		'database'
	],
	#category : 'SOUL-Repositories'
}

{ #category : #'instance creation' }
LexicalAddressVisitor class >> on: aDatabase [
	
	^super new database: aDatabase
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> callTermVisit: aCallTerm [
	"do nothing... they cannot be lexicalized"
	
	
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> compoundVisit: aCompound [
	
	| number |
	number := database addressForPredicate: aCompound predicate.
	aCompound lexicalAddress: number.
	aCompound functor accept: self.
	aCompound termSequence accept: self.
	aCompound astLink == nil ifFalse: [aCompound astLink accept: self]
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> constantVisit: aConstant [
	
	| number |
	number := database addressForPredicate: aConstant predicate.
	aConstant lexicalAddress: number
]

{ #category : #initialize }
LexicalAddressVisitor >> database: aDatabase [
	
	database := aDatabase
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> keywordFunctorVisit: term [
	"For convenience this method will by default forward the message request to multiPartFunctorVisit: as the visitor's behavior for keyword en message functors will in most cases be the same"

	
	^self multiPartFunctorVisit: term
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> messageFunctorVisit: term [
	"For convenience this method will by default forward the message request to multiPartFunctorVisit: as the visitor's behavior for keyword en message functors will in most cases be the same"

	
	^self multiPartFunctorVisit: term
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> multiPartFunctorVisit: aFunctor [
	"See comment in keywordFunctorVisit: and messageFunctorVisit:"

	
	^aFunctor keywords do: [:keyword | keyword accept: self]
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> objectVisit: anObject [
	
	^self
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> resultMessageTermVisit: rmTerm [
	
	rmTerm message accept: self.
	rmTerm result accept: self
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> smalltalkTermVisit: anSTTerm [
	"TODO: should we also recursively visit the variables used in the smalltalk term by default?"
	
	
]

{ #category : #'visiting terms' }
LexicalAddressVisitor >> unaryMessageFunctorVisit: unaryMessageFunctor [
	
	^unaryMessageFunctor message accept: self
]
