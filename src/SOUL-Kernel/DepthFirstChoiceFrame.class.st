Class {
	#name : #DepthFirstChoiceFrame,
	#superclass : #DepthFirstFrame,
	#instVars : [
		'resolver',
		'cuttop'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
DepthFirstChoiceFrame class >> withResolver: aResolver clauses: clauses rollbackInfo: aRollbackInfo cuttop: aState [
	
	^self new withResolver: aResolver clauses: clauses rollbackInfo:
			aRollbackInfo cuttop: aState
]

{ #category : #access }
DepthFirstChoiceFrame >> cuttop [
	
	^cuttop
]

{ #category : #printing }
DepthFirstChoiceFrame >> displayString [
	
	^resolver displayString , super displayString
]

{ #category : #access }
DepthFirstChoiceFrame >> isEmpty [
	
	^false
]

{ #category : #printing }
DepthFirstChoiceFrame >> printOn: aStream [
	
	aStream
		print: self class;
		nextPutAll: ' ('.
	resolver printOn: aStream.
	aStream nextPutAll: ')['.
	conditionsList printOn: aStream.
	aStream nextPut: $]
]

{ #category : #evaluation }
DepthFirstChoiceFrame >> resolveIn: anEnv [
	"fetch the resolution of the next candidate clause, produce a frame and  
	check if the resolver still has candidate clauses"

	"first rollback the environment"

	
	| resolutionResult results newFrame |
	self rollback: anEnv.
	results := OrderedCollection new.
	resolutionResult := resolver nextResolution.
	resolutionResult
		ifNotNil:
			[newFrame := DepthFirstFrame fromConditionsStack: conditionsList.
			newFrame fromResolution: resolutionResult.
			results add: newFrame.
			cuttop := resolutionResult cutTopDelimiter].
	resolver isEmpty
		ifFalse: [results add: self]
		ifTrue: [cuttop ifTrue: [results add: CutTopFrame new]].
	^results
]

{ #category : #initialize }
DepthFirstChoiceFrame >> withResolver: aResolver clauses: aStack rollbackInfo: aRollbackInfo cuttop: aState [
	
	conditionsList := aStack.
	resolver := aResolver.
	self rollbackInfo: aRollbackInfo.
	cuttop := aState
]
