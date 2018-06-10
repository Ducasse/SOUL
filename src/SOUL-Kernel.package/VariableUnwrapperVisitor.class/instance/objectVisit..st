visiting terms
objectVisit: anObject
	
	| rest |
	^((anObject smalltalkValue isKindOf: Symbol)
		and: ['MetaVar*' match: anObject smalltalkValue])
		ifTrue:
			[rest := anObject smalltalkValue allButFirst: 7.
			('Var*' match: rest)
				ifTrue: [HiddenVariable name: rest]
				ifFalse: [Variable name: rest]]
		ifFalse: [anObject]