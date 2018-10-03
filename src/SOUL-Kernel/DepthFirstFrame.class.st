Class {
	#name : #DepthFirstFrame,
	#superclass : #Frame,
	#instVars : [
		'conditionsList'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
DepthFirstFrame class >> fromConditionsStack: aStack [
	
	^super new conditionsList: aStack
]

{ #category : #'instance creation' }
DepthFirstFrame class >> new [
	
	^super new initialize
]

{ #category : #copying }
DepthFirstFrame >> clone [
	
	^self class fromConditionsStack: conditionsList
]

{ #category : #initialize }
DepthFirstFrame >> conditionsList: aStack [
	
	conditionsList := aStack
]

{ #category : #printing }
DepthFirstFrame >> displayString [
	
	| stream current |
	stream := WriteStream on: String new.
	current := conditionsList.
	[current == nil]
		whileFalse:
			[stream nextPutAll: conditionsList displayString , ' , '.
			current := current nextTerm].
	^stream contents
]

{ #category : #initialize }
DepthFirstFrame >> fromResolution: aResolutionResult [
	
	| conditionsEnvIndex |
	envRollbackInfo := aResolutionResult rollbackInfo.
	conditionsEnvIndex := aResolutionResult conditionsEnvIndex.
	aResolutionResult conditions
		reverseDo:
			[:condition | 
			conditionsList := TermPointer term: condition envIndex: conditionsEnvIndex
				nextTerm: conditionsList]
]

{ #category : #initialize }
DepthFirstFrame >> initialize [
	
	conditionsList := nil
]

{ #category : #access }
DepthFirstFrame >> isEmpty [
	
	^conditionsList == nil
]

{ #category : #printing }
DepthFirstFrame >> printOn: aStream [
	
	aStream
		print: self class;
		nextPutAll: ' ['.
	conditionsList printOn: aStream.
	aStream nextPut: $]
]

{ #category : #access }
DepthFirstFrame >> push: aClause [
	
	conditionsList := aClause nextTerm: conditionsList
]

{ #category : #evaluation }
DepthFirstFrame >> resolveIn: anEnv [
	"produces frames to be pushed onto the searchspace: one frame for the  
	resolution of the first condition with a first candidate from the  
	repository and a continuationFrame for the next candidates.  
	The other conditions in this frame are taken along into the new frames"

	
	| resolutionResult results resolver tempcuttop |
	"first roll back the environment"

	self rollback: anEnv.
	results := OrderedCollection new.
	resolver := conditionsList resolveIn: anEnv.
	conditionsList := conditionsList nextTerm.
	resolutionResult := resolver nextResolution.	"the resolver now encapsulates the resolution of the clause with other  
	candidate clauses"

	resolver isEmpty
		ifTrue:
			["an empty resolver means tail-recursion using the current  
			resolutionresult"

			resolutionResult
				ifNotNil:
					[results add: (self fromResolution: resolutionResult).
					resolutionResult cutTopDelimiter
						ifTrue: [results add: CutTopFrame new]]]
		ifFalse:
			["a non-empty resolver means splitting the searchspace in this  
			resolutionresult and a continuationframe containing the other  
			candidate expansionframes"

			tempcuttop := false.
			resolutionResult
				ifNotNil:
					[results add: (self clone fromResolution: resolutionResult).
					tempcuttop := resolutionResult cutTopDelimiter].
			results
				add:
					(DepthFirstChoiceFrame
						withResolver: resolver
						clauses: conditionsList
						rollbackInfo: self rollbackInfo
						cuttop: tempcuttop)].
	^results
]

{ #category : #access }
DepthFirstFrame >> resultOf: vars in: env startAt: startIndex [
	
	| return |
	return := vars
		collect:
			[:var | 
			(var isKindOf: DelayedVariable)
				ifTrue:
					[Binding
						var: var
						value: (var transitiveLookupIn: env startAt: startIndex) soulUp]
				ifFalse:
					[Binding
						var: var
						value: (var soulDownIn: env startAt: startIndex) soulUp]].
	^return
]
