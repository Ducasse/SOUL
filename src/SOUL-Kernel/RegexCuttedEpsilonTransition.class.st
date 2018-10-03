Class {
	#name : #RegexCuttedEpsilonTransition,
	#superclass : #RegexEpsilonTransition,
	#category : 'SOUL-Kernel'
}

{ #category : #private }
RegexCuttedEpsilonTransition >> generateExistentialCondition: identifier term: aTerm [
	
	^' if !'
]

{ #category : #private }
RegexCuttedEpsilonTransition >> generateUniversalCondition: identifier term: aTerm [
	
	^' if !'
]
