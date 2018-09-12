information extraction
rbParseTree
	
	| myClass |
	myClass := self fromClass.
	parsetree == nil
		ifTrue:
			[parsetree := myClass compilerClass = Object compilerClass
				ifTrue:
					[RBParser
						parseMethod: self sourceCode
						onError: [:mesg :pos | ^nil]]
				ifFalse:
					["Soul.SmalltalkParseTreeConverter new doString: self selector inClass: myClass"

					^nil]].
	parsetree method: self.
	^parsetree