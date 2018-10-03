Class {
	#name : #SmalltalkPatternParseTreeConverter,
	#superclass : #SmalltalkParseTreeConverter,
	#instVars : [
		'environment'
	],
	#category : 'SOUL-Parsers'
}

{ #category : #'instance creation' }
SmalltalkPatternParseTreeConverter class >> inEnvironment: anEnvironment [
	
	^self new environment: anEnvironment
]

{ #category : #'visitor-double dispatching' }
SmalltalkPatternParseTreeConverter >> acceptMessageNode: aMessageNode [
	
	^aMessageNode isPatternNode
		ifTrue: [self processPatternMessageNode: aMessageNode]
		ifFalse: [super acceptMessageNode: aMessageNode]
]

{ #category : #'visitor-double dispatching' }
SmalltalkPatternParseTreeConverter >> acceptMethodNode: aMethodNode [
	
	^aMethodNode isPatternNode
		ifTrue: [self processPatternMethodNode: aMethodNode]
		ifFalse: [super acceptMethodNode: aMethodNode]
]

{ #category : #'visitor-double dispatching' }
SmalltalkPatternParseTreeConverter >> acceptVariableNode: aVariableNode [
	
	^aVariableNode isPatternNode
		ifTrue: [self processPatternVariable: aVariableNode]
		ifFalse: [super acceptVariableNode: aVariableNode]
]

{ #category : #accessing }
SmalltalkPatternParseTreeConverter >> environment [
	
	^environment
]

{ #category : #accessing }
SmalltalkPatternParseTreeConverter >> environment: anObject [
	
	environment := anObject
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processArgument: anArgument [
	
	^anArgument isPatternNode
		ifTrue: [self processPatternVariable: anArgument]
		ifFalse: [self visitNode: anArgument]
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processArguments: aMessageNode [
	
	^aMessageNode arguments size > 1
		ifTrue: [self processMultiArguments: aMessageNode arguments]
		ifFalse: [self processArgument: (aMessageNode arguments at: 1)]
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processKeyword: anRBKeyword [
	
	^anRBKeyword isPatternVariable
		ifTrue: [self processSelectorVariable: anRBKeyword]
		ifFalse: [anRBKeyword value]
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processMultiArgumentSelector: aCollection [
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence
				terms: (aCollection collect: [:each | self processKeyword: each]))
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processMultiArguments: aCollection [
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence
				terms: (aCollection collect: [:each | self processArgument: each]))
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processPatternMessageNode: aMessageNode [
	
	^self
		makeCompoundTerm: 'send'
		withTerm: (self visitNode: aMessageNode receiver)
		andTerm: (self processSelector: aMessageNode)
		andTerm: (self processArguments: aMessageNode)
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processPatternMethodNode: aMethodNode [
	
	self halt
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processPatternVariable: aVariableNode [
	
	| name |
	name := self skipNonAlphabeticCharacters: aVariableNode name.
	^aVariableNode isStatement
		ifTrue:
			[self
				makeCompoundTerm: 'listOfStatements'
				withTerm: (Variable name: name)]
		ifFalse: [Variable name: name]
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processSelector: aMessageNode [
	
	^aMessageNode selectorParts size > 1
		ifTrue: [self processMultiArgumentSelector: aMessageNode selectorParts]
		ifFalse:
			[self processSingleArgumentSelector: (aMessageNode selectorParts at: 1)]
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processSelectorVariable: anRBKeywordToken [
	
	^Variable name: (self skipNonAlphabeticCharacters: anRBKeywordToken value)
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> processSingleArgumentSelector: anRBKeyword [
	
	^anRBKeyword isPatternVariable
		ifTrue:
			[| var |
			var := RBPatternVariableNode identifierToken: anRBKeyword.
			var isList
				ifTrue: [self processSelectorVariable: anRBKeyword]
				ifFalse:
					[SoulFactory current makeList
						termSequence:
							(TermSequence
								terms:
									(OrderedCollection with: (self processSelectorVariable: anRBKeyword)))]]
		ifFalse: [anRBKeyword value]
]

{ #category : #private }
SmalltalkPatternParseTreeConverter >> skipNonAlphabeticCharacters: aString [
	
	^aString select: [:el | el isAlphaNumeric]
]
