Class {
	#name : #SmalltalkTemplateRuntimeLayer,
	#superclass : #QuotedParseLayer,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'template runtime' }
SmalltalkTemplateRuntimeLayer >> foundInXwithRestXM3 [

+?statement foundIn: <?statement|?next> withRest: ?next.
?statement foundIn: <?first|?next> withRest: ?nextStatements if 
	not(?statement equals: ?first),?statement foundIn: ?next withRest: ?nextStatements
]

{ #category : #'template runtime' }
SmalltalkTemplateRuntimeLayer >> isMessageSendInXwithRestXM3 [

RBMessageNode(?receiver,?selector,?arguments) isMessageSendIn: <RBMessageNode(?receiver,?selector,?matchedArguments)|?next> withRest: ?next if 
	?matchedArguments contains: RBBlockNode(?,?),?matchedArguments matchesArguments: ?arguments.
RBMessageNode(?receiver,?selector,?arguments) isMessageSendIn: <RBMessageNode(?receiver,?selector,?arguments)|?next> withRest: ?next if 
	not(?arguments contains: RBBlockNode(?,?)).
?statement isMessageSendIn: <RBReturnNode(?statement)|?next> withRest: ?next.
?statement isMessageSendIn: <?first|?next> withRest: ?nextStatements if 
	?statement isMessageSendIn: ?next withRest: ?nextStatements
]

{ #category : #'template runtime' }
SmalltalkTemplateRuntimeLayer >> matchesArgumentsXM2 [

<> matchesArguments: <>.
<?blockArgMatch|?restMatchedArguments> matchesArguments: <?blockArg|?restArgs> if 
	?blockArgMatch equals: RBBlockNode(?t,RBSequenceNode(?,?statements)),?blockArg equals: RBBlockNode(?t,RBSequenceNode(?,?matchStatements)),?matchStatements matchesStatements: ?statements,?restMatchedArguments matchesArguments: ?restArgs.
<?argument|?restMatchedArguments> matchesArguments: <?argument|?restArgs> if 
	?restMatchedArguments matchesArguments: ?restArgs
]

{ #category : #'template runtime' }
SmalltalkTemplateRuntimeLayer >> matchesStatementsXM2 [

<> matchesStatements: <>.
<?match|?matchingStatements> matchesStatements: ?statements if 
	?match foundIn: ?statements withRest: ?rest,?matchingStatements matchesStatements: ?rest
]
