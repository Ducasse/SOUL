"
Environment has not been commented.  The comment should state the purpose of the class and also explain any unobvious aspects of the implementation.

Instance Variables:
	bindingArray	<Array>	description of bindingArray
	bindingIndex	<ArithmeticValue>	description of bindingIndex
	bindingMax	<ArithmeticValue | CPointer>	description of bindingMax
	bindingRollbackIndex	<Date | Number | SmaCCEdge>	description of bindingRollbackIndex
	callStack	<LUIProxy | Object | Proxy>	description of callStack
	currentFrame	not used by crisp interpreter, but used by fuzzy interpreter
	variableArray	<(Collection of: (Object | ObjectProxy))>	description of variableArray
	variableIndex	<ArithmeticValue>	description of variableIndex
	variableMax	<ArithmeticValue | CPointer>	description of variableMax
	variableRollbackIndex	<LUIProxy | Object | Proxy>	description of variableRollbackIndex


"
Class {
	#name : #Environment,
	#superclass : #Object,
	#instVars : [
		'variableArray',
		'bindingArray',
		'bindingIndex',
		'bindingRollbackIndex',
		'variableRollbackIndex',
		'variableIndex',
		'variableMax',
		'bindingMax',
		'callStack',
		'currentFrame'
	],
	#category : 'SOUL-Kernel'
}

{ #category : #'instance creation' }
Environment class >> new [
	
	^super new initialize
]

{ #category : #access }
Environment >> bind: aVariable to: aValue startAt: startIndex valueStartAt: valueStartIndex [
	"This method adds ground variable bindings to the environment"

	
	| index nextIndex |
	index := startIndex + aVariable address.
	variableArray
		at: index
		put: (TermPointer term: aValue envIndex: valueStartIndex).
	nextIndex := self nextBindingIndex.
	bindingArray at: nextIndex put: index
]

{ #category : #callStack }
Environment >> callStack [
	
	^callStack
]

{ #category : #callStack }
Environment >> callStack: aStack [
	
	callStack := aStack
]

{ #category : #access }
Environment >> currentFrame [
	
	^currentFrame
]

{ #category : #access }
Environment >> currentFrame: aFrame [
	
	currentFrame := aFrame
]

{ #category : #access }
Environment >> currentVariableIndex [
	
	^variableIndex
]

{ #category : #constants }
Environment >> incrementSize [
	
	^500
]

{ #category : #constants }
Environment >> initialSize [
	
	^4000
]

{ #category : #initialize }
Environment >> initialize [
	"All elements must be nil, this is standard for making a new array"

	
	variableArray := Array new: self initialSize.
	bindingArray := Array new: self initialSize.
	bindingIndex := 1.
	variableIndex := 1.
	bindingMax := self initialSize.
	variableMax := self initialSize
]

{ #category : #access }
Environment >> lookup: aVar startAt: startIndex [
	
	| index |
	index := startIndex + aVar address.
	index > variableArray size ifTrue: [^nil].
	^variableArray at: index
]

{ #category : #private }
Environment >> nextBindingIndex [
	
	| temp |
	bindingIndex = bindingMax ifTrue: [self resizeBindings].
	temp := bindingIndex.
	bindingIndex := bindingIndex + 1.
	^temp
]

{ #category : #printing }
Environment >> printOn: aStream [
	
	aStream write: '['.
	variableArray
		do: [:value | value printOn: aStream]
		separatedBy: [aStream cr].
	aStream write: ']'
]

{ #category : #private }
Environment >> resizeBindings [
	"TODO: use Array replaceFrom: to: with:"

	
	| newArray |
	bindingMax := bindingMax + self incrementSize.
	newArray := Array new: bindingMax.
	1
		to: bindingIndex
		do:
			[:i | 
			newArray
				at: i
				put: (bindingArray at: i)].
	bindingArray := newArray
]

{ #category : #private }
Environment >> resizeVariables: minimum [
	"TODO: use Array replaceFrom: to: with:"

	
	| newArray |
	variableMax := variableMax + (self incrementSize max: minimum).
	newArray := Array new: variableMax.
	1
		to: variableArray size
		do:
			[:i | 
			newArray
				at: i
				put: (variableArray at: i)].
	variableArray := newArray
]

{ #category : #'unification-transactions' }
Environment >> rollback [
	
	(bindingRollbackIndex to: bindingIndex - 1)
		do:
			[:i | 
			variableArray
				at: (bindingArray at: i)
				put: nil].
	bindingIndex := bindingRollbackIndex.
	variableIndex := variableRollbackIndex
]

{ #category : #'unification-transactions' }
Environment >> rollbackInfo [
	
	^Array with: bindingIndex with: variableIndex
]

{ #category : #'unification-transactions' }
Environment >> rollbackTo: aRollBackInfo [
	
	| newbindingIndex |
	newbindingIndex := aRollBackInfo at: 1.
	newbindingIndex
		to: bindingIndex - 1
		do:
			[:i | 
			variableArray
				at: (bindingArray at: i)
				put: nil].
	bindingIndex := newbindingIndex.
	variableIndex := aRollBackInfo at: 2
]

{ #category : #'unification-transactions' }
Environment >> startUnify: aNumber [
	
	bindingRollbackIndex := bindingIndex.
	variableRollbackIndex := variableIndex.
	variableIndex + aNumber > variableMax
		ifTrue: [self resizeVariables: variableMax - variableIndex + aNumber].
	variableIndex := variableIndex + aNumber.
	^variableRollbackIndex
]

{ #category : #'unification-transactions' }
Environment >> startUnifyWith: aHornClause [
	
	^self startUnify: aHornClause envSize
]

{ #category : #access }
Environment >> transitiveLookup: aVar startAt: anIndex [
	
	^aVar transitiveLookupIn: self startAt: anIndex
]
