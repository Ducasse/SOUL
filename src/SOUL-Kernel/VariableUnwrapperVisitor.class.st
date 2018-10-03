Class {
	#name : #VariableUnwrapperVisitor,
	#superclass : #CopyingVisitor,
	#category : 'SOUL-Kernel'
}

{ #category : #'visiting terms' }
VariableUnwrapperVisitor >> constantVisit: aConstant [
	
	| rest |
	^('MetaVar*' match: aConstant name)
		ifTrue:
			[rest := aConstant name allButFirst: 7.
			('Var*' match: rest)
				ifTrue: [HiddenVariable name: rest]
				ifFalse: [Variable name: rest]]
		ifFalse: [aConstant class up: aConstant smalltalkValue]
]

{ #category : #'visiting terms' }
VariableUnwrapperVisitor >> objectVisit: anObject [
	
	| rest |
	^((anObject smalltalkValue isKindOf: Symbol)
		and: ['MetaVar*' match: anObject smalltalkValue])
		ifTrue:
			[rest := anObject smalltalkValue allButFirst: 7.
			('Var*' match: rest)
				ifTrue: [HiddenVariable name: rest]
				ifFalse: [Variable name: rest]]
		ifFalse: [anObject]
]

{ #category : #'visiting terms' }
VariableUnwrapperVisitor >> smalltalkTermVisit: anSTTerm [
	
	^self objectVisit: (anSTTerm evaluateIn: nil startAt: nil) soulUp
]
