Class {
	#name : #SmalltalkTermParser,
	#superclass : #SmaCCParser,
	#category : 'SOUL-Parsers'
}

{ #category : #'generated-accessing' }
SmalltalkTermParser class >> cacheId [
	^'2018-06-09T09:32:28.440353+02:00'
]

{ #category : #generated }
SmalltalkTermParser class >> definitionComment [
"#Definition extracted from old style definition comments
<name>	:	[a-zA-Z_] \w*	;
<number>:	[0-9]	;
<negativenumber>	:	\- <number>	;
<string>	:	\'  [^\']* \' (\' [^\']* \')*	;
<keyword>	:	<name> \:	;
<multikeyword>	:	<name> \: (<name> \: )+	;
<binarysymbol>	:	[\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,] [\~\!\@\%\&\*\+\=\\\|\?\/\>\<\,]?	;
<whitespace>	:	\s+	;
<comment>	:	\"" [^\""]* \""	;
<dottedname>	:	<name> (\. <name>)+	;
<character>	:	\$ .	;
<variableassignment> : <name> \: \=	;
<soulvar> : \? ([A-Za-z0-9])+;
<delayedsoulvar> : \& ([A-Za-z0-9])+;
<anychar> : . ; # For VW literal arrays that handle #(;) -> #(#';')
	
	
%id <number> <negativenumber> <name> <binarysymbol>;
%start SequenceNode ;

Method:
	  <name> MethodSequenceNode {(RBMethodNode selector: '1' value asSymbol arguments: #() body: '2' last) tags: '2' first; yourself}
	| BinaryMethodName MethodSequenceNode {(RBMethodNode selector: '1' first arguments: '1' last body: '2' last) tags: '2' first; yourself}
	| KeywordMethodName MethodSequenceNode {(RBMethodNode selector: '1' first contents asSymbol arguments: '1' last body: '2' last) tags: '2' first; yourself};

BinaryMethodName:
	<binarysymbol> Variable {Array with: '1' value asSymbol with: (Array with: '2')} ;

KeywordMethodName:
	<keyword> Variable {| stream | stream := WriteStream on: (String new: 30). stream nextPutAll: '1' value. Array with: stream with: (OrderedCollection with: '2')}
	| KeywordMethodName <keyword> Variable {'1' first nextPutAll: '2' value. '1' last add: '3'. '1'};

Primitives:
	{OrderedCollection new}
	| Primitives ""<"" PrimitiveMessageSend "">"" {'1' add: ('2' startPosition to: '4' startPosition); yourself};

PrimitiveMessageSend:
	| PrimitiveMessageSend <keyword> {nil}
	| PrimitiveMessageSend Literal {nil}
	| PrimitiveMessageSend ""("" {nil}
	| PrimitiveMessageSend "")"" {nil}
	| PrimitiveMessageSend ""{"" {nil}
	| PrimitiveMessageSend ""}"" {nil}
	| PrimitiveMessageSend "";"" {nil}
	| PrimitiveMessageSend ""."" {nil}
	| PrimitiveMessageSend <name> {nil}
	| PrimitiveMessageSend <binarysymbol> {nil};

MethodSequenceNode:
	Primitives ""|"" TemporaryVariables ""|"" Primitives Statements {Array with: ('1' addAll: '5'; yourself) with: (RBSequenceNode temporaries: '3' statements: '6')}
	| Primitives ""||"" Primitives Statements {Array with: ('1' addAll: '3'; yourself) with: (RBSequenceNode temporaries: #() statements: '4')}
	| Primitives Statements {Array with: '1' with: (RBSequenceNode temporaries: #() statements: '2')};

SequenceNode:
	Temporaries Statements {RBSequenceNode temporaries: '1' statements: '2'};

Temporaries:
	{#()}
	| ""||"" {#()}
	| ""|"" TemporaryVariables ""|"" {'2'};

TemporaryVariables:
	{OrderedCollection new}
	| TemporaryVariables Variable {'1' add: '2'; yourself};

Statements:
	{OrderedCollection new}
	| StatementList "".""? {#liftFirstValue:}
	| StatementList ""."" ""^"" Expression "".""? {'1' add: (RBReturnNode value: '4'); yourself}
	| ""^"" Expression "".""? {OrderedCollection with: (RBReturnNode value: '2')};

StatementList:
	Expression
	| StatementList ""."" Expression {'1' add: '3'; yourself};

Block:
	""["" BlockArgs ""|"" SequenceNode ""]"" {RBBlockNode arguments: '2' body: '4'}
	| ""["" SequenceNode ""]"" {RBBlockNode body: '2'}
	| ""["" BlockArgs ""]"" {RBBlockNode arguments: '2' body: (RBSequenceNode statements: #())}
	| ""["" BlockArgs ""||"" TemporaryVariables ""|"" Statements ""]"" {RBBlockNode arguments: '2' body: (RBSequenceNode temporaries: '4' statements: '6')};

BlockArgs:
	"":"" Variable {OrderedCollection with: '2'}
	| BlockArgs "":"" Variable {'1' add: '3'; yourself};


Expression:
	Variable "":="" Expression {RBAssignmentNode variable: '1' value: '3'}
|	Cascade {#liftFirstValue:};

Cascade:
	MessageSend CascadeList 
				{| messages |
				'2' isEmpty ifTrue: [^'1'].
				messages := OrderedCollection new: '2' size + 1.
				messages add: '1'.
				'2' do: [:each | messages add: (RBMessageNode receiver: '1' receiver selector: each first contents asSymbol arguments: each last)].
				RBCascadeNode messages: messages}
|	Primary {#liftFirstValue:};

MessageSend:
	KeywordMessageSend {#liftFirstValue:}
|	BinaryMessageSend {#liftFirstValue:}
|	UnaryMessageSend {#liftFirstValue:};

CascadeList:
	{OrderedCollection new}
|	CascadeList "";"" SimpleMessage {'1' add: '3'; yourself};

SimpleMessage:
	UnaryMessage {#liftFirstValue:}
|	BinaryMessage {#liftFirstValue:}
|	KeywordMessage {#liftFirstValue:};

KeywordMessageSend:
	BinaryMessageSend KeywordMessage {#createMessageNodeFrom:}
|	UnaryMessageSend KeywordMessage {#createMessageNodeFrom:}
|	Primary KeywordMessage {#createMessageNodeFrom:};

KeywordMessage:
	<keyword> KeywordArgument {| stream | stream := WriteStream on: (String new: 30). stream nextPutAll: '1' value. Array with: stream with: (OrderedCollection with: '2')}
|	KeywordMessage <keyword> KeywordArgument {'1' first nextPutAll: '2' value. '1' last add: '3'. '1'};

KeywordArgument:
	BinaryMessageSend {#liftFirstValue:}
|	UnaryMessageSend {#liftFirstValue:}
|	Primary {#liftFirstValue:};

BinaryMessageSend:
	BinaryMessageSend BinaryMessage {#createMessageNodeFrom:}
|	UnaryMessageSend BinaryMessage {#createMessageNodeFrom:}
|	Primary BinaryMessage {#createMessageNodeFrom:} ;

BinaryMessage :
	<binarysymbol> BinaryArgument {Array with: (ReadStream on: '1' value) with: (Array with: '2')};

BinaryArgument:
	UnaryMessageSend {#liftFirstValue:}
|	Primary {#liftFirstValue:};

UnaryMessageSend :
	UnaryMessageSend UnaryMessage {#createMessageNodeFrom:}
|	Primary UnaryMessage {#createMessageNodeFrom:};

UnaryMessage :
	<name> {Array with: (ReadStream on: '1' value) with: #()};


Primary: 
	""("" Expression "")"" {#liftSecondValue:}
|	Literal {RBLiteralNode value: '1'}
|	Variable {#liftFirstValue:}
|	Block {#liftFirstValue:};

Variable: 
	<name> {RBVariableNode named: '1' value}
|	<soulvar> {RBSoulVariableNode named: ('1' value allButFirst: 1)}
|     <delayedsoulvar> {RBDelayedSoulVariableNode named: ('1' value allButFirst: 1)}
|    <dottedname> {RBVariableNode named: '1' value};

Literal:
	""true"" {true}
|	""false"" {false}
|	""nil"" {nil}
|	<number> {'1' value}
|	<negativenumber> {'1' value}
|	<character> {'1' value at: 2}
|	<string> {('1' value copyFrom: 2 to: '1' value size - 1) copyReplaceAll: '''''' with: ''''}
|	 ""#"" <string> {(('2' value copyFrom: 2 to: '2' value size - 1) copyReplaceAll: '''''' with: '''') asSymbol}
|	""#"" <name> {'2' value asSymbol}
|	""#"" <binarysymbol> {'2' value asSymbol}
|	""#"" <keyword> {'2' value asSymbol}
|	""#"" <multikeyword> {'2' value asSymbol}
|	""#"" ""["" ByteArray ""]"" {'3' contents}
|	""#"" ""("" Array "")"" {'3' contents}
|	""#"" ""{"" <name> ""}"" {'3' value asQualifiedReference}
|	""#"" ""{"" <dottedname> ""}"" {'3' value asQualifiedReference};

ByteArray: 
	{WriteStream on: ByteArray new}
|	ByteArray <number> {'1' nextPut: '2' value; yourself};

Array: 
	{WriteStream on: Array new}
|	Array ArrayLiteral {'1' nextPut: '2'; yourself} 
|	Array <name> "":="" {'2' stopPosition + 1 = '3' startPosition ifTrue: ['1' nextPut: ('2' value, ':') asSymbol] ifFalse: ['1' nextPut: '2' value asSymbol; nextPut: #':']. scanner position: '3' startPosition. currentToken := nil. '1'};

ArrayLiteral:
	Literal {#liftFirstValue:}
|	<name> {'1' value asSymbol}
|	<binarysymbol> {'1' value asSymbol}
|	<keyword> {'1' value asSymbol}
|	<multikeyword> {'1' value asSymbol}
|	""{"" <name> ""}"" {'2' value asQualifiedReference}
|	""{"" <dottedname> ""}"" {'2' value asQualifiedReference}
|	""("" Array "")"" {'2' contents}
|	""["" ByteArray ""]"" {'2' contents}
|	<anychar> {'1' value asSymbol}
|	<dottedname> {'1' value};"
]

{ #category : #accessing }
SmalltalkTermParser class >> parseExpression: aString onError: aBlock [
	
	^self
		parse: aString
		startingAt: self startingStateForSequenceNode
		onError: aBlock
]

{ #category : #'generated-accessing' }
SmalltalkTermParser class >> scannerClass [
	^SmalltalkTermScanner
]

{ #category : #generated }
SmalltalkTermParser class >> startingStateForMethod [
	^ 1
]

{ #category : #generated }
SmalltalkTermParser class >> startingStateForSequenceNode [
	^ 2
]

{ #category : #private }
SmalltalkTermParser >> actionForCurrentToken [
	
	| ids action |
	ids := currentToken id.
	1
		to: ids size
		do:
			[:i | 
			action := self actionFor: (ids at: i).
			(action bitAnd: self actionMask) = self errorAction ifFalse: [^action].
			(ids at: i) = scanner negativenumberId
				ifTrue:
					[currentToken := SmaCCToken
						value: '-'
						start: currentToken startPosition
						id: (Array with: scanner binarysymbolId).
					scanner position: currentToken stopPosition - 1.
					^self actionForCurrentToken]].
	^self errorAction
]

{ #category : #private }
SmalltalkTermParser >> createMessageNodeFrom: aCollection [
	
	^RBMessageNode
		receiver: aCollection first
		selector: (aCollection at: 2) first contents asSymbol
		arguments: (aCollection at: 2) last
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForArray1: nodes [
	^ WriteStream on: Array new
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForArray2: nodes [
	^ (nodes at: 1)
		nextPut: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForArray3: nodes [
	(nodes at: 2) stopPosition + 1 = (nodes at: 3) startPosition
		ifTrue: [ (nodes at: 1) nextPut: ((nodes at: 2) value , ':') asSymbol ]
		ifFalse: [ (nodes at: 1)
				nextPut:
					(nodes at: 2) value asSymbol;
				nextPut: #':' ].
	scanner position:
		(nodes at: 3) startPosition.
	currentToken := nil.
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForArrayLiteral2: nodes [
	^ (nodes at: 1) value asSymbol
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForArrayLiteral6: nodes [
	^ (nodes at: 2) value asQualifiedReference
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForArrayLiteral8: nodes [
	^ (nodes at: 2) contents
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForBinaryMessage1: nodes [
	^ Array
		with: (ReadStream on: (nodes at: 1) value)
		with: (Array with: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForBinaryMethodName1: nodes [
	^ Array
		with: (nodes at: 1) value asSymbol
		with: (Array with: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForBlock1: nodes [
	^ RBBlockNode arguments: (nodes at: 2) body: (nodes at: 4)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForBlock2: nodes [
	^ RBBlockNode body: (nodes at: 2)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForBlock3: nodes [
	^ RBBlockNode
		arguments: (nodes at: 2)
		body: (RBSequenceNode statements: #())
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForBlock4: nodes [
	^ RBBlockNode
		arguments: (nodes at: 2)
		body: (RBSequenceNode temporaries: (nodes at: 4) statements: (nodes at: 6))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForBlockArgs1: nodes [
	^ OrderedCollection with: (nodes at: 2)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForByteArray1: nodes [
	^ WriteStream on: ByteArray new
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForByteArray2: nodes [
	^ (nodes at: 1)
		nextPut: (nodes at: 2) value;
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForCascade1: nodes [
	| messages |
	(nodes at: 2) isEmpty
		ifTrue: [ ^ nodes at: 1 ].
	messages := OrderedCollection new:
		(nodes at: 2) size + 1.
	messages add: (nodes at: 1).
	(nodes at: 2)
		do: [ :each | 
			messages
				add:
					(RBMessageNode
						receiver:
							(nodes at: 1) receiver
						selector: each first contents asSymbol
						arguments: each last) ].
	^ RBCascadeNode messages: messages
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForExpression1: nodes [
	^ RBAssignmentNode variable: (nodes at: 1) value: (nodes at: 3)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForKeywordMethodName1: nodes [
	| stream |
	stream := WriteStream on: (String new: 30).
	stream nextPutAll:
		(nodes at: 1) value.
	^ Array with: stream with: (OrderedCollection with: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForKeywordMethodName2: nodes [
	(nodes at: 1) first nextPutAll: (nodes at: 2) value.
	(nodes at: 1) last add: (nodes at: 3).
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral14: nodes [
	^ (nodes at: 3) contents
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral15: nodes [
	^ (nodes at: 3) value asQualifiedReference
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral1: nodes [
	^ true
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral2: nodes [
	^ false
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral4: nodes [
	^ (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral6: nodes [
	^ (nodes at: 1) value at: 2
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral7: nodes [
	^ ((nodes at: 1) value copyFrom: 2 to: (nodes at: 1) value size - 1)
		copyReplaceAll: ''''''
		with: ''''
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral8: nodes [
	^ (((nodes at: 2) value copyFrom: 2 to: (nodes at: 2) value size - 1)
		copyReplaceAll: ''''''
		with: '''') asSymbol
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForLiteral9: nodes [
	^ (nodes at: 2) value asSymbol
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForMethod1: nodes [
	^ (RBMethodNode
		selector: (nodes at: 1) value asSymbol
		arguments: #()
		body:
		(nodes at: 2) last)
		tags:
			(nodes at: 2) first;
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForMethod2: nodes [
	^ (RBMethodNode
		selector: (nodes at: 1) first
		arguments: (nodes at: 1) last
		body: (nodes at: 2) last)
		tags:
			(nodes at: 2) first;
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForMethod3: nodes [
	^ (RBMethodNode
		selector: (nodes at: 1) first contents asSymbol
		arguments:
		(nodes at: 1) last
		body:
		(nodes at: 2) last)
		tags:
			(nodes at: 2) first;
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForMethodSequenceNode1: nodes [
	^ Array
		with:
			((nodes at: 1)
				addAll: (nodes at: 5);
				yourself)
		with: (RBSequenceNode temporaries: (nodes at: 3) statements: (nodes at: 6))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForMethodSequenceNode2: nodes [
	^ Array
		with:
			((nodes at: 1)
				addAll: (nodes at: 3);
				yourself)
		with: (RBSequenceNode temporaries: #() statements: (nodes at: 4))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForMethodSequenceNode3: nodes [
	^ Array
		with: (nodes at: 1)
		with: (RBSequenceNode temporaries: #() statements: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForPrimary2: nodes [
	^ RBLiteralNode value: (nodes at: 1)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForPrimitives1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForPrimitives2: nodes [
	^ (nodes at: 1)
		add: ((nodes at: 2) startPosition to: (nodes at: 4) startPosition);
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForSequenceNode1: nodes [
	^ RBSequenceNode temporaries: (nodes at: 1) statements: (nodes at: 2)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForStatementList2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 3);
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForStatements3: nodes [
	^ (nodes at: 1)
		add: (RBReturnNode value: (nodes at: 4));
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForStatements4: nodes [
	^ OrderedCollection with: (RBReturnNode value: (nodes at: 2))
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForTemporaries1: nodes [
	^ #()
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForTemporaryVariables2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForUnaryMessage1: nodes [
	^ Array with: (ReadStream on: (nodes at: 1) value) with: #()
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForVariable1: nodes [
	^ RBVariableNode named: (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForVariable2: nodes [
	^ RBSoulVariableNode named: ((nodes at: 1) value allButFirst: 1)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionForVariable3: nodes [
	^ RBDelayedSoulVariableNode
		named: ((nodes at: 1) value allButFirst: 1)
]

{ #category : #'generated-reduction actions' }
SmalltalkTermParser >> reduceActionFor____2: nodes [
	^ nodes at: 1
]

{ #category : #generated }
SmalltalkTermParser >> reduceTable [
^#(
	#(37 0 #reduceActionForTemporaries1:) 
	#(65 0 #reduceActionForPrimitives1:) 
	#(70 0 #reduceActionForPrimitives1:) 
	#(37 1 #reduceActionForTemporaries1:) 
	#(36 0 #reduceActionForPrimitives1:) 
	#(69 2 #reduceActionForMethod1:) 
	#(58 1 #reduceActionForVariable1:) 
	#(58 1 #reduceActionForVariable2:) 
	#(58 1 #reduceActionForVariable3:) 
	#(48 2 #reduceActionForKeywordMethodName1:) 
	#(35 2 #reduceActionForBinaryMethodName1:) 
	#(69 2 #reduceActionForMethod2:) 
	#(69 2 #reduceActionForMethod3:) 
	#(44 1 #reduceActionForLiteral1:) 
	#(44 1 #reduceActionForLiteral2:) 
	#(44 1 #nil) 
	#(44 1 #reduceActionForLiteral4:) 
	#(44 1 #reduceActionForLiteral7:) 
	#(44 1 #reduceActionForLiteral6:) 
	#(61 2 #reduceActionForSequenceNode1:) 
	#(39 0 #nil) 
	#(38 1 #reduceFor:) 
	#(46 1 #liftFirstValue:) 
	#(40 1 #liftFirstValue:) 
	#(46 1 #reduceActionForPrimary2:) 
	#(43 1 #liftFirstValue:) 
	#(57 1 #liftFirstValue:) 
	#(45 0 #reduceActionForPrimitives1:) 
	#(56 0 #reduceFor:) 
	#(60 2 #reduceActionForMethodSequenceNode3:) 
	#(48 3 #reduceActionForKeywordMethodName2:) 
	#(37 3 #liftSecondValue:) 
	#(70 2 #reduceActionForTemporaryVariables2:) 
	#(63 0 #reduceActionForArray1:) 
	#(62 0 #reduceActionForByteArray1:) 
	#(44 2 #reduceActionForLiteral9:) 
	#(44 2 #reduceActionForLiteral8:) 
	#(39 1 #reduceActionFor____2:) 
	#(36 2 #liftFirstValue:) 
	#(51 1 #reduceActionForUnaryMessage1:) 
	#(49 2 #createMessageNodeFrom:) 
	#(68 2 #createMessageNodeFrom:) 
	#(47 2 #createMessageNodeFrom:) 
	#(43 2 #reduceActionForCascade1:) 
	#(46 3 #liftSecondValue:) 
	#(36 3 #reduceActionForStatements4:) 
	#(41 2 #reduceActionForBlockArgs1:) 
	#(42 3 #reduceActionForBlock3:) 
	#(42 3 #reduceActionForBlock2:) 
	#(38 3 #reduceActionForStatementList2:) 
	#(54 1 #liftFirstValue:) 
	#(53 2 #reduceActionForKeywordMethodName1:) 
	#(55 1 #liftFirstValue:) 
	#(52 2 #reduceActionForBinaryMessage1:) 
	#(40 3 #reduceActionForExpression1:) 
	#(56 2 #nil) 
	#(65 4 #reduceActionForPrimitives2:) 
	#(60 4 #reduceActionForMethodSequenceNode2:) 
	#(44 4 #reduceActionForLiteral15:) 
	#(44 4 #reduceActionForLiteral14:) 
	#(64 1 #reduceActionForArrayLiteral2:) 
	#(64 1 #reduceActionForLiteral4:) 
	#(64 1 #liftFirstValue:) 
	#(63 2 #reduceActionForArray2:) 
	#(62 2 #reduceActionForByteArray2:) 
	#(41 3 #reduceActionForStatementList2:) 
	#(53 3 #reduceActionForKeywordMethodName2:) 
	#(45 3 #reduceActionForStatementList2:) 
	#(50 1 #liftFirstValue:) 
	#(63 3 #reduceActionForArray3:) 
	#(42 5 #reduceActionForBlock1:) 
	#(36 5 #reduceActionForStatements3:) 
	#(60 6 #reduceActionForMethodSequenceNode1:) 
	#(64 3 #reduceActionForArrayLiteral6:) 
	#(64 3 #reduceActionForArrayLiteral8:) 
	#(42 7 #reduceActionForBlock4:)
	).
]

{ #category : #generated }
SmalltalkTermParser >> symbolNames [
	^ #('"#"' '";"' '"{"' '")"' '"."' '"<"' '">"' '"}"' '"|"' '"("' '"true"' '"false"' '":="' '"nil"' '"||"' '"^"' '"["' '":"' '"]"' '<name>' '<number>' '<negativenumber>' '<string>' '<keyword>' '<multikeyword>' '<binarysymbol>' '<whitespace>' '<comment>' '<dottedname>' '<character>' '<variableassignment>' '<soulvar>' '<delayedsoulvar>' '<anychar>' 'BinaryMethodName' 'Statements' 'Temporaries' 'StatementList' '"."?' 'Expression' 'BlockArgs' 'Block' 'Cascade' 'Literal' 'CascadeList' 'Primary' 'KeywordMessageSend' 'KeywordMethodName' 'UnaryMessageSend' 'SimpleMessage' 'UnaryMessage' 'BinaryMessage' 'KeywordMessage' 'KeywordArgument' 'BinaryArgument' 'PrimitiveMessageSend' 'MessageSend' 'Variable' 'B e g i n' 'MethodSequenceNode' 'SequenceNode' 'ByteArray' 'Array' 'ArrayLiteral' 'Primitives' 'E O F' 'error' 'BinaryMessageSend' 'Method' 'TemporaryVariables')
]

{ #category : #generated }
SmalltalkTermParser >> transitionTable [
^#(
#[1 0 13 0 20 0 17 0 24 0 21 0 26 0 25 0 35 0 29 0 48 0 33 0 69] 
#[1 0 6 0 1 0 37 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 0 41 0 15 0 6 0 16 0 6 0 17 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 0 45 0 37 0 49 0 61 0 6 0 66] 
#[1 0 10 0 1 0 10 0 6 0 10 0 9 0 10 0 10 0 10 0 11 0 10 0 12 0 10 0 14 0 10 0 15 0 10 0 16 0 10 0 17 0 10 0 20 0 10 0 21 0 10 0 22 0 10 0 23 0 10 0 29 0 10 0 30 0 10 0 32 0 10 0 33 0 53 0 60 0 57 0 65 0 10 0 66] 
#[1 0 61 0 20 0 65 0 29 0 69 0 32 0 73 0 33 0 77 0 58] 
#[1 0 81 0 20 0 85 0 29 0 89 0 32 0 93 0 33 0 97 0 58] 
#[1 0 10 0 1 0 10 0 6 0 10 0 9 0 10 0 10 0 10 0 11 0 10 0 12 0 10 0 14 0 10 0 15 0 10 0 16 0 10 0 17 0 10 0 20 0 10 0 21 0 10 0 22 0 10 0 23 0 10 0 29 0 10 0 30 0 10 0 32 0 10 0 33 0 101 0 60 0 57 0 65 0 10 0 66] 
#[1 0 10 0 1 0 10 0 6 0 10 0 9 0 10 0 10 0 10 0 11 0 10 0 12 0 10 0 14 0 10 0 15 0 10 0 16 0 10 0 17 0 10 0 20 0 10 0 21 0 10 0 22 0 10 0 23 0 105 0 24 0 10 0 29 0 10 0 30 0 10 0 32 0 10 0 33 0 109 0 60 0 57 0 65 0 10 0 66] 
#[0 0 0 0 66] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 0 113 0 70] 
#[0 0 18 0 1 0 10 0 11 0 12 0 14 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[1 0 117 0 1 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 0 137 0 16 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 0 177 0 36 0 181 0 38 0 185 0 40 0 201 0 42 0 185 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 22 0 66 0 221 0 68] 
#[0 0 0 0 66] 
#[0 0 26 0 66] 
#[1 0 117 0 1 0 225 0 6 0 229 0 9 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 0 233 0 15 0 137 0 16 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 0 237 0 36 0 181 0 38 0 185 0 40 0 201 0 42 0 185 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 22 0 66 0 221 0 68] 
#[0 0 30 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 29 0 30 0 32 0 33 0 66] 
#[0 0 30 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 29 0 30 0 32 0 33 0 66] 
#[0 0 34 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 29 0 30 0 32 0 33 0 66] 
#[0 0 38 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 29 0 30 0 32 0 33 0 66] 
#[0 0 42 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 29 0 30 0 32 0 33 0 66] 
#[0 0 30 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 0 30 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 0 34 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 0 38 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 0 46 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 0 50 0 66] 
#[1 0 61 0 20 0 65 0 29 0 69 0 32 0 73 0 33 0 241 0 58] 
#[0 0 54 0 66] 
#[1 0 245 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[1 1 13 0 3 1 17 0 10 1 21 0 17 1 25 0 20 1 29 0 23 1 33 0 24 1 37 0 25 1 41 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 1 101 0 40 1 117 0 42 1 101 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 5 0 20 0 24 0 26 0 66] 
#[0 0 62 0 5 0 20 0 24 0 26 0 66] 
#[0 0 66 0 5 0 20 0 24 0 26 0 66] 
#[1 0 117 0 1 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 1 141 0 40 0 201 0 42 1 141 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 221 0 68] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 1 161 0 41 1 165 0 61] 
#[0 0 30 0 5 0 13 0 20 0 24 0 26 0 66] 
#[0 0 70 0 5 0 20 0 24 0 26 0 66] 
#[0 0 70 0 5 0 20 0 24 0 26 0 66] 
#[0 0 74 0 5 0 20 0 24 0 26 0 66] 
#[0 0 30 0 5 0 13 0 20 0 24 0 26 0 66] 
#[0 0 78 0 5 0 20 0 24 0 26 0 66] 
#[0 0 34 0 5 0 13 0 20 0 24 0 26 0 66] 
#[0 0 38 0 5 0 13 0 20 0 24 0 26 0 66] 
#[0 0 82 0 66] 
#[1 1 169 0 5 1 173 0 39 0 86 0 66] 
#[0 0 90 0 5 0 66] 
#[0 0 94 0 5 0 20 0 24 0 26 0 66] 
#[0 0 98 0 5 0 66] 
#[0 0 102 0 5 0 20 0 24 0 26 0 66] 
#[1 0 106 0 5 1 177 0 20 1 181 0 24 1 185 0 26 1 189 0 51 1 193 0 52 1 197 0 53 0 106 0 66] 
#[0 0 110 0 2 0 5 0 66] 
#[1 0 110 0 2 0 110 0 5 1 177 0 20 1 181 0 24 1 185 0 26 1 201 0 51 1 205 0 52 1 209 0 53 0 110 0 66] 
#[1 0 114 0 2 0 114 0 5 1 213 0 45 0 114 0 66] 
#[1 0 94 0 5 1 217 0 13 0 94 0 20 0 94 0 24 0 94 0 26 0 94 0 66] 
#[1 0 110 0 2 0 110 0 5 1 181 0 24 1 185 0 26 1 221 0 52 1 225 0 53 0 110 0 66] 
#[1 0 118 0 1 0 118 0 2 0 118 0 3 0 118 0 4 0 118 0 5 0 118 0 7 0 118 0 8 0 118 0 10 0 118 0 11 0 118 0 12 0 118 0 14 0 118 0 20 0 118 0 21 0 118 0 22 0 118 0 23 0 118 0 24 0 118 0 26 0 118 0 30 1 229 0 56] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 1 233 0 70] 
#[1 0 10 0 1 0 10 0 6 0 10 0 10 0 10 0 11 0 10 0 12 0 10 0 14 0 10 0 16 0 10 0 17 0 10 0 20 0 10 0 21 0 10 0 22 0 10 0 23 0 10 0 29 0 10 0 30 0 10 0 32 0 10 0 33 1 237 0 65 0 10 0 66] 
#[0 0 122 0 66] 
#[0 0 126 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 29 0 30 0 32 0 33 0 66] 
#[0 0 130 0 1 0 10 0 11 0 12 0 14 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 0 30 0 9 0 20 0 29 0 32 0 33] 
#[0 0 30 0 9 0 20 0 29 0 32 0 33] 
#[0 0 34 0 9 0 20 0 29 0 32 0 33] 
#[0 0 38 0 9 0 20 0 29 0 32 0 33] 
#[0 0 134 0 9 0 20 0 29 0 32 0 33] 
#[1 1 241 0 20 1 245 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 1 249 0 63] 
#[1 0 142 0 19 0 142 0 21 1 253 0 62] 
#[0 0 146 0 5 0 20 0 24 0 26 0 66] 
#[0 0 150 0 5 0 20 0 24 0 26 0 66] 
#[0 0 146 0 5 0 20 0 24 0 26 0 66] 
#[0 0 146 0 5 0 20 0 24 0 26 0 66] 
#[0 0 146 0 5 0 20 0 24 0 26 0 66] 
#[1 2 1 0 3 2 5 0 10 2 9 0 17 2 13 0 20 2 17 0 23 2 21 0 24 2 25 0 25 2 29 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 2 33 0 40 1 117 0 42 2 33 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 4 0 20 0 24 0 26] 
#[0 0 62 0 4 0 20 0 24 0 26] 
#[0 0 66 0 4 0 20 0 24 0 26] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 2 37 0 41 2 41 0 61] 
#[0 0 30 0 4 0 13 0 20 0 24 0 26] 
#[0 0 70 0 4 0 20 0 24 0 26] 
#[0 0 70 0 4 0 20 0 24 0 26] 
#[0 0 74 0 4 0 20 0 24 0 26] 
#[0 0 30 0 4 0 13 0 20 0 24 0 26] 
#[0 0 78 0 4 0 20 0 24 0 26] 
#[0 0 34 0 4 0 13 0 20 0 24 0 26] 
#[0 0 38 0 4 0 13 0 20 0 24 0 26] 
#[0 2 45 0 4] 
#[0 0 94 0 4 0 20 0 24 0 26] 
#[0 0 98 0 4] 
#[0 0 102 0 4 0 20 0 24 0 26] 
#[1 0 106 0 4 2 49 0 20 2 53 0 24 2 57 0 26 2 61 0 51 2 65 0 52 2 69 0 53] 
#[0 0 110 0 2 0 4] 
#[1 0 110 0 2 0 110 0 4 2 49 0 20 2 53 0 24 2 57 0 26 2 73 0 51 2 77 0 52 2 81 0 53] 
#[1 0 114 0 2 0 114 0 4 2 85 0 45] 
#[1 0 94 0 4 2 89 0 13 0 94 0 20 0 94 0 24 0 94 0 26] 
#[1 0 110 0 2 0 110 0 4 2 53 0 24 2 57 0 26 2 93 0 52 2 97 0 53] 
#[1 2 101 0 5 2 105 0 39 0 86 0 66] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 2 109 0 70] 
#[0 0 18 0 1 0 10 0 11 0 12 0 14 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33] 
#[1 2 113 0 20 2 117 0 29 2 121 0 32 2 125 0 33 2 129 0 58] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 2 193 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[1 2 241 0 9 2 245 0 15 2 249 0 18 2 253 0 19] 
#[0 3 1 0 19] 
#[1 0 117 0 1 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 3 5 0 16 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 3 9 0 40 0 201 0 42 3 9 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 154 0 66 0 221 0 68] 
#[0 0 158 0 66] 
#[0 0 162 0 2 0 5 0 20 0 24 0 26 0 66] 
#[1 3 13 0 1 3 17 0 10 3 21 0 11 3 25 0 12 3 29 0 14 3 33 0 17 3 37 0 20 3 41 0 21 3 45 0 22 3 49 0 23 3 53 0 29 3 57 0 30 3 61 0 32 3 65 0 33 3 77 0 42 3 73 0 44 3 77 0 46 3 81 0 49 3 85 0 54 3 77 0 58 3 93 0 68] 
#[1 3 13 0 1 3 17 0 10 3 21 0 11 3 25 0 12 3 29 0 14 3 33 0 17 3 37 0 20 3 41 0 21 3 45 0 22 3 49 0 23 3 53 0 29 3 57 0 30 3 61 0 32 3 65 0 33 3 97 0 42 3 73 0 44 3 97 0 46 3 101 0 49 3 105 0 55 3 97 0 58] 
#[0 0 166 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 170 0 2 0 5 0 24 0 26 0 66] 
#[1 0 174 0 2 0 174 0 5 3 109 0 24 0 174 0 66] 
#[0 0 166 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 170 0 2 0 5 0 24 0 26 0 66] 
#[1 0 174 0 2 0 174 0 5 3 109 0 24 0 174 0 66] 
#[1 3 113 0 2 0 178 0 5 0 178 0 66] 
#[1 0 117 0 1 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 3 117 0 40 0 201 0 42 3 117 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 221 0 68] 
#[0 0 170 0 2 0 5 0 24 0 26 0 66] 
#[1 0 174 0 2 0 174 0 5 3 109 0 24 0 174 0 66] 
#[1 3 121 0 1 3 125 0 2 3 129 0 3 3 133 0 4 3 137 0 5 3 141 0 7 3 145 0 8 3 149 0 10 3 153 0 11 3 157 0 12 3 161 0 14 3 165 0 20 3 169 0 21 3 173 0 22 3 177 0 23 3 181 0 24 3 185 0 26 3 189 0 30 3 193 0 44] 
#[1 3 197 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[1 0 117 0 1 3 201 0 6 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 0 137 0 16 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 3 205 0 36 0 181 0 38 0 185 0 40 0 201 0 42 0 185 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 22 0 66 0 221 0 68] 
#[0 3 209 0 8] 
#[0 3 213 0 8] 
#[1 3 217 0 1 3 221 0 3 3 225 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 4 41 0 19 4 45 0 21] 
#[1 4 49 0 20 4 53 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 4 57 0 63] 
#[1 0 142 0 19 0 142 0 21 4 61 0 62] 
#[0 0 146 0 4 0 20 0 24 0 26] 
#[0 0 150 0 4 0 20 0 24 0 26] 
#[0 0 146 0 4 0 20 0 24 0 26] 
#[0 0 146 0 4 0 20 0 24 0 26] 
#[0 0 146 0 4 0 20 0 24 0 26] 
#[0 4 65 0 4] 
#[1 4 69 0 9 4 73 0 15 2 249 0 18 4 77 0 19] 
#[0 4 81 0 19] 
#[0 0 182 0 5 0 20 0 24 0 26 0 66] 
#[0 0 162 0 2 0 4 0 20 0 24 0 26] 
#[1 4 85 0 1 4 89 0 10 4 93 0 11 4 97 0 12 4 101 0 14 4 105 0 17 4 109 0 20 4 113 0 21 4 117 0 22 4 121 0 23 4 125 0 29 4 129 0 30 4 133 0 32 4 137 0 33 4 149 0 42 4 145 0 44 4 149 0 46 4 153 0 49 4 157 0 54 4 149 0 58 4 165 0 68] 
#[1 4 85 0 1 4 89 0 10 4 93 0 11 4 97 0 12 4 101 0 14 4 105 0 17 4 109 0 20 4 113 0 21 4 117 0 22 4 121 0 23 4 125 0 29 4 129 0 30 4 133 0 32 4 137 0 33 4 169 0 42 4 145 0 44 4 169 0 46 4 173 0 49 4 177 0 55 4 169 0 58] 
#[0 0 166 0 2 0 4 0 20 0 24 0 26] 
#[0 0 170 0 2 0 4 0 24 0 26] 
#[1 0 174 0 2 0 174 0 4 4 181 0 24] 
#[0 0 166 0 2 0 4 0 20 0 24 0 26] 
#[0 0 170 0 2 0 4 0 24 0 26] 
#[1 0 174 0 2 0 174 0 4 4 181 0 24] 
#[1 4 185 0 2 0 178 0 4] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 4 189 0 40 1 117 0 42 4 189 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 170 0 2 0 4 0 24 0 26] 
#[1 0 174 0 2 0 174 0 4 4 181 0 24] 
#[0 0 154 0 66] 
#[0 0 186 0 66] 
#[1 4 193 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[0 0 30 0 9 0 15 0 18 0 19] 
#[0 0 30 0 9 0 15 0 18 0 19] 
#[0 0 34 0 9 0 15 0 18 0 19] 
#[0 0 38 0 9 0 15 0 18 0 19] 
#[0 0 190 0 9 0 15 0 18 0 19] 
#[1 4 197 0 3 4 201 0 10 4 205 0 17 4 209 0 20 4 213 0 23 4 217 0 24 4 221 0 25 4 225 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 4 229 0 40 1 117 0 42 4 229 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 5 0 19 0 20 0 24 0 26] 
#[0 0 62 0 5 0 19 0 20 0 24 0 26] 
#[0 0 66 0 5 0 19 0 20 0 24 0 26] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 157 0 17 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 4 233 0 40 2 217 0 42 4 233 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 4 237 0 41 4 241 0 61] 
#[0 0 30 0 5 0 13 0 19 0 20 0 24 0 26] 
#[0 0 70 0 5 0 19 0 20 0 24 0 26] 
#[0 0 70 0 5 0 19 0 20 0 24 0 26] 
#[0 0 74 0 5 0 19 0 20 0 24 0 26] 
#[0 0 30 0 5 0 13 0 19 0 20 0 24 0 26] 
#[0 0 78 0 5 0 19 0 20 0 24 0 26] 
#[0 0 34 0 5 0 13 0 19 0 20 0 24 0 26] 
#[0 0 38 0 5 0 13 0 19 0 20 0 24 0 26] 
#[0 0 82 0 19] 
#[1 4 245 0 5 0 86 0 19 4 249 0 39] 
#[0 0 90 0 5 0 19] 
#[0 0 94 0 5 0 19 0 20 0 24 0 26] 
#[0 0 98 0 5 0 19] 
#[0 0 102 0 5 0 19 0 20 0 24 0 26] 
#[1 0 106 0 5 0 106 0 19 4 253 0 20 5 1 0 24 5 5 0 26 5 9 0 51 5 13 0 52 5 17 0 53] 
#[0 0 110 0 2 0 5 0 19] 
#[1 0 110 0 2 0 110 0 5 0 110 0 19 4 253 0 20 5 1 0 24 5 5 0 26 5 21 0 51 5 25 0 52 5 29 0 53] 
#[1 0 114 0 2 0 114 0 5 0 114 0 19 5 33 0 45] 
#[1 0 94 0 5 5 37 0 13 0 94 0 19 0 94 0 20 0 94 0 24 0 94 0 26] 
#[1 0 110 0 2 0 110 0 5 0 110 0 19 5 1 0 24 5 5 0 26 5 41 0 52 5 45 0 53] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 5 49 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 5 53 0 70] 
#[1 2 113 0 20 2 117 0 29 2 121 0 32 2 125 0 33 5 57 0 58] 
#[0 0 194 0 5 0 20 0 24 0 26 0 66] 
#[0 0 198 0 5 0 20 0 24 0 26 0 66] 
#[1 0 117 0 1 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 5 61 0 40 0 201 0 42 5 61 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 221 0 68] 
#[0 0 202 0 5 0 66] 
#[1 5 65 0 3 5 69 0 10 5 73 0 17 5 77 0 20 5 81 0 23 5 85 0 24 5 89 0 25 5 93 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 5 97 0 40 1 117 0 42 5 97 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 62 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 66 0 2 0 5 0 20 0 24 0 26 0 66] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 5 101 0 41 5 105 0 61] 
#[0 0 30 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 70 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 70 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 74 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 30 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 78 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 34 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 38 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 94 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 102 0 2 0 5 0 20 0 24 0 26 0 66] 
#[1 0 206 0 2 0 206 0 5 1 177 0 20 0 206 0 24 1 185 0 26 1 189 0 51 1 193 0 52 0 206 0 66] 
#[1 0 206 0 2 0 206 0 5 1 177 0 20 0 206 0 24 1 185 0 26 1 201 0 51 1 205 0 52 0 206 0 66] 
#[0 0 210 0 2 0 5 0 24 0 66] 
#[0 0 94 0 2 0 5 0 20 0 24 0 26 0 66] 
#[1 0 206 0 2 0 206 0 5 0 206 0 24 1 185 0 26 1 221 0 52 0 206 0 66] 
#[1 0 214 0 2 0 214 0 5 1 177 0 20 0 214 0 24 0 214 0 26 1 189 0 51 0 214 0 66] 
#[1 0 214 0 2 0 214 0 5 1 177 0 20 0 214 0 24 0 214 0 26 1 201 0 51 0 214 0 66] 
#[0 0 218 0 2 0 5 0 24 0 26 0 66] 
#[1 3 13 0 1 3 17 0 10 3 21 0 11 3 25 0 12 3 29 0 14 3 33 0 17 3 37 0 20 3 41 0 21 3 45 0 22 3 49 0 23 3 53 0 29 3 57 0 30 3 61 0 32 3 65 0 33 3 77 0 42 3 73 0 44 3 77 0 46 3 81 0 49 5 109 0 54 3 77 0 58 3 93 0 68] 
#[1 5 113 0 20 1 181 0 24 5 117 0 26 5 121 0 50 5 121 0 51 5 121 0 52 5 133 0 53] 
#[0 0 222 0 5 0 66] 
#[1 5 137 0 3 5 141 0 10 5 145 0 17 5 149 0 20 5 153 0 23 5 157 0 24 5 161 0 25 5 165 0 26] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 230 0 1 0 6 0 9 0 10 0 11 0 12 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 58 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 62 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 66 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 70 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 70 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 74 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 78 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 226 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[1 0 10 0 1 0 10 0 6 0 10 0 10 0 10 0 11 0 10 0 12 0 10 0 14 0 10 0 16 0 10 0 17 0 10 0 20 0 10 0 21 0 10 0 22 0 10 0 23 0 10 0 29 0 10 0 30 0 10 0 32 0 10 0 33 5 169 0 65 0 10 0 66] 
#[1 0 118 0 1 0 118 0 2 0 118 0 3 0 118 0 4 0 118 0 5 0 118 0 7 0 118 0 8 0 118 0 10 0 118 0 11 0 118 0 12 0 118 0 14 0 118 0 20 0 118 0 21 0 118 0 22 0 118 0 23 0 118 0 24 0 118 0 26 0 118 0 30 5 173 0 56] 
#[0 0 234 0 66] 
#[0 0 238 0 5 0 20 0 24 0 26 0 66] 
#[0 0 238 0 5 0 20 0 24 0 26 0 66] 
#[1 5 177 0 3 5 181 0 10 5 185 0 17 5 189 0 20 5 193 0 23 5 197 0 24 5 201 0 25 5 205 0 26] 
#[1 5 209 0 20 5 213 0 29] 
#[0 0 242 0 5 0 20 0 24 0 26 0 66] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 5 217 0 63] 
#[0 0 58 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 62 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 66 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[1 0 142 0 19 0 142 0 21 5 221 0 62] 
#[1 0 246 0 1 0 246 0 3 0 246 0 4 0 246 0 10 0 246 0 11 0 246 0 12 5 225 0 13 0 246 0 14 0 246 0 17 0 246 0 20 0 246 0 21 0 246 0 22 0 246 0 23 0 246 0 24 0 246 0 25 0 246 0 26 0 246 0 29 0 246 0 30 0 246 0 34] 
#[0 0 70 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 70 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 74 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 246 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 246 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 246 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 250 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 78 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 246 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 254 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 1 2 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 242 0 5 0 20 0 24 0 26 0 66] 
#[0 1 6 0 19 0 21] 
#[0 5 229 0 8] 
#[0 5 233 0 8] 
#[1 3 217 0 1 3 221 0 3 5 237 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 5 241 0 19 4 45 0 21] 
#[0 0 182 0 4 0 20 0 24 0 26] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 5 245 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 5 249 0 70] 
#[0 0 194 0 4 0 20 0 24 0 26] 
#[0 0 198 0 4 0 20 0 24 0 26] 
#[1 5 253 0 3 6 1 0 10 6 5 0 17 6 9 0 20 6 13 0 23 6 17 0 24 6 21 0 25 6 25 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 6 29 0 40 1 117 0 42 6 29 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 2 0 4 0 20 0 24 0 26] 
#[0 0 62 0 2 0 4 0 20 0 24 0 26] 
#[0 0 66 0 2 0 4 0 20 0 24 0 26] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 6 33 0 41 6 37 0 61] 
#[0 0 30 0 2 0 4 0 20 0 24 0 26] 
#[0 0 70 0 2 0 4 0 20 0 24 0 26] 
#[0 0 70 0 2 0 4 0 20 0 24 0 26] 
#[0 0 74 0 2 0 4 0 20 0 24 0 26] 
#[0 0 30 0 2 0 4 0 20 0 24 0 26] 
#[0 0 78 0 2 0 4 0 20 0 24 0 26] 
#[0 0 34 0 2 0 4 0 20 0 24 0 26] 
#[0 0 38 0 2 0 4 0 20 0 24 0 26] 
#[0 0 94 0 2 0 4 0 20 0 24 0 26] 
#[0 0 102 0 2 0 4 0 20 0 24 0 26] 
#[1 0 206 0 2 0 206 0 4 2 49 0 20 0 206 0 24 2 57 0 26 2 61 0 51 2 65 0 52] 
#[1 0 206 0 2 0 206 0 4 2 49 0 20 0 206 0 24 2 57 0 26 2 73 0 51 2 77 0 52] 
#[0 0 210 0 2 0 4 0 24] 
#[0 0 94 0 2 0 4 0 20 0 24 0 26] 
#[1 0 206 0 2 0 206 0 4 0 206 0 24 2 57 0 26 2 93 0 52] 
#[1 0 214 0 2 0 214 0 4 2 49 0 20 0 214 0 24 0 214 0 26 2 61 0 51] 
#[1 0 214 0 2 0 214 0 4 2 49 0 20 0 214 0 24 0 214 0 26 2 73 0 51] 
#[0 0 218 0 2 0 4 0 24 0 26] 
#[1 4 85 0 1 4 89 0 10 4 93 0 11 4 97 0 12 4 101 0 14 4 105 0 17 4 109 0 20 4 113 0 21 4 117 0 22 4 121 0 23 4 125 0 29 4 129 0 30 4 133 0 32 4 137 0 33 4 149 0 42 4 145 0 44 4 149 0 46 4 153 0 49 6 41 0 54 4 149 0 58 4 165 0 68] 
#[1 6 45 0 20 2 53 0 24 6 49 0 26 6 53 0 50 6 53 0 51 6 53 0 52 6 65 0 53] 
#[0 0 222 0 4] 
#[0 0 130 0 1 0 10 0 11 0 12 0 14 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33] 
#[1 6 69 0 20 6 73 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 6 77 0 63] 
#[1 0 142 0 19 0 142 0 21 6 81 0 62] 
#[0 0 146 0 5 0 19 0 20 0 24 0 26] 
#[0 0 150 0 5 0 19 0 20 0 24 0 26] 
#[0 0 146 0 5 0 19 0 20 0 24 0 26] 
#[0 0 146 0 5 0 19 0 20 0 24 0 26] 
#[0 0 146 0 5 0 19 0 20 0 24 0 26] 
#[0 6 85 0 4] 
#[1 6 89 0 5 0 86 0 19 6 93 0 39] 
#[1 6 97 0 9 6 101 0 15 2 249 0 18 6 105 0 19] 
#[0 6 109 0 19] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 6 113 0 16 2 157 0 17 0 154 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 6 117 0 40 2 217 0 42 6 117 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 0 158 0 19] 
#[0 0 162 0 2 0 5 0 19 0 20 0 24 0 26] 
#[1 6 121 0 1 6 125 0 10 6 129 0 11 6 133 0 12 6 137 0 14 6 141 0 17 6 145 0 20 6 149 0 21 6 153 0 22 6 157 0 23 6 161 0 29 6 165 0 30 6 169 0 32 6 173 0 33 6 185 0 42 6 181 0 44 6 185 0 46 6 189 0 49 6 193 0 54 6 185 0 58 6 201 0 68] 
#[1 6 121 0 1 6 125 0 10 6 129 0 11 6 133 0 12 6 137 0 14 6 141 0 17 6 145 0 20 6 149 0 21 6 153 0 22 6 157 0 23 6 161 0 29 6 165 0 30 6 169 0 32 6 173 0 33 6 205 0 42 6 181 0 44 6 205 0 46 6 209 0 49 6 213 0 55 6 205 0 58] 
#[0 0 166 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 170 0 2 0 5 0 19 0 24 0 26] 
#[1 0 174 0 2 0 174 0 5 0 174 0 19 6 217 0 24] 
#[0 0 166 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 170 0 2 0 5 0 19 0 24 0 26] 
#[1 0 174 0 2 0 174 0 5 0 174 0 19 6 217 0 24] 
#[1 6 221 0 2 0 178 0 5 0 178 0 19] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 157 0 17 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 6 225 0 40 2 217 0 42 6 225 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 0 170 0 2 0 5 0 19 0 24 0 26] 
#[1 0 174 0 2 0 174 0 5 0 174 0 19 6 217 0 24] 
#[0 6 229 0 19] 
#[1 6 233 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[0 1 10 0 9 0 15 0 18 0 19] 
#[1 2 101 0 5 6 237 0 39 0 86 0 66] 
#[1 6 241 0 20 6 245 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 6 249 0 63] 
#[1 0 142 0 19 0 142 0 21 6 253 0 62] 
#[0 0 146 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 150 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 146 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 146 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 146 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 7 1 0 4] 
#[1 7 5 0 9 7 9 0 15 2 249 0 18 7 13 0 19] 
#[0 7 17 0 19] 
#[0 1 14 0 2 0 5 0 24 0 66] 
#[0 0 162 0 2 0 5 0 66] 
#[1 7 21 0 1 7 25 0 10 7 29 0 11 7 33 0 12 7 37 0 14 7 41 0 17 7 45 0 20 7 49 0 21 7 53 0 22 7 57 0 23 7 61 0 29 7 65 0 30 7 69 0 32 7 73 0 33 7 85 0 42 7 81 0 44 7 85 0 46 7 89 0 49 7 93 0 55 7 85 0 58] 
#[0 1 18 0 2 0 5 0 66] 
#[0 1 22 0 2 0 5 0 66] 
#[0 1 22 0 2 0 5 0 66] 
#[1 1 22 0 2 1 22 0 5 3 109 0 24 1 22 0 66] 
#[1 7 101 0 20 7 105 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 7 109 0 63] 
#[1 0 142 0 19 0 142 0 21 7 113 0 62] 
#[0 0 146 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 150 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 146 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 146 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 146 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[1 0 117 0 1 3 201 0 6 0 121 0 10 0 125 0 11 0 129 0 12 0 133 0 14 0 137 0 16 0 141 0 17 0 145 0 20 0 149 0 21 0 153 0 22 0 157 0 23 0 161 0 29 0 165 0 30 0 169 0 32 0 173 0 33 7 117 0 36 0 181 0 38 0 185 0 40 0 201 0 42 0 185 0 43 0 197 0 44 0 201 0 46 0 213 0 47 0 209 0 49 0 213 0 57 0 217 0 58 0 22 0 66 0 221 0 68] 
#[1 3 121 0 1 3 125 0 2 3 129 0 3 3 133 0 4 3 137 0 5 7 121 0 7 3 145 0 8 3 149 0 10 3 153 0 11 3 157 0 12 3 161 0 14 3 165 0 20 3 169 0 21 3 173 0 22 3 177 0 23 3 181 0 24 3 185 0 26 3 189 0 30 3 193 0 44] 
#[1 7 125 0 20 7 129 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 7 133 0 63] 
#[1 0 142 0 19 0 142 0 21 7 137 0 62] 
#[0 0 146 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 150 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 146 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 146 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 146 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 7 141 0 8] 
#[0 7 145 0 8] 
#[1 3 217 0 1 3 221 0 3 7 149 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 7 153 0 19 4 45 0 21] 
#[0 1 26 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 238 0 4 0 20 0 24 0 26] 
#[0 0 238 0 4 0 20 0 24 0 26] 
#[0 0 242 0 4 0 20 0 24 0 26] 
#[0 0 242 0 4 0 20 0 24 0 26] 
#[0 7 157 0 19] 
#[1 7 161 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[1 7 165 0 20 7 169 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 7 173 0 63] 
#[1 0 142 0 19 0 142 0 21 7 177 0 62] 
#[0 0 146 0 2 0 4 0 20 0 24 0 26] 
#[0 0 150 0 2 0 4 0 20 0 24 0 26] 
#[0 0 146 0 2 0 4 0 20 0 24 0 26] 
#[0 0 146 0 2 0 4 0 20 0 24 0 26] 
#[0 0 146 0 2 0 4 0 20 0 24 0 26] 
#[0 7 181 0 4] 
#[1 7 185 0 9 7 189 0 15 2 249 0 18 7 193 0 19] 
#[0 7 197 0 19] 
#[0 1 14 0 2 0 4 0 24] 
#[0 0 162 0 2 0 4] 
#[1 7 201 0 1 7 205 0 10 7 209 0 11 7 213 0 12 7 217 0 14 7 221 0 17 7 225 0 20 7 229 0 21 7 233 0 22 7 237 0 23 7 241 0 29 7 245 0 30 7 249 0 32 7 253 0 33 8 9 0 42 8 5 0 44 8 9 0 46 8 13 0 49 8 17 0 55 8 9 0 58] 
#[0 1 18 0 2 0 4] 
#[0 1 22 0 2 0 4] 
#[0 1 22 0 2 0 4] 
#[1 1 22 0 2 1 22 0 4 4 181 0 24] 
#[0 8 25 0 8] 
#[0 8 29 0 8] 
#[1 3 217 0 1 3 221 0 3 8 33 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 8 37 0 19 4 45 0 21] 
#[0 0 182 0 5 0 19 0 20 0 24 0 26] 
#[0 0 154 0 19] 
#[0 0 186 0 19] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 8 41 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 8 45 0 70] 
#[0 0 194 0 5 0 19 0 20 0 24 0 26] 
#[0 0 198 0 5 0 19 0 20 0 24 0 26] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 157 0 17 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 8 49 0 40 2 217 0 42 8 49 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 0 202 0 5 0 19] 
#[1 8 53 0 3 8 57 0 10 8 61 0 17 8 65 0 20 8 69 0 23 8 73 0 24 8 77 0 25 8 81 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 8 85 0 40 1 117 0 42 8 85 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 62 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 66 0 2 0 5 0 19 0 20 0 24 0 26] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 8 89 0 41 8 93 0 61] 
#[0 0 30 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 70 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 70 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 74 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 30 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 78 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 34 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 38 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 94 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 102 0 2 0 5 0 19 0 20 0 24 0 26] 
#[1 0 206 0 2 0 206 0 5 0 206 0 19 4 253 0 20 0 206 0 24 5 5 0 26 5 9 0 51 5 13 0 52] 
#[1 0 206 0 2 0 206 0 5 0 206 0 19 4 253 0 20 0 206 0 24 5 5 0 26 5 21 0 51 5 25 0 52] 
#[0 0 210 0 2 0 5 0 19 0 24] 
#[0 0 94 0 2 0 5 0 19 0 20 0 24 0 26] 
#[1 0 206 0 2 0 206 0 5 0 206 0 19 0 206 0 24 5 5 0 26 5 41 0 52] 
#[1 0 214 0 2 0 214 0 5 0 214 0 19 4 253 0 20 0 214 0 24 0 214 0 26 5 9 0 51] 
#[1 0 214 0 2 0 214 0 5 0 214 0 19 4 253 0 20 0 214 0 24 0 214 0 26 5 21 0 51] 
#[0 0 218 0 2 0 5 0 19 0 24 0 26] 
#[1 6 121 0 1 6 125 0 10 6 129 0 11 6 133 0 12 6 137 0 14 6 141 0 17 6 145 0 20 6 149 0 21 6 153 0 22 6 157 0 23 6 161 0 29 6 165 0 30 6 169 0 32 6 173 0 33 6 185 0 42 6 181 0 44 6 185 0 46 6 189 0 49 8 97 0 54 6 185 0 58 6 201 0 68] 
#[1 8 101 0 20 5 1 0 24 8 105 0 26 8 109 0 50 8 109 0 51 8 109 0 52 8 121 0 53] 
#[0 0 222 0 5 0 19] 
#[0 1 30 0 5 0 20 0 24 0 26 0 66] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 8 125 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 1 34 0 66] 
#[0 8 129 0 8] 
#[0 8 133 0 8] 
#[1 3 217 0 1 3 221 0 3 8 137 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 8 141 0 19 4 45 0 21] 
#[0 0 182 0 2 0 5 0 20 0 24 0 26 0 66] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 8 145 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 8 149 0 70] 
#[0 0 194 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 198 0 2 0 5 0 20 0 24 0 26 0 66] 
#[1 8 153 0 3 8 157 0 10 8 161 0 17 8 165 0 20 8 169 0 23 8 173 0 24 8 177 0 25 8 181 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 8 185 0 40 1 117 0 42 8 185 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 2 0 5 0 20 0 66] 
#[0 0 62 0 2 0 5 0 20 0 66] 
#[0 0 66 0 2 0 5 0 20 0 66] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 8 189 0 41 8 193 0 61] 
#[0 0 30 0 2 0 5 0 20 0 66] 
#[0 0 70 0 2 0 5 0 20 0 66] 
#[0 0 70 0 2 0 5 0 20 0 66] 
#[0 0 74 0 2 0 5 0 20 0 66] 
#[0 0 30 0 2 0 5 0 20 0 66] 
#[0 0 78 0 2 0 5 0 20 0 66] 
#[0 0 34 0 2 0 5 0 20 0 66] 
#[0 0 38 0 2 0 5 0 20 0 66] 
#[0 0 94 0 2 0 5 0 20 0 66] 
#[0 0 102 0 2 0 5 0 20 0 66] 
#[1 0 214 0 2 0 214 0 5 8 197 0 20 8 201 0 51 0 214 0 66] 
#[1 0 214 0 2 0 214 0 5 8 197 0 20 8 205 0 51 0 214 0 66] 
#[0 0 218 0 2 0 5 0 66] 
#[0 0 94 0 2 0 5 0 20 0 66] 
#[0 8 209 0 8] 
#[0 8 213 0 8] 
#[1 3 217 0 1 3 221 0 3 8 217 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 8 221 0 19 4 45 0 21] 
#[0 1 38 0 66] 
#[0 0 230 0 1 0 6 0 10 0 11 0 12 0 14 0 16 0 17 0 20 0 21 0 22 0 23 0 29 0 30 0 32 0 33 0 66] 
#[0 8 225 0 8] 
#[0 8 229 0 8] 
#[1 3 217 0 1 3 221 0 3 8 233 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 8 237 0 19 4 45 0 21] 
#[0 1 42 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 1 42 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 1 46 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 1 46 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 1 30 0 4 0 20 0 24 0 26] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 8 241 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 8 245 0 8] 
#[0 8 249 0 8] 
#[1 3 217 0 1 3 221 0 3 8 253 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 9 1 0 19 4 45 0 21] 
#[0 0 182 0 2 0 4 0 20 0 24 0 26] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 9 5 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 9 9 0 70] 
#[0 0 194 0 2 0 4 0 20 0 24 0 26] 
#[0 0 198 0 2 0 4 0 20 0 24 0 26] 
#[1 9 13 0 3 9 17 0 10 9 21 0 17 9 25 0 20 9 29 0 23 9 33 0 24 9 37 0 25 9 41 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 9 45 0 40 1 117 0 42 9 45 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 2 0 4 0 20] 
#[0 0 62 0 2 0 4 0 20] 
#[0 0 66 0 2 0 4 0 20] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 9 49 0 41 9 53 0 61] 
#[0 0 30 0 2 0 4 0 20] 
#[0 0 70 0 2 0 4 0 20] 
#[0 0 70 0 2 0 4 0 20] 
#[0 0 74 0 2 0 4 0 20] 
#[0 0 30 0 2 0 4 0 20] 
#[0 0 78 0 2 0 4 0 20] 
#[0 0 34 0 2 0 4 0 20] 
#[0 0 38 0 2 0 4 0 20] 
#[0 0 94 0 2 0 4 0 20] 
#[0 0 102 0 2 0 4 0 20] 
#[1 0 214 0 2 0 214 0 4 9 57 0 20 9 61 0 51] 
#[1 0 214 0 2 0 214 0 4 9 57 0 20 9 65 0 51] 
#[0 0 218 0 2 0 4] 
#[0 0 94 0 2 0 4 0 20] 
#[0 0 238 0 5 0 19 0 20 0 24 0 26] 
#[0 0 238 0 5 0 19 0 20 0 24 0 26] 
#[0 0 242 0 5 0 19 0 20 0 24 0 26] 
#[0 0 242 0 5 0 19 0 20 0 24 0 26] 
#[0 9 69 0 19] 
#[1 9 73 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[1 6 89 0 5 0 86 0 19 9 77 0 39] 
#[1 9 81 0 20 9 85 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 9 89 0 63] 
#[1 0 142 0 19 0 142 0 21 9 93 0 62] 
#[0 0 146 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 150 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 146 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 146 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 146 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 9 97 0 4] 
#[1 9 101 0 9 9 105 0 15 2 249 0 18 9 109 0 19] 
#[0 9 113 0 19] 
#[0 1 14 0 2 0 5 0 19 0 24] 
#[0 0 162 0 2 0 5 0 19] 
#[1 9 117 0 1 9 121 0 10 9 125 0 11 9 129 0 12 9 133 0 14 9 137 0 17 9 141 0 20 9 145 0 21 9 149 0 22 9 153 0 23 9 157 0 29 9 161 0 30 9 165 0 32 9 169 0 33 9 181 0 42 9 177 0 44 9 181 0 46 9 185 0 49 9 189 0 55 9 181 0 58] 
#[0 1 18 0 2 0 5 0 19] 
#[0 1 22 0 2 0 5 0 19] 
#[0 1 22 0 2 0 5 0 19] 
#[1 1 22 0 2 1 22 0 5 1 22 0 19 6 217 0 24] 
#[0 9 197 0 19] 
#[0 0 238 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 238 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 242 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 0 242 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 9 201 0 19] 
#[1 9 205 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[1 9 209 0 20 9 213 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 9 217 0 63] 
#[1 0 142 0 19 0 142 0 21 9 221 0 62] 
#[0 0 146 0 2 0 5 0 20 0 66] 
#[0 0 150 0 2 0 5 0 20 0 66] 
#[0 0 146 0 2 0 5 0 20 0 66] 
#[0 0 146 0 2 0 5 0 20 0 66] 
#[0 0 146 0 2 0 5 0 20 0 66] 
#[0 9 225 0 4] 
#[1 9 229 0 9 9 233 0 15 2 249 0 18 9 237 0 19] 
#[0 9 241 0 19] 
#[0 0 162 0 2 0 5 0 20 0 66] 
#[0 0 166 0 2 0 5 0 20 0 66] 
#[0 0 166 0 2 0 5 0 20 0 66] 
#[0 0 238 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 238 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 242 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 242 0 1 0 2 0 3 0 4 0 5 0 7 0 8 0 10 0 11 0 12 0 14 0 20 0 21 0 22 0 23 0 24 0 26 0 30] 
#[0 0 238 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 238 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 242 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 0 242 0 1 0 3 0 4 0 10 0 11 0 12 0 14 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 29 0 30 0 34] 
#[0 9 245 0 19] 
#[0 0 238 0 2 0 4 0 20 0 24 0 26] 
#[0 0 238 0 2 0 4 0 20 0 24 0 26] 
#[0 0 242 0 2 0 4 0 20 0 24 0 26] 
#[0 0 242 0 2 0 4 0 20 0 24 0 26] 
#[0 9 249 0 19] 
#[1 9 253 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[1 10 1 0 20 10 5 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 10 9 0 63] 
#[1 0 142 0 19 0 142 0 21 10 13 0 62] 
#[0 0 146 0 2 0 4 0 20] 
#[0 0 150 0 2 0 4 0 20] 
#[0 0 146 0 2 0 4 0 20] 
#[0 0 146 0 2 0 4 0 20] 
#[0 0 146 0 2 0 4 0 20] 
#[0 10 17 0 4] 
#[1 10 21 0 9 10 25 0 15 2 249 0 18 10 29 0 19] 
#[0 10 33 0 19] 
#[0 0 162 0 2 0 4 0 20] 
#[0 0 166 0 2 0 4 0 20] 
#[0 0 166 0 2 0 4 0 20] 
#[0 1 30 0 5 0 19 0 20 0 24 0 26] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 10 37 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 1 34 0 19] 
#[0 10 41 0 8] 
#[0 10 45 0 8] 
#[1 3 217 0 1 3 221 0 3 10 49 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 10 53 0 19 4 45 0 21] 
#[0 0 182 0 2 0 5 0 19 0 20 0 24 0 26] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 10 57 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 10 61 0 70] 
#[0 0 194 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 198 0 2 0 5 0 19 0 20 0 24 0 26] 
#[1 10 65 0 3 10 69 0 10 10 73 0 17 10 77 0 20 10 81 0 23 10 85 0 24 10 89 0 25 10 93 0 26] 
#[1 1 45 0 1 1 49 0 10 1 53 0 11 1 57 0 12 1 61 0 14 1 65 0 17 1 69 0 20 1 73 0 21 1 77 0 22 1 81 0 23 1 85 0 29 1 89 0 30 1 93 0 32 1 97 0 33 10 97 0 40 1 117 0 42 10 97 0 43 1 113 0 44 1 117 0 46 1 129 0 47 1 125 0 49 1 129 0 57 1 133 0 58 1 137 0 68] 
#[0 0 58 0 2 0 5 0 19 0 20] 
#[0 0 62 0 2 0 5 0 19 0 20] 
#[0 0 66 0 2 0 5 0 19 0 20] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 1 153 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 10 101 0 41 10 105 0 61] 
#[0 0 30 0 2 0 5 0 19 0 20] 
#[0 0 70 0 2 0 5 0 19 0 20] 
#[0 0 70 0 2 0 5 0 19 0 20] 
#[0 0 74 0 2 0 5 0 19 0 20] 
#[0 0 30 0 2 0 5 0 19 0 20] 
#[0 0 78 0 2 0 5 0 19 0 20] 
#[0 0 34 0 2 0 5 0 19 0 20] 
#[0 0 38 0 2 0 5 0 19 0 20] 
#[0 0 94 0 2 0 5 0 19 0 20] 
#[0 0 102 0 2 0 5 0 19 0 20] 
#[1 0 214 0 2 0 214 0 5 0 214 0 19 10 109 0 20 10 113 0 51] 
#[1 0 214 0 2 0 214 0 5 0 214 0 19 10 109 0 20 10 117 0 51] 
#[0 0 218 0 2 0 5 0 19] 
#[0 0 94 0 2 0 5 0 19 0 20] 
#[0 1 50 0 5 0 20 0 24 0 26 0 66] 
#[0 1 30 0 2 0 5 0 20 0 24 0 26 0 66] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 10 121 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 10 125 0 8] 
#[0 10 129 0 8] 
#[1 3 217 0 1 3 221 0 3 10 133 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 10 137 0 19 4 45 0 21] 
#[0 0 182 0 2 0 5 0 20 0 66] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 10 141 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 10 145 0 70] 
#[0 0 194 0 2 0 5 0 20 0 66] 
#[0 0 198 0 2 0 5 0 20 0 66] 
#[0 1 50 0 4 0 20 0 24 0 26] 
#[0 1 30 0 2 0 4 0 20 0 24 0 26] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 10 149 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 10 153 0 8] 
#[0 10 157 0 8] 
#[1 3 217 0 1 3 221 0 3 10 161 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 10 165 0 19 4 45 0 21] 
#[0 0 182 0 2 0 4 0 20] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 10 169 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 10 173 0 70] 
#[0 0 194 0 2 0 4 0 20] 
#[0 0 198 0 2 0 4 0 20] 
#[0 10 177 0 19] 
#[0 0 238 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 238 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 242 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 0 242 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 10 181 0 19] 
#[1 10 185 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[1 10 189 0 20 10 193 0 29] 
#[1 0 138 0 1 0 138 0 3 0 138 0 4 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 14 0 138 0 17 0 138 0 20 0 138 0 21 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 0 138 0 29 0 138 0 30 0 138 0 34 10 197 0 63] 
#[1 0 142 0 19 0 142 0 21 10 201 0 62] 
#[0 0 146 0 2 0 5 0 19 0 20] 
#[0 0 150 0 2 0 5 0 19 0 20] 
#[0 0 146 0 2 0 5 0 19 0 20] 
#[0 0 146 0 2 0 5 0 19 0 20] 
#[0 0 146 0 2 0 5 0 19 0 20] 
#[0 10 205 0 4] 
#[1 10 209 0 9 10 213 0 15 2 249 0 18 10 217 0 19] 
#[0 10 221 0 19] 
#[0 0 162 0 2 0 5 0 19 0 20] 
#[0 0 166 0 2 0 5 0 19 0 20] 
#[0 0 166 0 2 0 5 0 19 0 20] 
#[0 10 225 0 19] 
#[0 0 238 0 2 0 5 0 20 0 66] 
#[0 0 238 0 2 0 5 0 20 0 66] 
#[0 0 242 0 2 0 5 0 20 0 66] 
#[0 0 242 0 2 0 5 0 20 0 66] 
#[0 10 229 0 19] 
#[1 10 233 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[0 10 237 0 19] 
#[0 0 238 0 2 0 4 0 20] 
#[0 0 238 0 2 0 4 0 20] 
#[0 0 242 0 2 0 4 0 20] 
#[0 0 242 0 2 0 4 0 20] 
#[0 10 241 0 19] 
#[1 10 245 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[0 1 50 0 5 0 19 0 20 0 24 0 26] 
#[0 1 30 0 2 0 5 0 19 0 20 0 24 0 26] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 10 249 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 10 253 0 8] 
#[0 11 1 0 8] 
#[1 3 217 0 1 3 221 0 3 11 5 0 4 3 229 0 10 3 233 0 11 3 237 0 12 3 241 0 14 3 245 0 17 3 249 0 20 3 253 0 21 4 1 0 22 4 5 0 23 4 9 0 24 4 13 0 25 4 17 0 26 4 21 0 29 4 25 0 30 4 29 0 34 4 37 0 44 4 37 0 64] 
#[1 11 9 0 19 4 45 0 21] 
#[0 0 182 0 2 0 5 0 19 0 20] 
#[1 0 6 0 1 1 145 0 9 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 14 1 149 0 15 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 29 0 6 0 30 0 6 0 32 0 6 0 33 1 157 0 37 11 13 0 61] 
#[1 0 14 0 9 0 14 0 20 0 14 0 29 0 14 0 32 0 14 0 33 11 17 0 70] 
#[0 0 194 0 2 0 5 0 19 0 20] 
#[0 0 198 0 2 0 5 0 19 0 20] 
#[0 1 50 0 2 0 5 0 20 0 24 0 26 0 66] 
#[0 1 30 0 2 0 5 0 20 0 66] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 11 21 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 1 50 0 2 0 4 0 20 0 24 0 26] 
#[0 1 30 0 2 0 4 0 20] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 11 25 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 11 29 0 19] 
#[0 0 238 0 2 0 5 0 19 0 20] 
#[0 0 238 0 2 0 5 0 19 0 20] 
#[0 0 242 0 2 0 5 0 19 0 20] 
#[0 0 242 0 2 0 5 0 19 0 20] 
#[0 11 33 0 19] 
#[1 11 37 0 9 0 249 0 20 0 253 0 29 1 1 0 32 1 5 0 33 1 9 0 58] 
#[0 11 41 0 19] 
#[0 11 45 0 19] 
#[0 1 50 0 2 0 5 0 19 0 20 0 24 0 26] 
#[0 1 30 0 2 0 5 0 19 0 20] 
#[1 2 133 0 1 2 137 0 10 2 141 0 11 2 145 0 12 2 149 0 14 2 153 0 16 2 157 0 17 0 22 0 19 2 161 0 20 2 165 0 21 2 169 0 22 2 173 0 23 2 177 0 29 2 181 0 30 2 185 0 32 2 189 0 33 11 49 0 36 2 197 0 38 2 201 0 40 2 217 0 42 2 201 0 43 2 213 0 44 2 217 0 46 2 229 0 47 2 225 0 49 2 229 0 57 2 233 0 58 2 237 0 68] 
#[0 1 50 0 2 0 5 0 20 0 66] 
#[0 1 50 0 2 0 4 0 20] 
#[0 11 53 0 19] 
#[0 1 50 0 2 0 5 0 19 0 20]
	).
]
