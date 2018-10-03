Class {
	#name : #RepositoryVariableAccVisitor,
	#superclass : #SimpleTermVisitor,
	#instVars : [
		'variables'
	],
	#category : 'SOUL-Repositories'
}

{ #category : #'instance creation' }
RepositoryVariableAccVisitor class >> new [
	
	^super new initialize
]

{ #category : #'visiting terms' }
RepositoryVariableAccVisitor >> callTermVisit: aCallTerm [
	
	variables add: aCallTerm variable
]

{ #category : #initialize }
RepositoryVariableAccVisitor >> initialize [
	
	variables := OrderedCollection new
]

{ #category : #access }
RepositoryVariableAccVisitor >> variables [
	
	^variables
]
