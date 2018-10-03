Class {
	#name : #CoreTests,
	#superclass : #TestCase,
	#classVars : [
		'Test'
	],
	#category : 'LiCoR-Tests'
}

{ #category : #private }
CoreTests >> methodForClass: aClass selector: aSymbol [
	"Return a method reification. Makes sure that this works for the representation with a SmalltalkMethod and for the CompiledMethod."

	
	^(MLI current methodsInClass: aClass) detect: [:m | m selector = aSymbol]
]

{ #category : #'smalltalk method term' }
CoreTests >> testAllSourceComments [
	
	| wrappedMethod |
	wrappedMethod := self methodForClass: TestClass5 selector:
			#commentedMethod0.
	self assert: wrappedMethod allSourceComments size = 0.
	wrappedMethod := self methodForClass: TestClass5 selector:
			#commentedMethod1.
	self assert: wrappedMethod allSourceComments size = 1.
	self
		assert:
			wrappedMethod allSourceComments first = 'This method has one comment'.
	wrappedMethod := self methodForClass: TestClass5 selector:
			#commentedMethod3.
	self assert: wrappedMethod allSourceComments size = 3.
	self assert: (wrappedMethod allSourceComments includes: 'fun').
	self assert: (wrappedMethod allSourceComments includes: 'Smalltalk').
	self assert: (wrappedMethod allSourceComments includes: 'is')
]

{ #category : #'smalltalk method term' }
CoreTests >> testClassReferences [
	"self run: #testClassReferences"

	"self debug: #testClassReferences"

	
	| aStMethodTerm |
	Test := Array.
	aStMethodTerm := self
		methodForClass: self class
		selector: #zork.
	self
		assert:
			aStMethodTerm classesReferenced asOrderedCollection
				= (OrderedCollection with: SoulFactory with: Array).
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	self
		assert:
			aStMethodTerm classesReferenced asOrderedCollection
				= (OrderedCollection with: SoulFactory)
]

{ #category : #'smalltalk method term' }
CoreTests >> testCreation [
	"self run: #testCreation"

	"self debug: #testCreation"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: AbstractTerm selector: #printOn:.
	self assert: aStMethodTerm fromClass = AbstractTerm.
	self assert: aStMethodTerm selector = #printOn:
]

{ #category : #'smalltalk method term' }
CoreTests >> testIsAbstract [
	"self run: #testIsAbstract"

	"self debug: #testIsAbstract"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: AbstractTerm selector: #printOn:.
	self assert: aStMethodTerm isAbstract
]

{ #category : #'smalltalk method term' }
CoreTests >> testIsAbstractFailing [
	"self run: #testIsAbstractFailing"

	"self debug: #testIsAbstractFailing"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: Constant selector: #printOn:.
	self deny: aStMethodTerm isAbstract
]

{ #category : #'smalltalk method term' }
CoreTests >> testIsAbstractSucceeding [
	"self run: #testIsAbstract"

	"self debug: #testIsAbstract"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: AbstractTerm selector: #printOn:.
	self assert: aStMethodTerm isAbstract
]

{ #category : #'smalltalk method term' }
CoreTests >> testMessagesSent [
	"self run: #testMessagesSent"

	"self debug: #testMessagesSent"

	
	| aStMethodTerm messagesSent |
	aStMethodTerm := self methodForClass: AbstractTerm selector: #printOn:.
	self
		assert:
			aStMethodTerm messages asOrderedCollection
				= (OrderedCollection with: #subclassResponsibility).
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	messagesSent := OrderedCollection withAll:
			#(#fromClause:toClauses:inEnv:startAt: #normalAddressLookup:multiplicity: #lexicalAddressInEnv:startAt:ifAbsent: #definitionRepository #clauseNotFoundIn:inEnv:startAt: #current #makeResolver).
	self
		assert:
			((aStMethodTerm messages asOrderedCollection)
				removeAll: messagesSent;
				yourself) isEmpty
]

{ #category : #'smalltalk method term' }
CoreTests >> testRbParseTree [
	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	self assert: (aStMethodTerm rbParseTree isKindOf: RBMethodNode)
]

{ #category : #'smalltalk method term' }
CoreTests >> testReferencesClass [
	"self run: #testReferencesClass"

	"self debug: #testReferencesClass"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: Constant selector:
			#resolveIn:startAt:.
	self assert: (aStMethodTerm referencesClass: SoulFactory).
	self deny: (aStMethodTerm referencesClass: Object)
]

{ #category : #'test method' }
CoreTests >> zork [
	
	| temp |
	temp := SoulFactory current makeVariable.
	temp halt: 'Aaaarrgghhhhhh! I am not meant to be executed!'.
	^temp environment = Test
]
