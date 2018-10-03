"
stmethod

"
Class {
	#name : #SmalltalkParsingLayer,
	#superclass : #QuotedParseLayer,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'template parsing' }
SmalltalkParsingLayer >> makeKeywordMessage2M3 [

makeKeywordMessage2(<>,<>,<>).
makeKeywordMessage2(<key(?firstkey,?firstArg)|?keys>,<?firstkey|?resKey>,<?firstArg|?resArgs>) if 
	makeKeywordMessage2(?keys,?resKey,?resArgs)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> makeKeywordMessageM3 [

makeKeywordMessage(?keywordsAndArguments,?selector,?arguments) if 
	makeKeywordMessage2(?keywordsAndArguments,?keywords,?arguments),makeKeywordSelector(?keywords,?selector)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> makeKeywordSelectorM2 [

makeKeywordSelector(+?list,?selector) if 
	not(equals(?list,<>)),equals(?selector,[| theSelector |
theSelector := ''.
?list listDo: [:el | theSelector := theSelector , el smalltalkValue].
theSelector asSymbol])
]

{ #category : #'template scanning' }
SmalltalkParsingLayer >> scanM3 [

scan(?type,?string,?tokens) if 
	[?type asString matchesPattern: 'st*' ignoreCase: false do: nil],deify(?tokens,[QuotedCodeSmalltalkTokenScanner new breakIntoTokens: ?string])
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> soulListvariableM3 [

soulListvariable(?var,?tokens1,?tokens2) if 
	equals(?tokens1,<xSoulVariable(?varname)|?tokens2>),['*List' match: ?varname],equals(?var,[(Variable name: (?varname allButFirst: 1)) explicitSoulUp])
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> soulvariableM3 [

soulvariable(?var,?tokens1,?tokens2) if 
	equals(?tokens1,<xSoulVariable(?varname)|?tokens2>),[('*List' match: ?varname) not],equals(?var,[(Variable name: (?varname allButFirst: 1)) explicitSoulUp])
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stAssignmentM3 [

stAssignment(RBAssignmentNode(RBVariableNode(?name),?expression),?tokens1,?tokens3) if 
	equals(?tokens1,<word(?name),colon(?),binary([#=])|?tokens2>),stExpression(?expression,?tokens2,?tokens3).
stAssignment(RBAssignmentNode(RBVariableNode(?soulvar),?expression),?tokens1,?tokens4) if 
	soulvariable(?soulvar,?tokens1,?tokens2),equals(?tokens2,<colon(?),binary([#=])|?tokens3>),stExpression(?expression,?tokens3,?tokens4)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBasicexpressionM3 [

stBasicexpression(?result,?tokens1,?tokens2) if 
	stLiteral(?result,?tokens1,?tokens2).
stBasicexpression(?result,?tokens1,?tokens2) if 
	stVariable(?result,?tokens1,?tokens2).
stBasicexpression(?exp,?tokens1,?tokens2) if 
	stBlock(?exp,?tokens1,?tokens2).
stBasicexpression(?var,?tokens1,?tokens2) if 
	soulvariable(?var,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBinariesM4 [

stBinaries(?exp,?result,?tokens1,?tokens3) if 
	stBinary(binary(?message,?arg),?tokens1,?tokens2),stBinaries(RBMessageNode(?exp,?message,<?arg>),?result,?tokens2,?tokens3).
stBinaries(?exp,RBMessageNode(?exp,?message,<?arg>),?tokens1,?tokens2) if 
	stBinary(binary(?message,?arg),?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBinaryM3 [

stBinary(binary(?binary,?expression),?tokens1,?tokens3) if 
	stBinaryterminal(?binary,?tokens1,?tokens2),stUnarymessage(?expression,?tokens2,?tokens3).
stBinary(binary([#-],?num),?tokens1,?tokens2) if 
	equals(?tokens1,<binary([#-]),number(?num)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBinarySelectorM3 [

stBinarySelector(methodHeader(?selector,<?arg>),?tokens1,?tokens2) if 
	stBinarySelector(?selector,?arg,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBinarySelectorM4 [

stBinarySelector(?selector,?arg,?tokens1,?tokens3) if 
	stBinaryterminal(?selector,?tokens1,?tokens2),stWordterminal(?arg,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBinarymessageM3 [

stBinarymessage(?expression,?tokens1,?tokens2) if 
	stUnarymessage(?expression,?tokens1,?tokens2).
stBinarymessage(?result,?tokens1,?tokens3) if 
	stUnarymessage(?expression,?tokens1,?tokens2),stBinaries(?expression,?result,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBinarymessageWithReceiverM4 [

stBinarymessageWithReceiver(?expression,?receiver,?tokens1,?tokens2) if 
	stUnarymessageWithReceiver(?expression,?receiver,?tokens1,?tokens2).

stBinarymessageWithReceiver(?result,?receiver,?tokens1,?tokens2) if 
	stBinaries(?receiver,?result,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBinaryterminalM3 [

stBinaryterminal(?binary,?tokens1,?tokens2) if 
	equals(?tokens1,<binary(?binary)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBlockArgumentsM3 [

stBlockArguments(<?arg|?args>,?tokens1,?tokens4) if 
	equals(?tokens1,<colon(?)|?tokens2>),stVariable(?arg,?tokens2,?tokens3),stBlockArguments(?args,?tokens3,?tokens4).
stBlockArguments(<>,?tokens1,?tokens2) if 
	equals(?tokens1,<verticalBar(?)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stBlockM3 [

stBlock(RBBlockNode(?args,?body),?tokens1,?tokens5) if 
	equals(?tokens1,<leftBracket(?)|?tokens2>),stBlockArguments(?args,?tokens2,?tokens3),stMethodBody(?body,?tokens3,?tokens4),equals(?tokens4,<rightBracket(?)|?tokens5>).

stBlock(RBBlockNode(<>,?body),?tokens1,?tokens4) if 
	equals(?tokens1,<leftBracket(?)|?tokens2>),stMethodBody(?body,?tokens2,?tokens3),equals(?tokens3,<rightBracket(?)|?tokens4>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stCascadedMessagesM4 [

stCascadedMessages(<?keyWordMessage>,?receiver,?tokens1,?tokens3) if 
	stsemicolon(?,?tokens1,?tokens2),stKeywordmessageWithReceiver(?keyWordMessage,?receiver,?tokens2,?tokens3),RBMessageNode(?,?,?) equals: ?keyWordMessage.

stCascadedMessages(<?keyWordMessage|?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),soulvariable(?keyWordMessage,?tokens2,?tokens3),stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4).

stCascadedMessages(<?keyWordMessage|?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),stKeywordmessageWithReceiver(?keyWordMessage,?receiver,?tokens2,?tokens3),RBMessageNode(?,?,?) equals: ?keyWordMessage,stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4).

stCascadedMessages(<?keyWordMessage,?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),soulvariable(?keyWordMessage,?tokens2,?tokens3),stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4),not(list(?cascadedMessages)).

stCascadedMessages(<?keyWordMessage,?cascadedMessages>,?receiver,?tokens1,?tokens4) if 
	stsemicolon(?,?tokens1,?tokens2),stKeywordmessageWithReceiver(?keyWordMessage,?receiver,?tokens2,?tokens3),RBMessageNode(?,?,?) equals: ?keyWordMessage,stCascadedMessages(?cascadedMessages,?receiver,?tokens3,?tokens4),not(list(?cascadedMessages)).

stCascadedMessages(?keyWordMessage,?receiver,?tokens1,?tokens3) if 
	stsemicolon(?,?tokens1,?tokens2),soulvariable(?keyWordMessage,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stCascademessageM3 [

stCascademessage(?keyWordMessage,?tokens1,?tokens2) if 
	stKeywordmessage(?keyWordMessage,?tokens1,?tokens2).

stCascademessage(RBCascadeNode(<?keyWordMessage|?cascadedMessages>),?tokens1,?tokens3) if 
	stKeywordmessage(?keyWordMessage,?tokens1,?tokens2),RBMessageNode(?receiver,?,?) equals: ?keyWordMessage,stCascadedMessages(?cascadedMessages,?receiver,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stExpressionM3 [

stExpression(?exp,?tokens1,?tokens2) if 
	stAssignment(?exp,?tokens1,?tokens2).
stExpression(?exp,?tokens1,?tokens2) if 
	stCascademessage(?exp,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stKeywordSelector2M4 [

stKeywordSelector2(<?selector|?nextSelectors>,<?arg|?nextArgs>,?tokens1,?tokens4) if 
	stKeywordterminal(?selector,?tokens1,?tokens2),stVariable(?arg,?tokens2,?tokens3),stKeywordSelector2(?nextSelectors,?nextArgs,?tokens3,?tokens4).

stKeywordSelector2(<?selector>,<?arg>,?tokens1,?tokens3) if 
	stKeywordterminal(?selector,?tokens1,?tokens2),stVariable(?arg,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stKeywordSelectorM3 [

stKeywordSelector(methodHeader(?selector,?args),?tokens1,?tokens3) if 
	stKeywordSelector2(?selectorList,?args,?tokens1,?tokens2),and({makeKeywordSelector(?selectorList,?selector)},equals(?tokens2,?tokens3))
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stKeywordmessageM3 [

stKeywordmessage(?binaryMessage,?tokens1,?tokens2) if 
	stBinarymessage(?binaryMessage,?tokens1,?tokens2).
stKeywordmessage(RBMessageNode(?binaryMessage,?selector,?arguments),?tokens1,?tokens4) if 
	stBinarymessage(?binaryMessage,?tokens1,?tokens2),stKeywords(?keys,?tokens2,?tokens3),and({makeKeywordMessage(?keys,?selector,?arguments)},equals(?tokens3,?tokens4)).
stKeywordmessage(RBMessageNode(?receiver,?var,<?argumentexpression>),?tokens1,?tokens4) if 
	stBinarymessage(?receiver,?tokens1,?tokens2),soulvariable(?var,?tokens2,?tokens3),stBinarymessage(?argumentexpression,?tokens3,?tokens4)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stKeywordmessageWithReceiverM4 [

stKeywordmessageWithReceiver(?binaryMessage,?receiver,?tokens1,?tokens2) if 
	stBinarymessageWithReceiver(?binaryMessage,?receiver,?tokens1,?tokens2).

stKeywordmessageWithReceiver(RBMessageNode(?receiver,?selector,?arguments),?receiver,?tokens1,?tokens3) if 
	stKeywords(?keys,?tokens1,?tokens2),and({makeKeywordMessage(?keys,?selector,?arguments)},equals(?tokens2,?tokens3)).

stKeywordmessageWithReceiver(RBMessageNode(?receiver,?var,<?argumentexpression>),?receiver,?tokens1,?tokens3) if 
	soulvariable(?var,?tokens1,?tokens2),stBinarymessage(?argumentexpression,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stKeywordsM3 [

stKeywords(<key(?keyword,?expression)>,?tokens1,?tokens3) if 
	stKeywordterminal(?keyword,?tokens1,?tokens2),stBinarymessage(?expression,?tokens2,?tokens3).
stKeywords(<key(?keyword,?expression)|?keywords>,?tokens1,?tokens4) if 
	stKeywordterminal(?keyword,?tokens1,?tokens2),stBinarymessage(?expression,?tokens2,?tokens3),stKeywords(?keywords,?tokens3,?tokens4)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stKeywordterminalM3 [

stKeywordterminal(?word,?tokens1,?tokens2) if 
	equals(?tokens1,<keyword(?word)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stLiteralM3 [

stLiteral(RBLiteralValueNode(true),?tokens1,?tokens2) if 
	equals(?tokens1,<word(true)|?tokens2>).
stLiteral(RBLiteralValueNode(false),?tokens1,?tokens2) if 
	equals(?tokens1,<word(false)|?tokens2>).
stLiteral(RBLiteralValueNode(nil),?tokens1,?tokens2) if 
	equals(?tokens1,<word(nil)|?tokens2>).
stLiteral(RBLiteralValueNode(?num),?tokens1,?tokens2) if 
	equals(?tokens1,<number(?num)|?tokens2>).
stLiteral(RBLiteralValueNode(?char),?tokens1,?tokens2) if 
	equals(?tokens1,<character(?char)|?tokens2>).
stLiteral(RBLiteralValueNode(?num),?tokens1,?tokens2) if 
	equals(?tokens1,<binary([#-]),number(?num)|?tokens2>).
stLiteral(RBLiteralValueNode(?string),?tokens1,?tokens2) if 
	equals(?tokens1,<string(?string)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stMethodBodyM3 [

stMethodBody(RBSequenceNode(?temporaries,?statements),?tokens1,?tokens3) if 
	stTemporaries(?temporaries,?tokens1,?tokens2),stStatementList(?statements,?tokens2,?tokens3).
stMethodBody(RBSequenceNode(<>,?statements),?tokens1,?tokens2) if 
	stStatementList(?statements,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stMethodHeaderM3 [

stMethodHeader(methodHeader(?selector,<>),?tokens1,?tokens2) if 
	stUnarySelector(?selector,?tokens1,?tokens2).
stMethodHeader(methodHeader(?selector,?args),?tokens1,?tokens2) if 
	stBinarySelector(methodHeader(?selector,?args),?tokens1,?tokens2).
stMethodHeader(methodHeader(?selector,?args),?tokens1,?tokens2) if 
	stKeywordSelector(methodHeader(?selector,?args),?tokens1,?tokens2).
stMethodHeader(methodHeader(?selector,?args),?tokens1,?tokens2) if 
	stTemplateSelector(methodHeader(?selector,?args),?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stMethodM3 [

stMethod(RBMethodNode(?selector,?arguments,?body),?tokens1,?tokens3) if 
	stMethodHeader(methodHeader(?selector,?arguments),?tokens1,?tokens2),stMethodBody(?body,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stReturnM3 [

stReturn(RBReturnNode(?expression),?tokens1,?tokens3) if 
	equals(?tokens1,<upArrow(?)|?tokens2>),stExpression(?expression,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stStatementList2M3 [

stStatementList2(<?statement|?nextStatements>,?tokens1,?tokens4) if 
	stStatement(?statement,?tokens1,?tokens2),equals(?tokens2,<period(?)|?tokens3>),stStatementList2(?nextStatements,?tokens3,?tokens4).
stStatementList2(<?statement>,?tokens1,?tokens2) if 
	stStatement(?statement,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stStatementListM3 [

stStatementList(?var,?tokens1,?tokens2) if 
	soulvariable(?var,?tokens1,?tokens2).
stStatementList(?statements,?tokens1,?tokens2) if 
	stStatementList2(?statements,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stStatementM3 [

stStatement(?statement,?tokens1,?tokens2) if 
	stReturn(?statement,?tokens1,?tokens2).
stStatement(?statement,?tokens1,?tokens2) if 
	stExpression(?statement,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stTemplateSelectorArgumentListM3 [

stTemplateSelectorArgumentList(<?arg>,?tokens1,?tokens2) if 
	stWordterminal(?arg,?tokens1,?tokens2).
stTemplateSelectorArgumentList(<?arg|?rest>,?tokens1,?tokens4) if 
	stWordterminal(?arg,?tokens1,?tokens2),equals(?tokens2,<binary([#,])|?tokens3>),stTemplateSelectorArgumentList(?rest,?tokens3,?tokens4).
stTemplateSelectorArgumentList(?arg,?tokens1,?tokens2) if 
	soulListvariable(?arg,?tokens1,?tokens2).
stTemplateSelectorArgumentList(<?arg>,?tokens1,?tokens2) if 
	stVariable(?arg,?tokens1,?tokens2).
stTemplateSelectorArgumentList(<?arg|?rest>,?tokens1,?tokens4) if 
	stVariable(?arg,?tokens1,?tokens2),equals(?tokens2,<binary([#,])|?tokens3>),stTemplateSelectorArgumentList(?rest,?tokens3,?tokens4)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stTemplateSelectorM3 [

stTemplateSelector(methodHeader(?selector,?args),?tokens1,?tokens5) if 
	stWordterminal(?selector,?tokens1,?tokens2),equals(?tokens2,<leftParenthesis(?)|?tokens3>),stTemplateSelectorArgumentList(?args,?tokens3,?tokens4),equals(?tokens4,<rightParenthesis(?)|?tokens5>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stTemporaries2M3 [

stTemporaries2(<?temp|?nextList>,?tokens1,?tokens3) if 
	stWordterminal(?temp,?tokens1,?tokens2),stTemporaries2(?nextList,?tokens2,?tokens3).
stTemporaries2(<>,?tokens1,?tokens2) if 
	equals(?tokens1,<verticalBar(?)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stTemporariesM3 [

stTemporaries(?temporariesList,?tokens1,?tokens2) if 
	soulvariable(?temporariesList,?tokens1,?tokens2).
stTemporaries(?temporariesList,?tokens1,?tokens3) if 
	equals(?tokens1,<verticalBar(?)|?tokens2>),stTemporaries2(?temporariesList,?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stUnariesM4 [

stUnaries(?exp,?result,?tokens1,?tokens3) if 
	stWordterminal(?message,?tokens1,?tokens2),stUnaries(RBMessageNode(?exp,?message,<>),?result,?tokens2,?tokens3).
stUnaries(?exp,RBMessageNode(?exp,?message,<>),?tokens1,?tokens2) if 
	stWordterminal(?message,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stUnarySelectorM3 [

stUnarySelector(?selector,?tokens1,?tokens2) if 
	stWordterminal(?selector,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stUnarymessageM3 [

stUnarymessage(?expression,?tokens1,?tokens2) if 
	stBasicexpression(?expression,?tokens1,?tokens2).
stUnarymessage(?result,?tokens1,?tokens3) if 
	stBasicexpression(?expression,?tokens1,?tokens2),stUnaries(?expression,?result,?tokens2,?tokens3).
stUnarymessage(RBMessageNode(?exp,?selector,?args),?tokens1,?tokens3) if 
	stBasicexpression(?exp,?tokens1,?tokens2),stTemplateSelector(methodHeader(?selector,?args),?tokens2,?tokens3)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stUnarymessageWithReceiverM4 [

stUnarymessageWithReceiver(?expression,?receiver,?tokens1,?tokens2) if 
	stBasicexpression(?expression,?tokens1,?tokens2).

stUnarymessageWithReceiver(?result,?receiver,?tokens1,?tokens2) if 
	stUnaries(?receiver,?result,?tokens1,?tokens2).

stUnarymessageWithReceiver(RBMessageNode(?receiver,?selector,?args),?receiver,?tokens1,?tokens2) if 
	stTemplateSelector(methodHeader(?selector,?args),?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stVariableM3 [

stVariable(RBVariableNode(?name),?tokens1,?tokens2) if 
	stWordterminal(?name,?tokens1,?tokens2)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stWordterminalM3 [

stWordterminal(?word,?tokens1,?tokens2) if 
	equals(?tokens1,<word(?word)|?tokens2>).
stWordterminal(?var,?tokens1,?tokens2) if 
	soulvariable(?var,?tokens1,?tokens2)
]

{ #category : #'template compilation' }
SmalltalkParsingLayer >> statementsUnderInterpretationXcompilesToXforResultXM4 [

<> statementsUnderInterpretation: ? compilesTo: <> forResult: ?.
<?firstTemplateStatement|?restTemplateStatements> statementsUnderInterpretation: ? compilesTo: <?firstTemplateStatement foundIn: ?statements withRest: ?restStatements|?query> forResult: ?statements if 
	not(?firstTemplateStatement equals: RBMessageNode(?,?,?args),?args contains: RBBlockNode(?,?)),?restStatements isNewQuotedVariable,?restTemplateStatements statementsUnderInterpretation: ? compilesTo: ?query forResult: ?restStatements.
"?args contains: RBBlockNode(?,?),"

<?firstTemplateStatement|?restTemplateStatements> statementsUnderInterpretation: ? compilesTo: <?firstTemplateStatement isMessageSendIn: ?statements withRest: ?restStatements|?query> forResult: ?statements if 
	?firstTemplateStatement equals: RBMessageNode(?,?,?args),?restStatements isNewQuotedVariable,?restTemplateStatements statementsUnderInterpretation: ? compilesTo: ?query forResult: ?restStatements.
?statements statementsUnderInterpretation: ? compilesTo: <?statements equals: ?statements2> forResult: ?statements2 if 
	?statements isQuotedVariable
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stperiodM3 [

stperiod(?period,?tokens1,?tokens2) if 
	equals(?tokens1,<period(?period)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stsemicolonM3 [

stsemicolon(semicolon(?x),?tokens1,?tokens2) if 
	equals(?tokens1,<semicolon(?x)|?tokens2>)
]

{ #category : #'template parsing' }
SmalltalkParsingLayer >> stwordM3 [

stword(?word,?tokens1,?tokens2) if 
	equals(?tokens1,<word(?word)|?tokens2>)
]

{ #category : #'template compilation' }
SmalltalkParsingLayer >> templateUnderInterpretationXcompilesToXforResultXM4 [

RBMethodNode(?selector,?args,?templatebody) templateUnderInterpretation: ?interpretation compilesTo: <?result isMethodWithName: ?selector inClass: ?class,RBMethodNode(?selector,?args,?body) isParseTreeOfMethod: ?result|?bodyquery> forResult: ?result if 
	?result isNewQuotedVariable,?class isNewQuotedVariable,?body isNewQuotedVariable,?templatebody templateUnderInterpretation: ?interpretation compilesTo: ?bodyquery forResult: ?body.

RBSequenceNode(?templatetemps,?templatestatements) templateUnderInterpretation: ? compilesTo: <?result equals: RBSequenceNode(?temps,?statements),sublistOf(?templatetemps,?temps)|?statementsQuery> forResult: ?result if 
	?temps isNewQuotedVariable,?statements isNewQuotedVariable,?templatestatements statementsUnderInterpretation: ? compilesTo: ?statementsQuery forResult: ?statements
]
