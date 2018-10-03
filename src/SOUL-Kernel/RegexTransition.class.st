Class {
	#name : #RegexTransition,
	#superclass : #Object,
	#instVars : [
		'from',
		'to'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
RegexTransition class >> from: aGoal to: anotherGoal [
	
	^self new from: aGoal to: anotherGoal
]

{ #category : #accessing }
RegexTransition >> from [
	
	^from
]

{ #category : #accessing }
RegexTransition >> from: anObject [
	
	from := anObject
]

{ #category : #accessing }
RegexTransition >> from: aGoal to: anotherGoal [
	
	self from: aGoal.
	self to: anotherGoal
]

{ #category : #converting }
RegexTransition >> generateExistential: identifier term: aTerm definitionRepository: aDefinitionRepository [
	
	| string |
	string := (self generateExistentialHead: identifier term: aTerm)
		, (self generateExistentialCondition: identifier term: aTerm).
	^RegexTerm generateRule: string definitionRepository:
			aDefinitionRepository
]

{ #category : #private }
RegexTransition >> generateExistentialCondition: identifier term: aTerm [
	
	^' if ' , 'goal' , identifier asString , '(' , from goalId asString , ',?phi, ?evalIn),'
			 , aTerm asString , '(?fromWorld, ?toWorld, ?nextEvalIn)'.
]

{ #category : #private }
RegexTransition >> generateExistentialHead: identifier term: aTerm [
	
	^'npattern' , identifier asString , '(?phi, ' , from goalId asString , ','
		, to goalId asString , ',?evalIn, ?nextEvalIn, ?fromWorld, ?toWorld, ?processedPath, <? evalIn | ?newDifferenceVariable >, <?evalIn | ?restPath >, ?newDifferenceVariable, ?restPath ) '
]

{ #category : #converting }
RegexTransition >> generateTransitions: identifier term: aTerm definitionRepository: aDefinitionRepository [
	
	self generateExistential: identifier term: aTerm definitionRepository:
			aDefinitionRepository.
	self generateUniversal: identifier term: aTerm definitionRepository:
			aDefinitionRepository
]

{ #category : #converting }
RegexTransition >> generateUniversal: identifier term: aTerm definitionRepository: aDefinitionRepository [
	
	| string |
	string := (self generateUniversalHead: identifier term: aTerm)
		, (self generateUniversalCondition: identifier term: aTerm).
	^RegexTerm generateRule: string definitionRepository:
			aDefinitionRepository
]

{ #category : #private }
RegexTransition >> generateUniversalCondition: identifier term: aTerm [
	
	^' if forall(goal' , identifier asString , '(' , from goalId asString ,
			',?phi, ?evalIn)),' , aTerm asString ,
			'(?fromWorld, ?toWorld, ?nextEvalIn)'
]

{ #category : #private }
RegexTransition >> generateUniversalHead: identifier term: aTerm [
	
	^'npatternUniversal' , identifier asString , '(?phi, '
		, from goalId asString , ',' , to goalId asString ,
			',?evalIn, ?nextEvalIn, ?fromWorld, ?toWorld)'
]

{ #category : #'initialize-release' }
RegexTransition >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	
	super initialize.	" *** Edit the following to properly initialize instance variables ***"

	from := nil.
	to := nil.	" *** And replace this comment with additional initialization code *** "

	^self
]

{ #category : #accessing }
RegexTransition >> to [
	
	^to
]

{ #category : #accessing }
RegexTransition >> to: anObject [
	
	to := anObject
]
