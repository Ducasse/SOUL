Class {
	#name : #EmptyEvaluator,
	#superclass : #Object,
	#category : 'SOUL-EvalPrintLoop'
}

{ #category : #evaluation }
EmptyEvaluator >> allResults [
	
	^Results new timeTaken: 42
]

{ #category : #evaluation }
EmptyEvaluator >> lastResult [
	
	^self allResults
]

{ #category : #evaluation }
EmptyEvaluator >> nextResult [
	
	^self allResults
]

{ #category : #evaluation }
EmptyEvaluator >> results [
	
	^self allResults
]
