"
This class represents a smalltalkterm in a logic program
"
Class {
	#name : #SmalltalkTerm,
	#superclass : #SymbiosisTerm,
	#category : 'SOUL-GrammarTerms'
}

{ #category : #visitor }
SmalltalkTerm >> accept: aVisitor [
	"see comment in AbstractTerm"

	
	^aVisitor smalltalkTermVisit: self
]

{ #category : #printing }
SmalltalkTerm >> asDownedSourceStringIn: anEnv startAt: anIndex [
	
	| variableValues downedSource |
	variableValues := self variables
		collect: [:aVariable | aVariable soulDownIn: anEnv startAt: anIndex].
	downedSource := source copy.
	self variables
		doWithIndex:
			[:aVariable :index | 
			downedSource := downedSource
				copyReplaceAll: '?' , aVariable name
				with: (variableValues at: index) displayString].
	^downedSource
]

{ #category : #converting }
SmalltalkTerm >> asSourceString [
	
	self shouldNotImplement
]

{ #category : #private }
SmalltalkTerm >> constructBlock [
	"This method constructs the SmalltalkBlock to be executed if the  
	SmalltalkTerm needs to execute"

	
	| sourceCode blockNode temporaries statements |
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: '[:env :envIndex '.
	variables size > 2
		ifTrue:
			[(3 to: variables size)
				do:
					[:index | sourceCode nextPutAll: ':arg' , (variables at: index) name , ' ']].
	sourceCode nextPutAll: ' | '.
	sourceCode nextPutAll: content formattedCode.
	sourceCode nextPutAll: ']'.
	variables size > 2
		ifTrue:
			[blockNode := RBParser parseExpression: sourceCode contents.
			statements := blockNode body statements asOrderedCollection.
			temporaries := blockNode body temporaries asOrderedCollection.
			(3 to: variables size)
				do:
					[:index | 
					temporaries
						add: (RBVariableNode named: 'soulvar' , (variables at: index) name)].
			(3 to: variables size)
				do:
					[:index | 
					statements
						addFirst:
							(RBParser
								parseExpression:
									'soulvar' , (variables at: index) name , ' := '
										, (variables at: index) smalltalkBlockDowningString , '.')].
			blockNode body statements: statements.
			blockNode body temporaries: temporaries.
			block := self compilerForSmalltalkTermBlocks
				evaluate: blockNode formattedCode]
		ifFalse:
			[block := self compilerForSmalltalkTermBlocks evaluate: sourceCode contents]
]

{ #category : #private }
SmalltalkTerm >> isBlock [
	
	^false
]

{ #category : #private }
SmalltalkTerm >> isLiteral [
	
	^content statements size = 1
		and: [content statements first isKindOf: RBLiteralNode]
]

{ #category : #private }
SmalltalkTerm >> isMethod [
	
	^false
]

{ #category : #private }
SmalltalkTerm >> literalValue [
	
	^content statements first value
]

{ #category : #private }
SmalltalkTerm >> parse [
	
	content := SoulFactory current makeSmalltalkTermParser
		parseExpression: source
		onError:
			[:text :pos | self error: 'Parser error: ' , text , 'at: ' , pos asString].
	content parent: self
]

{ #category : #private }
SmalltalkTerm >> parseVariables [
	
	| visitor |
	visitor := RBSoulVariableExtractorVisitor new.
	content acceptVisitor: visitor.
	variables := visitor variables.
	variables addFirst: nil.
	variables addFirst: nil.
	variables := variables asArray
]

{ #category : #printing }
SmalltalkTerm >> prettyPrintOn: aStream scope: id [
	
	aStream
		withAttributes:
			(Array
				with:(TextColor color:(Color r:0 g:0 b:256))
				with: TextEmphasis bold) do:[
	aStream write: '['.].
	super prettyPrintOn: aStream scope: id.
		aStream
		withAttributes:
			(Array
				with:(TextColor color:(Color r:0 g:0 b:256))
				with: TextEmphasis bold) do:[
	aStream write: ']'.].
	
]

{ #category : #printing }
SmalltalkTerm >> printAsPrologOn: aStream scope: id in: env startAt: idx [
	
	self isLiteral
		ifTrue:
			[self literalValue printAsPrologOn: aStream scope: id in: env startAt: idx]
		ifFalse:
			["Rather than spitting out an error, this code will simply output the source of the Smalltalk term as a string in a compound term for later manual translation."

			aStream write: 'smalltalkterm /*' , source , '*/']
]

{ #category : #printing }
SmalltalkTerm >> printForCompileOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: self class name , ' source: '.
	source printOn: aStream
]

{ #category : #printing }
SmalltalkTerm >> printOn: aStream [
	"see comment in AbstractTerm"

	
	aStream write: '['.
	aStream write: source.
	aStream write: ']'
]

{ #category : #resolving }
SmalltalkTerm >> resolveIn: anEnv startAt: anIndex [
	
	| resolveBlock resolveBlockArgs result |
	resolveBlockArgs := OrderedCollection new.
	resolveBlockArgs add: variables.
	resolveBlock := [:arg | 
	arg at: 1 put: anEnv.
	arg at: 2 put: anIndex.
	result := [block valueWithArguments: arg]
		on: Exception
		do:
			[:ex | 
			(((ex isKindOf: Notification) or: [ex isKindOf: SoulRuntimeException]) or:[ex isKindOf: Halt])
				ifTrue: [ex pass].
			self error:
					'Smalltalk clauses should always evaluate to true or false! (throws an error)'].
	arg at: 1 put: nil.
	arg at: 1 put: nil.
	((result isKindOf: Boolean) or: [result isKindOf: Maybe])
		ifFalse:
			[self error: 'Smalltalk clauses should always evaluate to true or false!'].
	result
		ifTrue:
			[ResolutionResult
				condition: SoulFactory current makeTermSequence new
				rollbackInfo: anEnv rollbackInfo
				conditionsEnvIndex: nil
				cutState: false]].
	^NativeResolver onBlock: resolveBlock withArguments: resolveBlockArgs
]

{ #category : #reification }
SmalltalkTerm >> soulDownIn: anEnv startAt: anIndex [
	"the downed version of a SmallTalkTerm is the result of it's evaluation"

	
	^self evaluateIn: anEnv startAt: anIndex
]

{ #category : #reification }
SmalltalkTerm >> transitiveLookupIn: anEnv startAt: anIndex [
	
	^self
]

{ #category : #unification }
SmalltalkTerm >> unifyWith: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"see comment in AbstractTerm"

	^aTerm
		unifyWithSmalltalkTerm: self
		inEnv: anEnv
		myIndex: hisIndex
		hisIndex: myIndex
		inSource: (inSource xor: true)
]

{ #category : #unification }
SmalltalkTerm >> unifyWithCompoundTerm: compound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with an object if my result of evaluation unifies with this  object"

	
	| object |
	object := (self evaluateIn: anEnv startAt: myIndex) soulUp.
	object == self
		ifTrue: [^false]
		ifFalse:
			[^object unifyWithCompoundTerm: compound inEnv: anEnv myIndex: myIndex
				hisIndex: hisIndex inSource: inSource]
]

{ #category : #unification }
SmalltalkTerm >> unifyWithDelayedVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with a delayed variable by binding myself to it or unifying  
	with it's value"

	
	| val |
	val := anEnv lookup: aVariable startAt: hisIndex.
	val isNil
		ifTrue:
			[anEnv bind: aVariable to: self startAt: hisIndex valueStartAt: myIndex.
			^true]
		ifFalse:
			[^val term
				unifyWithSmalltalkTerm: self
				inEnv: anEnv
				myIndex: val envIndex
				hisIndex: myIndex
				inSource: (inSource xor: true)]
]

{ #category : #unification }
SmalltalkTerm >> unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp
		unifyWithEmptyListConstant: aTerm inEnv: anEnv myIndex: myIndex hisIndex:
			hisIndex inSource: inSource
]

{ #category : #unification }
SmalltalkTerm >> unifyWithListTerm: listTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with an object if my result of evaluation unifies with this  
	object"

	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp unifyWithListTerm:
			listTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource:
			inSource
]

{ #category : #unification }
SmalltalkTerm >> unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource [
	
	^(self evaluateIn: anEnv startAt: sourceIndex) soulUp
		unifyWithQuotedCodeTerm: aQCTerm inEnv: anEnv myIndex: sourceIndex
		hisIndex: targetIndex inSource: inSource
]

{ #category : #unification }
SmalltalkTerm >> unifyWithSmalltalkTerm: anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with another SmallTalkTerm if my result and his result unify."

	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp unifyWithSmalltalkTerm:
			anSTTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource:
			inSource
]

{ #category : #unification }
SmalltalkTerm >> unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with an object if my result of evaluation unifies with this  
	object"

	
	^(self evaluateIn: anEnv startAt: myIndex) soulUp unifyWithUppedObject:
			anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource:
			inSource
]

{ #category : #unification }
SmalltalkTerm >> unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource [
	"I unify with a variable by binding my value to it or unifying with it's 
	value"

	
	^self unifyWith: aVariable inEnv: anEnv myIndex: myIndex hisIndex:
			hisIndex inSource: inSource
]
