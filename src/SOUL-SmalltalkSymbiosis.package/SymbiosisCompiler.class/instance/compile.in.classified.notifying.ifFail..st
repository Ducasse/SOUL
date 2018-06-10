compilation
compile: aCode in: aClass classified: aCategory notifying: aRequestor ifFail: aFailBlock
	
	| method input |
	input := aCode contents.
	method := RBParser parseMethod: input.
	(RBReadBeforeWrittenTester variablesReadBeforeWrittenIn: method)
		do:
			[:temp | 
			method body
				addNodeFirst:
					(RBParser parseExpression: temp , ' := UninitializedTemporary new.')].
	^super
		compile: method formattedCode
		in: aClass
		classified: aCategory
		notifying: aRequestor
		ifFail: aFailBlock