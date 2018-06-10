visiting terms
constantVisit: aConstant
	
	| rest |
	^('MetaVar*' match: aConstant name)
		ifTrue:
			[rest := aConstant name allButFirst: 7.
			('Var*' match: rest)
				ifTrue: [HiddenVariable name: rest]
				ifFalse: [Variable name: rest]]
		ifFalse: [aConstant class up: aConstant smalltalkValue]