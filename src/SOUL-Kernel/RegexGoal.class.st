Class {
	#name : #RegexGoal,
	#superclass : #Object,
	#instVars : [
		'transitionsTo',
		'termsequence',
		'goalId',
		'variables'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
RegexGoal class >> newWith: aCollection id: anInteger variables: varCollection [
	
	^self new initializeWith: aCollection id: anInteger variables:
			varCollection
]

{ #category : #accessing }
RegexGoal >> connectTo: aGoal transition: aRegexTransitionClass [
	
	transitionsTo add: (aRegexTransitionClass from: self to: aGoal)
]

{ #category : #converting }
RegexGoal >> generateGoal: aTerm definitionRepository: aDefinitionRepository [
	
	| string |
	termsequence size = 0
		ifTrue:
			[string := string := 'goal' , aTerm identifier asString , '('
				, goalId asString , ',' , variables asString , ', ?currentWorld)']
		ifFalse:
			[string := 'goal' , aTerm identifier asString , '(' , goalId asString , ','
				, variables asString , ', ?currentWorld) if ' , termsequence asString].
	^RegexTerm generateRule: string definitionRepository:
			aDefinitionRepository
]

{ #category : #converting }
RegexGoal >> generateTransitions: aRegexTerm term: term definitionRepository: aRepository [
	
	self generateGoal: aRegexTerm definitionRepository: aRepository.
	transitionsTo
		collect:
			[:trans | 
			trans
				generateTransitions: aRegexTerm identifier
				term: term
				definitionRepository: aRepository]
]

{ #category : #accessing }
RegexGoal >> goalId [
	
	^goalId
]

{ #category : #accessing }
RegexGoal >> goalId: anObject [
	
	goalId := anObject
]

{ #category : #'initialize-release' }
RegexGoal >> initializeWith: aCollection id: anInteger variables: varCollection [
	
	termsequence := TermSequence terms: aCollection.
	transitionsTo := OrderedCollection new.
	goalId := anInteger.
	variables := varCollection
]

{ #category : #accessing }
RegexGoal >> termsequence [
	
	^termsequence
]

{ #category : #accessing }
RegexGoal >> termsequence: anObject [
	
	termsequence := anObject
]

{ #category : #accessing }
RegexGoal >> transitionsTo [
	
	^transitionsTo
]

{ #category : #accessing }
RegexGoal >> transitionsTo: anObject [
	
	transitionsTo := anObject
]

{ #category : #accessing }
RegexGoal >> variables [
	
	^variables
]

{ #category : #accessing }
RegexGoal >> variables: anObject [
	
	variables := anObject
]
