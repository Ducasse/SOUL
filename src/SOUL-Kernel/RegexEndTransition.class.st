Class {
	#name : #RegexEndTransition,
	#superclass : #RegexTransition,
	#category : 'SOUL-Kernel'
}

{ #category : #private }
RegexEndTransition >> generateExistentialCondition: identifier term: aTerm [
	
	^' if ' , 'goal' , identifier asString , '(' , from goalId asString ,
			',?phi, ?evalIn)'
]

{ #category : #private }
RegexEndTransition >> generateExistentialHead: identifier term: aTerm [
	
	^'npattern' , identifier asString , '(?phi, ' , from goalId asString , ','
		, to goalId asString , ',?evalIn, ?evalIn, ?fromWorld, ?fromWorld, ?processedPath, <?evalIn >, <?evalIn | ?restPath >, <>, ?restPath) '
]

{ #category : #private }
RegexEndTransition >> generateUniversalCondition: identifier term: aTerm [
	
	^' if forall(goal' , identifier asString , '(' , from goalId asString ,
			',?phi, ?evalIn))'
]
