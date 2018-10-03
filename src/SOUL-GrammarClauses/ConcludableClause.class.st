Class {
	#name : #ConcludableClause,
	#superclass : #HornClause,
	#instVars : [
		'conclusion'
	],
	#category : 'SOUL-GrammarClauses'
}

{ #category : #'instance creation' }
ConcludableClause class >> condition: aCondition conclusion: aConclusion [
	
	^self new condition: aCondition conclusion: aConclusion
]

{ #category : #repository }
ConcludableClause >> addToRepository: aRep [
	
	| var |
	self conclusion isCallTerm
		ifTrue:
			[var := self conclusion variable.
			aRep
				addCallClause: self asNormalClause
				for: var]
		ifFalse: [aRep addNormalClause: self]
]

{ #category : #converting }
ConcludableClause >> asNormalClause [
	
	conclusion := self conclusion asNormalTerm
]

{ #category : #access }
ConcludableClause >> conclusion [
	
	^conclusion
]

{ #category : #access }
ConcludableClause >> conclusion: aConclusion [
	
	conclusion := aConclusion
]

{ #category : #initialize }
ConcludableClause >> condition: aCondition conclusion: aConclusion [
	
	super condition: aCondition.
	conclusion := aConclusion
]

{ #category : #scoping }
ConcludableClause >> definitionRepository: aRepository [
	
	self conclusion recursiveDefinitionRepository: aRepository.
	^super definitionRepository: aRepository
]

{ #category : #testing }
ConcludableClause >> isTabledRule [
	
	^false
]

{ #category : #access }
ConcludableClause >> multiplicity [
	
	^conclusion multiplicity
]

{ #category : #access }
ConcludableClause >> predicate [
	
	^conclusion predicate
]
