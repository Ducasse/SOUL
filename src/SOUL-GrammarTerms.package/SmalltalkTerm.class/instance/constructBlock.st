private
constructBlock
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