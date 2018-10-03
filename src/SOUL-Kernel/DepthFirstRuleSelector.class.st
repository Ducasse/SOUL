Class {
	#name : #DepthFirstRuleSelector,
	#superclass : #Object,
	#instVars : [
		'callstack',
		'env',
		'vars',
		'startedIndex'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #private }
DepthFirstRuleSelector >> callStack [
	
	^callstack
]

{ #category : #evaluation }
DepthFirstRuleSelector >> evalQuery: inQuery [
	"build the first workframe, the failframe and the callstack"

	
	| condition startframe failframe |
	startframe := DepthFirstFrame new.
	failframe := FailFrame new.
	callstack := CallStack new.
	env := SoulFactory current makeEnvironment new.
	inQuery makeClean.
	inQuery accept: (LexicalAddressVisitor on: inQuery definitionRepository).
	vars := inQuery variables.
	env callStack: callstack.
	condition := inQuery condition.
	startedIndex := env currentVariableIndex.	"initialize the startframe with the conditions of the query"

	condition
		reverseDo:
			[:curCondition | 
			startframe
				push:
					(TermPointer
						term: curCondition
						envIndex: env currentVariableIndex)].
	failframe rollbackInfo: env rollbackInfo.
	env startUnifyWith: inQuery.
	startframe rollbackInfo: env rollbackInfo.	"put the failframe and the first frame on the callstack"

	callstack push: failframe.
	callstack push: startframe
]

{ #category : #private }
DepthFirstRuleSelector >> evalQuery: inQuery inEnv: anEnv startAt: anIndex [
	"only to be used by the evaluator"

	
	| condition startframe failframe |
	startframe := DepthFirstFrame new.
	failframe := FailFrame new.
	callstack := CallStack new.
	vars := inQuery variables.
	env := anEnv.
	env callStack: callstack.
	condition := inQuery condition.
	startedIndex := anIndex.	"initialize the startframe with the conditions of the query"

	condition
		reverseDo:
			[:curCondition | startframe push: (TermPointer term: curCondition envIndex: anIndex)].
	failframe rollbackInfo: env rollbackInfo.
	startframe rollbackInfo: env rollbackInfo.	"put the failframe and the first frame on the callstack"

	callstack push: failframe.
	callstack push: startframe
]

{ #category : #private }
DepthFirstRuleSelector >> evalTermApplication: aTermApplication inEnv: anEnv [
	"only to be used by the evaluator"

	
	| startframe failframe conditions query |
	startframe := DepthFirstFrame new.
	failframe := FailFrame new.
	callstack := CallStack new.	"change the below to avoid making a query"

	conditions := OrderedCollection new.
	conditions add: aTermApplication term.
	query := SoulFactory current makeQuery
		condition: (SoulFactory current makeTermSequence terms: conditions).
	vars := query variables.
	env := anEnv.
	env callStack: callstack.
	startedIndex := aTermApplication envIndex.	"initialize the startframe with the conditions of the query"

	startframe push: aTermApplication.
	failframe rollbackInfo: env rollbackInfo.
	startframe rollbackInfo: env rollbackInfo.	"put the failframe and the first frame on the callstack"

	callstack push: failframe.
	callstack push: startframe
]

{ #category : #private }
DepthFirstRuleSelector >> expandStack: aFrameCollection [
	"expand the stack with new frames"

	
	aFrameCollection reverseDo: [:aFrame | callstack push: aFrame]
]

{ #category : #evaluation }
DepthFirstRuleSelector >> next [
	"pop the currentframe from the stack, if it does not contain any  
	condition-clauses, it is a succes. Hence, it contains a result-binding  
	which is consequently fetched.  
	If it is not empty, set the data-stack to the position of the frame,  
	resolve the frame and expand the stack with the resulting frames"

	
	| currentFrame result |
	[(currentFrame := callstack pop) isEmpty]
		whileFalse: [self expandStack: (currentFrame resolveIn: env)].
	currentFrame rollback: env.
	result := currentFrame resultOf: vars in: env startAt: startedIndex.	"the end of the stack always contains a failframe, which should always 
	be returned if the next result is asked at the end of the eval process"

	result == false ifTrue: [callstack push: currentFrame].
	^result
]

{ #category : #evaluation }
DepthFirstRuleSelector >> step [
	"QUICK HACK TO MAKE CONFESS WORK"

	
	| currentFrame result |
	(currentFrame := callstack pop) isEmpty
		ifFalse:
			[self expandStack: (currentFrame resolveIn: env).
			^nil]
		ifTrue:
			[currentFrame rollback: env.
			result := currentFrame resultOf: vars in: env startAt: startedIndex.
			result == false ifTrue: [callstack push: currentFrame].
			^result]
]
