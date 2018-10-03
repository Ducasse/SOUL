Class {
	#name : #RegexEpsilonTransition,
	#superclass : #RegexTransition,
	#category : 'SOUL-Kernel'
}

{ #category : #private }
RegexEpsilonTransition >> generateExistentialCondition: identifier term: aTerm [
	
	^''
]

{ #category : #private }
RegexEpsilonTransition >> generateExistentialHead: identifier term: aTerm [
	
	^'npattern' , identifier asString , '(?phi, ' , from goalId asString , ','
		, to goalId asString , ',?evalIn, ?evalIn, ?fromWorld, ?fromWorld, ?processedPath, ?differenceVariable, ?restPath, ?differenceVariable, ?restPath) '
]

{ #category : #private }
RegexEpsilonTransition >> generateUniversalCondition: identifier term: aTerm [
	
	^''
]

{ #category : #private }
RegexEpsilonTransition >> generateUniversalHead: identifier term: aTerm [
	
	^'npatternUniversal' , identifier asString , '(?phi, '
		, from goalId asString , ',' , to goalId asString ,
			',?evalIn, ?evalIn, ?fromWorld, ?fromWorld)'
]
