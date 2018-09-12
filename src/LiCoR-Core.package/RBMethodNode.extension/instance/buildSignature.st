*LiCoR-Core
buildSignature
	
	| sourceCode keywords aSelector argumentNames |
	aSelector := self selector.
	argumentNames := self argumentNames.
	aSelector isUnary
		ifTrue: [sourceCode := aSelector asString]
		ifFalse:
			[aSelector isInfix
				ifTrue: [sourceCode := aSelector asString , ' ' , argumentNames first]
				ifFalse:
					[keywords := aSelector keywords.
					sourceCode := ''.
					1
						to: keywords size
						do:
							[:n | 
							| keyword |
							keyword := keywords at: n.
							sourceCode := sourceCode , keyword , ' ' , (argumentNames at: n) ,
									' ']]].
	^sourceCode trimBlanks