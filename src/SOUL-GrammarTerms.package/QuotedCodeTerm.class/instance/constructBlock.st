private
constructBlock
	"This method constructs the SmalltalkBlock to be executed if the  
	quotedcode needs to be downed to a string"

	
	| sourceCode blockNode temporaries statements compactedContent |
	compactedContent := self compactedContent.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: '[:env :envIndex '.
	variables size > 2
		ifTrue:
			[(3 to: variables size)
				do:
					[:index | sourceCode nextPutAll: ':arg' , (variables at: index) name , ' ']].
	sourceCode nextPutAll: ' | '.
	compactedContent isEmpty
		ifTrue: [sourceCode nextPutAll: '''''']
		ifFalse:
			[compactedContent
				do: [:el | sourceCode nextPutAll: el smalltalkBlockString]
				separatedBy: [sourceCode nextPutAll: ' , ']].
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
									'soulvar' , (variables at: index) name , ' := ' , 'arg'
										, (variables at: index) name ,
											' asSourceStringIn: env startAt: envIndex.')].
			blockNode body statements: statements.
			blockNode body temporaries: temporaries.
			block := self compilerForSmalltalkTermBlocks
				evaluate: blockNode formattedCode]
		ifFalse:
			[block := self compilerForSmalltalkTermBlocks evaluate: sourceCode contents]