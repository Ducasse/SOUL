private
processPatternVariable: aVariableNode
	
	| name |
	name := self skipNonAlphabeticCharacters: aVariableNode name.
	^aVariableNode isStatement
		ifTrue:
			[self
				makeCompoundTerm: 'listOfStatements'
				withTerm: (Variable name: name)]
		ifFalse: [Variable name: name]