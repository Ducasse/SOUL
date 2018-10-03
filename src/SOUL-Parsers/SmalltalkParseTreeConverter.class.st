Class {
	#name : #SmalltalkParseTreeConverter,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'methodClassTerm'
	],
	#category : 'SOUL-Parsers'
}

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptArrayNode: anArrayNode [
	"This not right yet... this code merely avoids an error"

	
	^self
		makeCompoundTerm: 'braces'
		withTerms: (self visitNodes: anArrayNode messages)
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptAssignmentNode: anAssignmentNode [
	
	^self
		makeCompoundTerm: 'assign'
		withTerm: (self visitNode: anAssignmentNode variable)
		andTerm: (self visitNode: anAssignmentNode value)
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptBlockNode: aBlockNode [
	
	| temp |
	temp := self visitNode: aBlockNode body.
	^self
		makeCompoundTerm: 'block'
		withTerm:
			(self
				makeCompoundTerm: 'arguments'
				withTerm: (self visitNodes: aBlockNode arguments))
		andTerm: temp first
		andTerm: (temp at: 2)
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptCascadeNode: aCascadeNode [
	
	| sendInfo arguments receiver |
	receiver := self visitNode: aCascadeNode receiver.
	arguments := aCascadeNode messages
		collect:
			[:msg | 
			sendInfo := Array
				with: receiver
				with: (Constant name: msg selector)
				with: (self visitNodes: msg arguments).
			self makeCompoundTerm: 'cascadeSend' withTerms: sendInfo].
	^self
		makeCompoundTerm: 'cascade'
		withTerm: receiver
		andTerm: (SoulFactory current makeList termSequence: arguments)
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptLiteralArrayNode: aRBLiteralArrayNode [
	"This not right yet... this code merely avoids an error"

	
	^self
		makeCompoundTerm: 'array'
		withTerms:
			(OrderedCollection with: (self visitNodes: aRBLiteralArrayNode contents))
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptLiteralNode: aLiteralNode [
	
	^self
		makeCompoundTerm: 'literal'
		withTerm: (SoulFactory current makeUppedObject up: aLiteralNode value)
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptMessageNode: aMessageNode [
	
	^self
		makeCompoundTerm: 'send'
		withTerm: (self visitNode: aMessageNode receiver)
		andTerm: (Constant name: aMessageNode selector asSymbol)
		andTerm: (self visitNodes: aMessageNode arguments)
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptMethodNode: aMethodNode [
	
	| temp |
	temp := self visitNode: aMethodNode body.
	^self
		makeProgramSequence:
			(self
				makeCompoundTerm: 'method'
				withTerm: self methodClassTerm
				andTerm: (Constant name: aMethodNode selector asSymbol)
				andTerm:
					(self
						makeCompoundTerm: 'arguments'
						withTerm: (self visitNodes: aMethodNode arguments))
				andTerm: temp first
				andTerm: (temp at: 2))
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptOptimizedNode: anOptimizedNode [
	
	self error: 'Optimized nodes can not be handled by the Converter for now'
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptReturnNode: aReturnNode [
	
	^self
		makeCompoundTerm: 'return'
		withTerm: (self visitNode: aReturnNode value)
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptSequenceNode: aSequenceNode [
	
	^OrderedCollection
		with:
			(self
				makeCompoundTerm: 'temporaries'
				withTerm: (self visitNodes: aSequenceNode temporaries))
		with:
			(self
				makeCompoundTerm: 'statements'
				withTerm: (self visitNodes: aSequenceNode statements))
]

{ #category : #'visitor-double dispatching' }
SmalltalkParseTreeConverter >> acceptVariableNode: aVariableNode [
	
	^self
		makeCompoundTerm: 'variable'
		withTerm: (Constant name: aVariableNode name asSymbol)
]

{ #category : #private }
SmalltalkParseTreeConverter >> defaultMethodClassTerm [
	
	^Variable name: 'unknownMethodClass'
]

{ #category : #'public access' }
SmalltalkParseTreeConverter >> doClass: aClass selector: aSymbol [
	
	| source |
	methodClassTerm := SoulFactory current makeUppedObject up: aClass.
	source := aClass compilerClass = Object compilerClass
		ifTrue: [(aClass sourceCodeAt: aSymbol) string]
		ifFalse: [aSymbol asString].
	^self doString: source inClass: aClass
]

{ #category : #'public access' }
SmalltalkParseTreeConverter >> doString: aString [
	
	^self startForNode: (RBParser parseMethod: aString)
]

{ #category : #'public access' }
SmalltalkParseTreeConverter >> doString: aString inClass: aClass [
	
	methodClassTerm := SoulFactory current makeUppedObject up: aClass.
	^self doString: aString
]

{ #category : #'initialize-release' }
SmalltalkParseTreeConverter >> initialize [
	
	^self
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeCompoundTerm: aString withTerm: aTerm [
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence: (TermSequence terms: (OrderedCollection with: aTerm))
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeCompoundTerm: aString withTerm: aTerm andTerm: aSecondTerm [
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence:
			(TermSequence terms: (OrderedCollection with: aTerm with: aSecondTerm))
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeCompoundTerm: aString withTerm: aTerm andTerm: aSecondTerm andTerm: aThirdTerm [
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence:
			(TermSequence
				terms:
					(OrderedCollection with: aTerm with: aSecondTerm with: aThirdTerm))
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeCompoundTerm: aString withTerm: aTerm andTerm: aSecondTerm andTerm: aThirdTerm andTerm: aFourthTerm [
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence:
			(TermSequence
				terms:
					(OrderedCollection with: aTerm with: aSecondTerm with: aThirdTerm with:
							aFourthTerm))
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeCompoundTerm: aString withTerm: aTerm andTerm: aSecondTerm andTerm: aThirdTerm andTerm: aFourthTerm andTerm: aFifthTerm [
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence:
			(TermSequence
				terms:
					((OrderedCollection new: 5)
						add: aTerm;
						add: aSecondTerm;
						add: aThirdTerm;
						add: aFourthTerm;
						add: aFifthTerm;
						yourself))
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeCompoundTerm: aString withTerms: aCollectionOfTerms [
	
	^SoulFactory current makeCompound
		functor: (Constant name: aString asSymbol)
		termSequence: (TermSequence terms: aCollectionOfTerms)
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeFact: aClause [
	
	^Fact
		condition: TermSequence new
		conclusion: aClause
]

{ #category : #private }
SmalltalkParseTreeConverter >> makeProgramSequence: aClause [
	
	^ProgramSequence
		clauses: (OrderedCollection with: (self makeFact: aClause))
]

{ #category : #accessing }
SmalltalkParseTreeConverter >> methodClassTerm [
	
	^methodClassTerm isNil
		ifTrue: [self defaultMethodClassTerm]
		ifFalse: [methodClassTerm]
]

{ #category : #private }
SmalltalkParseTreeConverter >> startForNode: aNode [
	
	^self visitNode: aNode
]

{ #category : #private }
SmalltalkParseTreeConverter >> stringForClass: aClass [
	"return the string that will be put as the class argument in the internal 
	parsetree "

	
	^aClass printString
]

{ #category : #visiting }
SmalltalkParseTreeConverter >> visitNode: aNode [
	
	^aNode acceptVisitor: self
]

{ #category : #visiting }
SmalltalkParseTreeConverter >> visitNodes: aNodeCollection [
	
	^SoulFactory current makeList
		termSequence:
			(TermSequence
				terms: (aNodeCollection collect: [:node | self visitNode: node]))
]
